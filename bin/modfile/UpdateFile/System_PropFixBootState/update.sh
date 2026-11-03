#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
#
# Ghi de trang thai bootloader o tang VUNG PROPERTY, chay bang init `exec` ngay
# trong ROM - khong can Magisk/KernelSU, khong can nguoi dung root may.
#
# VI SAO CAN TANG NAY
#   Tren base OS4, bootloader cong bo androidboot.verifiedbootstate=orange truoc
#   khi userspace chay, va `ro.*` la prop ghi-mot-lan. Da thu va deu thua:
#
#     vendor_boot cmdline        -> bi bo (bootloader dat truoc)
#     prop/build.prop            -> bi bo (cung ly do)
#     hook SystemProperties Java -> chay dung (Settings hien "da khoa") nhung
#                                   VNeID van CA-E006
#     wrapper /system/bin/getprop -> co trong ROM, chay dung, VNeID van CA-E006
#     resetprop 6 prop (root)    -> VNeID HET CA-E006, Play Store sach hop thoai
#
#   Tuc la chi co ghi thang vao kho prop moi thang. Ban OS3 pass duoc vi
#   bootloader base do khong cong bo prop nay (xem ghi chu trong config.env).
#
# CACH LAM
#   bin/package/BugOSPropFix/bugos_propfix.c duoc bien dich san thanh binary
#   arm64 o buoc "Build prop-fix helper" trong workflow (may build khong co
#   compiler cross). Function doc thang dinh dang /dev/__properties__/*, khong
#   dung bionic, nen build bang aarch64-linux-gnu-gcc -static la du - khong can
#   NDK ~5GB (runner tung het dia ngay luc unzip NDK).
#   Mod nay copy binary vao /system/bin, them init `exec`, va patch SELinux
#   policy cho phep init exec binary do.
#
#   Vi sao phai patch policy: root KHONG du. Doc plat_sepolicy.cil tren may:
#     (allow init property_data_file (file (... write ... map ...)))  <- co
#     (allow su   property_data_file ...)                            <- khong co
#   Nen service seclabel su:s0 chay duoc nhung ghi prop that bai. Chi init ghi
#   duoc, vi init la chu vung property. Muon binary chay trong domain init thi
#   phai `exec` khong transition - va policy phai cho init exec system_file
#   (mac dinh bi chan: avc denied { execute_no_trans }).
#
#   Binary chay 2 lan: post-fs-data (som) va boot_completed (du phong).
#   Idempotent nen chay lai khong sao. Loi thi chi ghi log roi thoat, KHONG
#   boot loop.
#
# Bat/tat bang prop_fix_boot_state trong config.env.

work_dir=$(pwd)
source "$work_dir/functions.sh"

