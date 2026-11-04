#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
# ---------------------------------------------------------------------------
# KernelSU Next 3.4.2 - root sẵn trong ROM (chế độ LKM)
#
# Vá INIT_BOOT, không phải boot.img.
#
#   boot.img  : chứa kernel 6.6.118-android15-8 do Xiaomi vá + vendor_dlkm phải
#               khớp vermagic -> thay kernel GKI là mất boot.
#   init_boot : chứa ramdisk generic, tức cái `init` đầu tiên của userspace.
#
#   LKM hoạt động bằng cách chèn một init wrapper vào ramdisk để nó `insmod`
#   kernelsu.ko trước khi mount /data. Đó là init_boot. Đây cũng đúng là lựa
#   chọn của chính ksud: boot_patch.rs::choose_boot_partition() trả "init_boot"
#   khi KHÔNG thay kernel và máy có phân vùng init_boot (chỉ bỏ qua với
#   android12-*). Máy này android15 -> init_boot.
#
#   (ksud boot-patch-v2 thì khác: nó nhúng .ko vào chính KERNEL dạng capsule và
#   luôn nhận boot.img. Đường đó đọc kallsyms của kernel Xiaomi nên dễ vỡ hơn,
#   và không phải đường upstream chọn cho máy có init_boot.)
#
# Vì sao phải chạy TRƯỚC patchpackage.sh:
#   patchpackage.sh -> DISABLE_AVB tính lại vbmeta trên các image hiện có.
#   Vá init_boot sau bước đó là vbmeta lệch với init_boot.
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

BOOT="$IMG/boot.img"          # chi de doc version kernel
TARGET="$IMG/init_boot.img"   # doi tuong bi va
if [ ! -f "$TARGET" ]; then
    error "KernelSU: không thấy $TARGET - không có chỗ chèn module"
    error "KernelSU: đặt kernelsu=false trong config.env để bỏ qua bước này."
    exit 1
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

# Kiểm KMI của module có khớp kernel không, trước khi vá. Kernel nằm trong
# boot.img (không phải init_boot), nên đọc version từ đó.
# Lệch KMI thì ksud vẫn vá được nhưng kernel sẽ không nạp được module - hỏng
# lúc boot chứ không hỏng lúc build, nên cảnh báo sớm ở đây.
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

OUT="$CACHE/init_boot_ksu.img"
rm -f "$OUT"

# boot-patch (KHONG phai boot-patch-v2): che do LKM, chen init wrapper + module
# vao ramdisk cua image duoc dua vao. Tren host khong co /dev/block/by-name nen
# phai truyen --boot tuong minh, neu khong no se tu do phan vung va that bai.
mods "KernelSU: vá init_boot.img bằng ksud boot-patch (LKM, $KSU_KMI) ..."
if ! "$KSUSD" boot-patch \
        --boot "$TARGET" \
        --module "$KO" \
        --kmi "$KSU_KMI" \
        --out "$OUT"; then
    error "KernelSU: ksud boot-patch THẤT BẠI - không vá được init_boot.img"
    error "KernelSU: ROM sẽ không có root. Đặt kernelsu=false trong config.env để bỏ qua bước này."
    exit 1
fi

if [ ! -s "$OUT" ]; then
    error "KernelSU: ksud báo thành công nhưng không tạo ra file - dừng"
    exit 1
fi

cp -f "$TARGET" "$CACHE/init_boot.img.stock"
cp -f "$OUT" "$TARGET"
mods "KernelSU: init_boot.img đã vá - $(stat -c%s "$TARGET") byte (gốc $(stat -c%s "$CACHE/init_boot.img.stock"))"

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
