#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
# ---------------------------------------------------------------------------
# KernelSU Next 3.4.2 - root sẵn trong ROM (chế độ LKM)
#
# Vì sao LKM chứ không thay kernel GKI:
#   boot.img của annibale chứa kernel 6.6.118-android15-8-g0908354dac1b do
#   Xiaomi vá, và vendor_dlkm có các module phải khớp vermagic. Thay bằng
#   kernel GKI chung gần như chắc chắn mất boot. LKM chỉ chèn module
#   kernelsu.ko vào chính kernel đó dưới dạng "capsule" (ksud boot-patch-v2
#   đọc kallsyms của kernel rồi tự giải relocation), không đụng tới ramdisk
#   và không đụng init_boot.
#
# Vì sao phải chạy TRƯỚC patchpackage.sh:
#   patchpackage.sh -> DISABLE_AVB tính lại vbmeta trên các image hiện có.
#   Vá boot.img sau bước đó là vbmeta lệch với boot.img.
#
# Bật/tắt bằng cờ kernelsu trong config.env.
# ---------------------------------------------------------------------------

work_dir=$(pwd)
source "$work_dir/functions.sh"

KSU_VER=3.4.2
KSU_BUILD=33355
KSU_KMI=android15-6.6
BASE="https://github.com/KernelSU-Next/KernelSU-Next/releases/download/v${KSU_VER}"

IMG="$work_dir/build/baserom/images"
CACHE="$work_dir/.ksu_cache"

ENABLE=$(grep -m1 '^kernelsu=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$ENABLE" = "false" ]; then
    mods "KernelSU: bỏ qua (kernelsu=false)"
    exit 0
fi

BOOT="$IMG/boot.img"
if [ ! -f "$BOOT" ]; then
    warn "KernelSU: không thấy $BOOT - bỏ qua, ROM sẽ không có root"
    exit 0
fi

mkdir -p "$CACHE" || { error "KernelSU: không tạo được $CACHE"; exit 1; }

# Tải + kiểm kích thước tối thiểu. Không có checksum chính thức từ upstream,
# nên đây là chốt chặn duy nhất: file cụt hoặc trang lỗi HTML sẽ bị loại.
fetch() {
    local url="$1" out="$2" min="$3" sz
    if [ -s "$out" ]; then
        sz=$(stat -c%s "$out" 2>/dev/null || echo 0)
        [ "$sz" -ge "$min" ] && return 0
    fi
    mods "KernelSU: tải $(basename "$out")"
    rm -f "$out"
    curl -fL --retry 3 --retry-delay 5 --connect-timeout 30 --max-time 600 \
        -o "$out" "$url" || return 1
    sz=$(stat -c%s "$out" 2>/dev/null || echo 0)
    if [ "$sz" -lt "$min" ]; then
        warn "KernelSU: $(basename "$out") chỉ $sz byte (cần >= $min) - file hỏng?"
        return 1
    fi
    return 0
}

KSUSD="$CACHE/ksud"
KO="$CACHE/kernelsu.ko"
APK="$CACHE/KernelSUNext.apk"

fetch "$BASE/ksud-x86_64-unknown-linux-musl"                "$KSUSD" 5000000  || { error "KernelSU: không tải được ksud"; exit 1; }
fetch "$BASE/aarch64_${KSU_KMI}_kernelsu.ko"                "$KO"    300000   || { error "KernelSU: không tải được kernelsu.ko cho $KSU_KMI"; exit 1; }
fetch "$BASE/KernelSU_Next_v${KSU_VER}_${KSU_BUILD}-release.apk" "$APK" 10000000 || { error "KernelSU: không tải được manager APK"; exit 1; }

chmod 0755 "$KSUSD"

# Kiểm KMI của module có khớp kernel trong boot.img không, trước khi vá.
# Lệch KMI thì boot-patch-v2 vẫn có thể chạy nhưng kernel sẽ không nạp được
# module - hỏng lúc boot chứ không hỏng lúc build, nên cảnh báo sớm ở đây.
# Kernel báo "6.6.118-android15-8-g...", KMI của KSU là "android15-6.6":
# hai chuỗi khác định dạng nên phải tách ra rồi so từng phần.
BOOT_VER=$(strings "$BOOT" 2>/dev/null | grep -m1 -oE "[0-9]+\.[0-9]+\.[0-9]+-android[0-9]+-[0-9]+" || true)
if [ -n "$BOOT_VER" ]; then
    boot_android=$(printf '%s' "$BOOT_VER" | grep -oE "android[0-9]+" | head -1)
    boot_kver=$(printf '%s' "$BOOT_VER" | grep -oE "^[0-9]+\.[0-9]+" | head -1)
    ksu_android=${KSU_KMI%%-*}
    ksu_kver=${KSU_KMI##*-}
    mods "KernelSU: kernel '$BOOT_VER' -> ${boot_android}-${boot_kver}; module '${ksu_android}-${ksu_kver}'"
    if [ "$boot_android" != "$ksu_android" ] || [ "$boot_kver" != "$ksu_kver" ]; then
        warn "KernelSU: KMI lệch - module có thể không nạp được. Sửa KSU_KMI trong bin/package/KernelSU/patch.sh"
    fi
fi

OUT="$CACHE/boot_ksu.img"
rm -f "$OUT"

mods "KernelSU: vá boot.img bằng ksud boot-patch-v2 ..."
if ! "$KSUSD" boot-patch-v2 --boot "$BOOT" --module "$KO" --output "$OUT" --force; then
    error "KernelSU: boot-patch-v2 THẤT BẠI - không vá được boot.img"
    error "KernelSU: ROM sẽ không có root. Đặt kernelsu=false trong config.env để bỏ qua bước này."
    exit 1
fi

if [ ! -s "$OUT" ]; then
    error "KernelSU: boot-patch-v2 báo thành công nhưng không tạo ra file - dừng"
    exit 1
fi

cp -f "$BOOT" "$CACHE/boot.img.stock"
cp -f "$OUT" "$BOOT"
mods "KernelSU: boot.img đã vá - $(stat -c%s "$BOOT") byte (gốc $(stat -c%s "$CACHE/boot.img.stock"))"

# Manager: đặt ở product/app để chắc chắn được cài. product/data-app cần
# PreinstallApp của MIUI chạy đúng, còn product/app thì PackageManager luôn thấy.
APP_DIR="$IMG/product/app/KernelSUNext"
if [ -d "$IMG/product" ]; then
    mkdir -p "$APP_DIR"
    cp -f "$APK" "$APP_DIR/KernelSUNext.apk"
    chmod 0644 "$APP_DIR/KernelSUNext.apk"
    mods "KernelSU: manager v$KSU_VER -> product/app/KernelSUNext"
else
    warn "KernelSU: không thấy product/ - manager không được cài sẵn"
fi

mods "KernelSU: xong - ROM có root sẵn, mở app KernelSU Next để cấp quyền"
exit 0