ENABLE=$(grep -m1 '^prop_fix_boot_state=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$ENABLE" = "false" ]; then
    mods "PropFix: bỏ qua (prop_fix_boot_state=false)"
    exit 0
fi

SRC="$work_dir/bin/package/BugOSPropFix/bugos_propfix"
IMG="$work_dir/build/baserom/images"
DEST_BIN="$IMG/system/system/bin/bugos_propfix"
DEST_RC="$IMG/system_ext/etc/init/init.bugos.propfix.rc"

if [ ! -f "$SRC" ]; then
    warn "PropFix: chưa có binary arm64 ($SRC) - bỏ qua"
    warn "PropFix: workflow phải chạy bước 'Build prop-fix helper' trước build.sh"
    exit 0
fi

# Binary phải là arm64, không phải binary của máy build (x86_64)
if command -v file >/dev/null 2>&1; then
    if ! file "$SRC" | grep -qi "aarch64\|ARM aarch64"; then
        warn "PropFix: $SRC không phải binary arm64 - bỏ qua ($(file -b "$SRC"))"
        exit 0
    fi
fi

mkdir -p "$(dirname "$DEST_BIN")" "$(dirname "$DEST_RC")" || {
    warn "PropFix: tạo thư mục đích thất bại - bỏ qua"; exit 0; }

cp -f "$SRC" "$DEST_BIN" || { warn "PropFix: copy binary thất bại - bỏ qua"; exit 0; }
chmod 0755 "$DEST_BIN" || { warn "PropFix: chmod binary thất bại - bỏ qua"; exit 0; }

# ---------------------------------------------------------------------------
# SELinux: init bị cấm exec file system_file
#
# Log thật trên máy (annibale):
#   avc: denied { execute_no_trans } for comm="init"
#        path="/system/bin/bugos_propfix"
#        scontext=u:r:init:s0 tcontext=u:object_r:system_file:s0
#
# Và trong policy chỉ có:
#   (allow init property_data_file (file (... write ... map ...)))
#   (allow su   property_data_file ...)   <- KHÔNG có
#
# Nên: chạy bằng root/su KHÔNG ghi được vùng property. Chỉ domain init ghi
# được. Vì vậy phải cho init exec binary của mod (exec không transition domain
# -> con ở lại u:r:init:s0), rồi binary tự ghi vùng property.
#
# ROM này KHÔNG có precompiled_sepolicy và KHÔNG có /sepolicy ở ramdisk - init
# biên dịch policy từ các file .cil text mỗi lần boot, nên thêm một dòng vào
# plat_sepolicy.cil là có hiệu lực. Kiểm tra lại bằng:
#   adb shell ls /system/etc/selinux/precompiled_sepolicy   -> phải không tồn tại
# ---------------------------------------------------------------------------
CIL="$IMG/system/system/etc/selinux/plat_sepolicy.cil"
# Mốc phải là chính dòng rule, không phải tên gợi nhớ: bản trước dùng
# "bugos_propfix_exec" nhưng chuỗi đó không có trong phần được chèn, nên lần
# build nào cũng chèn lại và luôn báo "ghi thất bại".
CIL_MARK='(allow init system_file (file (execute execute_no_trans)))'

if [ -f "$CIL" ]; then
    if grep -Fq "$CIL_MARK" "$CIL"; then
        mods "SELinux: plat_sepolicy.cil đã patch trước đó - bỏ qua"
    else
        cat >> "$CIL" << 'CILEOF'

; BugOS propfix - cho init exec binary cua mod.
; Thieu rule nay: avc denied { execute_no_trans } init -> system_file,
; binary khong bao gio duoc nap, prop giu nguyen orange.
(allow init system_file (file (execute execute_no_trans)))
CILEOF
        if grep -Fq "$CIL_MARK" "$CIL"; then
            mods "SELinux: đã cho init exec /system/bin/bugos_propfix"
        else
            warn "SELinux: ghi plat_sepolicy.cil thất bại - propfix sẽ không chạy"
        fi
    fi
else
    warn "SELinux: không thấy $CIL - propfix sẽ bị chặn exec"
fi

cat > "$DEST_RC" << 'RCEOF'
# BugOS - ghi de trang thai bootloader o tang vung property.
# Xem bin/modfile/UpdateFile/System_PropFixBootState/update.sh
#
# Chi dung `exec`, KHONG dung service. Ly do, do tu policy tren may:
#   (allow init property_data_file (file (... write ... map ...)))   <- co
#   (allow su   property_data_file ...)                            <- khong co
# Nen service seclabel su:s0 (root) van KHONG ghi duoc vung property. Chi con
# cach de init exec truc tiep: exec khong transition domain, process o lai
# u:r:init:s0, va init la chu vung property nen ghi duoc.
#
# De exec duoc thi policy phai co rule cho init exec system_file - update.sh
# patch plat_sepolicy.cil. Thieu rule do thi se thay:
#   avc: denied { execute_no_trans } comm="init" ... tcontext=u:object_r:system_file:s0
#
# Chay 2 lan (post-fs-data + boot_completed) vi binary idempotent; lan sau chi
# ghi lai neu co gi do ghi de.

on post-fs-data
    exec -- /system/bin/bugos_propfix

on property:sys.boot_completed=1
    exec -- /system/bin/bugos_propfix
RCEOF

chmod 0644 "$DEST_RC"

if grep -q "exec -- /system/bin/bugos_propfix" "$DEST_RC" && [ -x "$DEST_BIN" ]; then
    mods "PropFix: /system/bin/bugos_propfix + exec từ init (ghi thẳng kho prop)"
else
    warn "PropFix: cài đặt không như mong đợi - kiểm tra $DEST_RC"
fi
