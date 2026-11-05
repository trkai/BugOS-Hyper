#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
# ---------------------------------------------------------------------------
# KernelSU Next 3.4.2 - root sẵn trong ROM, dùng được cho nhiều máy.
#
# Đường đang dùng: ksud boot-patch-v2, nhúng kernelsu.ko vào CHÍNH kernel
# trong boot.img dưới dạng capsule (tự phục hồi kallsyms/BTF rồi giải
# relocation). Không thay kernel GKI, không đụng ramdisk.
#
# VÌ SAO KHÔNG dùng init_boot (boot-patch v1):
#   Trên MÁY, ksud chọn init_boot cho LKM và chèn init wrapper vào ramdisk.
#   Nhưng trên HOST, boot-patch v1 cần thêm `ksuinit`
#   (boot_patch.rs: assets::get_asset("{arch}/ksuinit")), và upstream KHÔNG
#   phát hành ksuinit: 33 asset của v3.4.2 chỉ có *.ko, ksud, 2 APK; trong
#   ksud-x86_64-unknown-linux-musl cũng không có chuỗi "ksuinit" nào.
#   ksuinit là project Rust (userspace/ksuinit), muốn có phải build
#   aarch64-musl trong CI.
#   boot-patch-v2 thì KHÔNG cần ksuinit -> đây là đường chạy được từ host.
#
# Tính tổng quát:
#   - KMI tự dò từ chuỗi version của kernel trong boot.img, không hardcode.
#   - KMI dò ra được thì tải đúng aarch64_<kmi>_kernelsu.ko của v3.4.2.
#   - Dò không được thì đặt kernelsu_kmi=<kmi> trong config.env.
#   - KMI không có trong release v3.4.2 thì dừng, in danh sách có sẵn.
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
BASE="https://github.com/KernelSU-Next/KernelSU-Next/releases/download/v${KSU_VER}"

# Kiến trúc module. Mọi máy Xiaomi HyperOS hiện hành đều arm64; máy arm32 sẽ
# không có module trong release nên bước dò KMI bên dưới báo lỗi rõ ràng.
KSU_ARCH=aarch64

IMG="$work_dir/build/baserom/images"
CACHE="$work_dir/.ksu_cache"

ENABLE=$(grep -m1 '^kernelsu=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$ENABLE" = "false" ]; then
    mods "KernelSU: bỏ qua (kernelsu=false)"
    exit 0
fi

# Bản manager: "spoofed" (mặc định) hay "normal".
#   spoofed: package ngẫu nhiên - ở v3.4.2 là kqvdie.zeykvw.hpbcyd - nên không
#            có chữ "kernelsu" nào trong tên package hay tên app. Cùng một app,
#            cùng kernel, cùng quyền; chỉ khác định danh.
#   normal : com.rifsxd.ksunext, tên thật. Dễ nhận ra khi cần debug.
MANAGER=$(grep -m1 '^kernelsu_manager=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
# Mặc định phải là normal. Trước đây để trống thì rơi vào spoofed - mà spoofed
# thì kernel không nhận (đã đo trên image sạch 05/11), nên một dòng config thiếu
# hoặc gõ sai sẽ lặng lẽ tạo ra ROM không có root dùng được.
case "$MANAGER" in
    normal|spoofed) ;;
    *)
        [ -n "$MANAGER" ] && warn "KernelSU: kernelsu_manager='$MANAGER' không hợp lệ - dùng normal"
        MANAGER=normal
        ;;
esac

BOOT="$IMG/boot.img"
if [ ! -f "$BOOT" ]; then
    error "KernelSU: không thấy $BOOT - không có kernel để vá"
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

# Tên asset trên release đổi theo bản manager. Cache đặt theo đúng tên file nên
# đổi cờ là tải lại, không dùng nhầm bản cũ.
case "$MANAGER" in
    normal) APK_NAME="KernelSU_Next_v${KSU_VER}_${KSU_BUILD}-release.apk" ;;
    *)      APK_NAME="KernelSU_Next_v${KSU_VER}-spoofed_${KSU_BUILD}-release.apk" ;;
esac
APK="$CACHE/$APK_NAME"

fetch "$BASE/ksud-x86_64-unknown-linux-musl" "$KSUSD" 5000000 || { error "KernelSU: không tải được ksud"; exit 1; }
fetch "$BASE/$APK_NAME" "$APK" 10000000 || { error "KernelSU: không tải được manager APK ($APK_NAME)"; exit 1; }
chmod 0755 "$KSUSD"
mods "KernelSU: manager bản $MANAGER ($APK_NAME)"

# ---------------------------------------------------------------------------
# Dò KMI: kernel báo "6.6.118-android15-8-g0908354dac1b-ab...-4k", KMI của
# KernelSU là "android15-6.6" -> lấy androidNN và major.minor rồi ghép lại.
# ---------------------------------------------------------------------------
KMI_CFG=$(grep -m1 '^kernelsu_kmi=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')

