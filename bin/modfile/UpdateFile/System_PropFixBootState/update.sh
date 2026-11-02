#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
#
# Ghi de trang thai bootloader o tang VUNG PROPERTY, bang mot init service chay
# duoi quyen root ngay trong ROM - khong can Magisk/KernelSU, khong can nguoi
# dung root may.
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
#   arm64 o buoc "Build prop-fix helper" trong workflow (may build khong co NDK).
#   Mod nay chi copy binary vao /system/bin va them init service.
#
#   Service chay 2 lan: post-fs-data (som) va boot_completed (du phong). Binary
#   idempotent nen chay lai khong sao.
#
#   Hai service cung tro ve mot binary, khac seclabel: u:r:su:s0 va u:r:init:s0.
#   Ly do: khong biet chac domain nao duoc phep vua exec binary vua ghi vung
#   property. Cai nao chay duoc thi thang; cai con lai chi log loi SELinux roi
#   thoat, KHONG anh huong boot.
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

cat > "$DEST_RC" << 'RCEOF'
# BugOS - ghi de trang thai bootloader o tang vung property.
# Xem bin/modfile/UpdateFile/System_PropFixBootState/update.sh
#
# Hai service cung mot binary, khac seclabel. Cai nao duoc SELinux cho phep thi
# chay; cai con lai init se log loi va bo qua, may van boot binh thuong.
# Binary oneshot + idempotent nen chay lai nhieu lan khong sao.

service bugos_propfix_su /system/bin/bugos_propfix
    class late_start
    user root
    group root system
    oneshot
    seclabel u:r:su:s0
    disabled

service bugos_propfix_init /system/bin/bugos_propfix
    class late_start
    user root
    group root system
    oneshot
    seclabel u:r:init:s0
    disabled

on post-fs-data
    start bugos_propfix_su
    start bugos_propfix_init

on property:sys.boot_completed=1
    start bugos_propfix_su
    start bugos_propfix_init
RCEOF

chmod 0644 "$DEST_RC"

if grep -q "start bugos_propfix_su" "$DEST_RC" && [ -x "$DEST_BIN" ]; then
    mods "PropFix: /system/bin/bugos_propfix + init service (ghi thẳng kho prop, không cần root)"
else
    warn "PropFix: cài đặt không như mong đợi - kiểm tra $DEST_RC"
fi