if [ -n "$KMI_CFG" ]; then
    KMI="$KMI_CFG"
    mods "KernelSU: KMI lấy từ config.env = $KMI"
else
    BOOT_VER=$(strings "$BOOT" 2>/dev/null | grep -m1 -oE "[0-9]+\.[0-9]+\.[0-9]+-android[0-9]+-[0-9]+" || true)
    if [ -z "$BOOT_VER" ]; then
        error "KernelSU: không đọc được version kernel trong boot.img"
        error "KernelSU: đặt kernelsu_kmi=androidNN-X.Y trong config.env rồi chạy lại."
        exit 1
    fi
    boot_android=$(printf '%s' "$BOOT_VER" | grep -oE "android[0-9]+" | head -1)
    boot_kver=$(printf '%s' "$BOOT_VER" | grep -oE "^[0-9]+\.[0-9]+" | head -1)
    KMI="${boot_android}-${boot_kver}"
    mods "KernelSU: kernel '$BOOT_VER' -> KMI $KMI"
fi

KO="$CACHE/${KSU_ARCH}_${KMI}_kernelsu.ko"
if ! fetch "$BASE/${KSU_ARCH}_${KMI}_kernelsu.ko" "$KO" 200000; then
    error "KernelSU: v$KSU_VER không có module cho KMI '$KMI' (${KSU_ARCH})"
    error "KernelSU: các KMI mà v$KSU_VER phát hành:"
    for k in android12-5.10 android13-5.10 android13-5.15 android14-5.15 android14-6.1 android15-6.6 android16-6.12 android17-6.18; do
        error "             ${k}"
    done
    error "KernelSU: đặt kernelsu=false nếu máy này không nằm trong danh sách."
    exit 1
fi
mods "KernelSU: module ${KSU_ARCH}/${KMI}_kernelsu.ko ($(stat -c%s "$KO") byte)"

OUT="$CACHE/boot_ksu.img"
rm -f "$OUT"

mods "KernelSU: vá boot.img bằng ksud boot-patch-v2 (capsule trong kernel) ..."
if ! "$KSUSD" boot-patch-v2 --boot "$BOOT" --module "$KO" --output "$OUT" --force; then
    error "KernelSU: boot-patch-v2 THẤT BẠI - không vá được kernel trong boot.img"
    error "KernelSU: ROM sẽ không có root. Đặt kernelsu=false trong config.env để bỏ qua bước này."
    exit 1
fi

if [ ! -s "$OUT" ]; then
    error "KernelSU: ksud báo thành công nhưng không tạo ra file - dừng"
    exit 1
fi

cp -f "$BOOT" "$CACHE/boot.img.stock"
cp -f "$OUT" "$BOOT"
mods "KernelSU: boot.img đã vá - $(stat -c%s "$BOOT") byte (gốc $(stat -c%s "$CACHE/boot.img.stock"))"

# Manager: product/app để PackageManager luôn thấy. product/data-app phụ thuộc
# PreinstallApp của MIUI chạy đúng.
#
# Native lib PHẢI nằm NGOÀI apk, trong <appdir>/lib/arm64/. App hệ thống nằm
# trên phân vùng chỉ đọc nên PackageManager không giải nén lib vào /data được,
# mà APK này khai extractNativeLibs=false -> System.loadLibrary("kernelsu")
# không thấy gì và manager chết ngay khi mở:
#   UnsatisfiedLinkError: dlopen failed: library "libkernelsu.so" not found
# Đã gặp thật trên máy 05/11 với bản chỉ copy mỗi APK.
#
# Tên thư mục là "arm64", KHÔNG phải "arm64-v8a" - đó là quy ước
# nativeLibraryDir của app hệ thống (/product/app/X/lib/arm64).
APP_DIR="$IMG/product/app/KernelSUNext"
if [ -d "$IMG/product" ]; then
    mkdir -p "$APP_DIR"
    cp -f "$APK" "$APP_DIR/KernelSUNext.apk"
    chmod 0644 "$APP_DIR/KernelSUNext.apk"

    mkdir -p "$APP_DIR/lib/arm64"
    unzip -o -j -q "$APK" 'lib/arm64-v8a/*.so' -d "$APP_DIR/lib/arm64" >/dev/null 2>&1 || true
    if [ -f "$APP_DIR/lib/arm64/libkernelsu.so" ]; then
        chmod 0644 "$APP_DIR/lib/arm64/"*.so
        mods "KernelSU: lib arm64 -> product/app/KernelSUNext/lib/arm64 ($(ls "$APP_DIR/lib/arm64" | wc -l) file)"
    else
        error "KernelSU: APK không có lib/arm64-v8a/libkernelsu.so - manager sẽ crash khi mở"
        exit 1
    fi
    mods "KernelSU: manager v$KSU_VER -> product/app/KernelSUNext"
else
    warn "KernelSU: không thấy product/ - manager không được cài sẵn"
fi

mods "KernelSU: xong - ROM có root sẵn, mở app KernelSU Next để cấp quyền"
exit 0
