#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
# ---------------------------------------------------------------------------
# SukiSU Ultra 4.3.0-r1 - root sẵn trong ROM, dùng được cho nhiều máy.
#
# Đường đang dùng: boot-patch-v2, nhúng kernelsu.ko của SukiSU vào CHÍNH kernel
# trong boot.img dưới dạng capsule (tự phục hồi kallsyms/BTF rồi giải
# relocation). Không thay kernel GKI, không đụng ramdisk.
#
# Tính tổng quát:
#   - KMI tự dò từ chuỗi version của kernel trong boot.img, không hardcode.
#   - KMI dò ra được thì tải đúng lkm-aarch64-<kmi>_kernelsu.ko của v4.3.0-r1.
#   - Dò không được thì đặt sukisu_kmi=<kmi> trong config.env.
#   - KMI không có trong release thì dừng, in danh sách có sẵn.
#
# Vì sao phải chạy TRƯỚC patchpackage.sh:
#   patchpackage.sh -> DISABLE_AVB tính lại vbmeta trên các image hiện có.
#   Vá boot.img sau bước đó là vbmeta lệch với boot.img.
#
# Bật/tắt bằng cờ sukisu trong config.env.
# ---------------------------------------------------------------------------

work_dir=$(pwd)
source "$work_dir/functions.sh"

SUKISU_VER=4.3.0-r1
SUKISU_BUILD=41140
BASE="https://github.com/SukiSU-Ultra/SukiSU-Ultra/releases/download/v${SUKISU_VER}"

# ---------------------------------------------------------------------------
# ksud chạy trên HOST: mượn của KernelSU-Next 3.4.2.
#
# SukiSU chỉ phát hành ksud cho Android (aarch64/armv7/riscv64/x86_64-linux-android).
# Bản x86_64 có PT_INTERP=/system/bin/linker64, tức là link với bionic -> không
# chạy được trên Ubuntu của runner. Trong khi đó KernelSU-Next có bản
# x86_64-unknown-linux-musl, ELF tĩnh, chạy thẳng.
#
# Vì sao trộn được (đã đối chiếu source ở đúng 2 tag, không phải phỏng đoán):
#   - userspace/ksud/src/lkm_image.rs: inject_image, analyze_patch_sites,
#     recover_arm64_kernel_metadata giống nhau 100% (so từng ký tự).
#   - userspace/ksud/src/lkm_image_bootstrap.S: md5 80127a51... giống nhau.
#     Đây mới là thứ quyết định định dạng capsule nằm trong kernel.
#   - KsuConfigArgs::apply của hai bên ghi cùng bộ tham số; mặc định đều rỗng
#     (SukiSU chỉ thêm "preinit=0" khi bật cờ --no-preinit, mà ta không bật).
#   => Với cùng file .ko và cùng tham số, hai ksud sinh ra capsule y hệt nhau.
#      Khác biệt duy nhất là .ko - và .ko thì ta lấy từ release của SukiSU.
#
# Đổi SUKISU sang bản khác thì phải so lại 2 file trên trước khi tin.
# ---------------------------------------------------------------------------
KSUD_VER=3.4.2
KSUD_BASE="https://github.com/KernelSU-Next/KernelSU-Next/releases/download/v${KSUD_VER}"

# Kiến trúc module. Mọi máy Xiaomi HyperOS hiện hành đều arm64; máy arm32 sẽ
# không có module trong release nên bước dò KMI bên dưới báo lỗi rõ ràng.
ARCH=aarch64

IMG="$work_dir/build/baserom/images"
CACHE="$work_dir/.sukisu_cache"

ENABLE=$(grep -m1 '^sukisu=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$ENABLE" = "false" ]; then
    mods "SukiSU: bỏ qua (sukisu=false)"
    exit 0
fi

BOOT="$IMG/boot.img"
if [ ! -f "$BOOT" ]; then
    error "SukiSU: không thấy $BOOT - không có kernel để vá"
    error "SukiSU: đặt sukisu=false trong config.env để bỏ qua bước này."
    exit 1
fi

mkdir -p "$CACHE" || { error "SukiSU: không tạo được $CACHE"; exit 1; }

# Tải + kiểm kích thước tối thiểu. Không có checksum chính thức từ upstream,
# nên đây là chốt chặn duy nhất: file cụt hoặc trang lỗi HTML sẽ bị loại.
fetch() {
    local url="$1" out="$2" min="$3" sz
    if [ -s "$out" ]; then
        sz=$(stat -c%s "$out" 2>/dev/null || echo 0)
        [ "$sz" -ge "$min" ] && return 0
    fi
    mods "SukiSU: tải $(basename "$out")"
    rm -f "$out"
    curl -fL --retry 3 --retry-delay 5 --connect-timeout 30 --max-time 600 \
        -o "$out" "$url" || return 1
    sz=$(stat -c%s "$out" 2>/dev/null || echo 0)
    if [ "$sz" -lt "$min" ]; then
        warn "SukiSU: $(basename "$out") chỉ $sz byte (cần >= $min) - file hỏng?"
        return 1
    fi
    return 0
}

KSUSD="$CACHE/ksud"
APK_NAME="SukiSU_v${SUKISU_VER}_${SUKISU_BUILD}-release.apk"
APK="$CACHE/$APK_NAME"

fetch "$KSUD_BASE/ksud-x86_64-unknown-linux-musl" "$KSUSD" 5000000 || { error "SukiSU: không tải được ksud host"; exit 1; }
fetch "$BASE/$APK_NAME" "$APK" 10000000 || { error "SukiSU: không tải được manager APK ($APK_NAME)"; exit 1; }
chmod 0755 "$KSUSD"
mods "SukiSU: manager $APK_NAME"

# ---------------------------------------------------------------------------
# Dò KMI: kernel báo "6.6.118-android15-8-g0908354dac1b-ab...-4k", KMI của
# KernelSU/SukiSU là "android15-6.6" -> lấy androidNN và major.minor rồi ghép.
# ---------------------------------------------------------------------------
KMI_CFG=$(grep -m1 '^sukisu_kmi=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')

if [ -n "$KMI_CFG" ]; then
    KMI="$KMI_CFG"
    mods "SukiSU: KMI lấy từ config.env = $KMI"
else
    BOOT_VER=$(strings "$BOOT" 2>/dev/null | grep -m1 -oE "[0-9]+\.[0-9]+\.[0-9]+-android[0-9]+-[0-9]+" || true)
    if [ -z "$BOOT_VER" ]; then
        error "SukiSU: không đọc được version kernel trong boot.img"
        error "SukiSU: đặt sukisu_kmi=androidNN-X.Y trong config.env rồi chạy lại."
        exit 1
    fi
    boot_android=$(printf '%s' "$BOOT_VER" | grep -oE "android[0-9]+" | head -1)
    boot_kver=$(printf '%s' "$BOOT_VER" | grep -oE "^[0-9]+\.[0-9]+" | head -1)
    KMI="${boot_android}-${boot_kver}"
    mods "SukiSU: kernel '$BOOT_VER' -> KMI $KMI"
fi

KO="$CACHE/lkm-${ARCH}-${KMI}_kernelsu.ko"
if ! fetch "$BASE/lkm-${ARCH}-${KMI}_kernelsu.ko" "$KO" 200000; then
    error "SukiSU: v$SUKISU_VER không có module cho KMI '$KMI' (${ARCH})"
    error "SukiSU: các KMI mà v$SUKISU_VER phát hành:"
    for k in android12-5.10 android13-5.10 android13-5.15 android14-5.15 android14-6.1 android15-6.6 android16-6.12 android17-6.18; do
        error "             ${k}"
    done
    error "SukiSU: đặt sukisu=false nếu máy này không nằm trong danh sách."
    exit 1
fi
mods "SukiSU: module lkm-${ARCH}-${KMI}_kernelsu.ko ($(stat -c%s "$KO") byte)"

OUT="$CACHE/boot_sukisu.img"
rm -f "$OUT"

mods "SukiSU: vá boot.img bằng ksud boot-patch-v2 (capsule trong kernel) ..."
if ! "$KSUSD" boot-patch-v2 --boot "$BOOT" --module "$KO" --output "$OUT" --force; then
    error "SukiSU: boot-patch-v2 THẤT BẠI - không vá được kernel trong boot.img"
    error "SukiSU: ROM sẽ không có root. Đặt sukisu=false trong config.env để bỏ qua bước này."
    exit 1
fi

if [ ! -s "$OUT" ]; then
    error "SukiSU: ksud báo thành công nhưng không tạo ra file - dừng"
    exit 1
fi

# Chốt chặn cuối: image sau khi vá phải còn gần đúng kích thước gốc. Nhỏ hơn
# 90% nghĩa là phần kernel bị cắt cụt trong lúc repack - loại trước khi flash.
stock_sz=$(stat -c%s "$BOOT")
out_sz=$(stat -c%s "$OUT")
if [ "$out_sz" -lt $((stock_sz * 9 / 10)) ]; then
    error "SukiSU: boot.img sau khi vá chỉ còn $out_sz byte (gốc $stock_sz) - hỏng, dừng"
    exit 1
fi

cp -f "$BOOT" "$CACHE/boot.img.stock"
cp -f "$OUT" "$BOOT"
mods "SukiSU: boot.img đã vá - $out_sz byte (gốc $stock_sz)"

# Manager: product/app để PackageManager luôn thấy. product/data-app phụ thuộc
# PreinstallApp của MIUI chạy đúng.
#
# Native lib PHẢI nằm NGOÀI apk, trong <appdir>/lib/arm64/. App hệ thống nằm
# trên phân vùng chỉ đọc nên PackageManager không giải nén lib vào /data được,
# mà APK này khai extractNativeLibs=false -> System.loadLibrary() không thấy gì
# và manager chết ngay khi mở:
#   UnsatisfiedLinkError: dlopen failed: library "libkernelsu.so" not found
# Đã gặp thật trên máy 05/11 với bản KernelSU Next chỉ copy mỗi APK.
#
# Tên thư mục là "arm64", KHÔNG phải "arm64-v8a" - đó là quy ước
# nativeLibraryDir của app hệ thống (/product/app/X/lib/arm64).
#
# SukiSU đổi tên lib để né bị quét (libadbroot, libfdbqiupsrx, ...), nên KHÔNG
# kiểm tra tên cụ thể - chỉ kiểm tra có lib và lib lớn nhất đủ nặng (ksud ~6 MB
# nằm trong đó). Tên lib đổi giữa các bản là chuyện bình thường.
APP_DIR="$IMG/product/app/SukiSUUltra"
if [ -d "$IMG/product" ]; then
    mkdir -p "$APP_DIR"
    cp -f "$APK" "$APP_DIR/SukiSUUltra.apk"
    chmod 0644 "$APP_DIR/SukiSUUltra.apk"

    mkdir -p "$APP_DIR/lib/arm64"
    unzip -o -j -q "$APK" 'lib/arm64-v8a/*.so' -d "$APP_DIR/lib/arm64" >/dev/null 2>&1 || true
    lib_count=$(ls "$APP_DIR/lib/arm64" 2>/dev/null | wc -l)
    if [ "$lib_count" -lt 1 ]; then
        error "SukiSU: APK không có lib/arm64-v8a/*.so - manager sẽ crash khi mở"
        exit 1
    fi
    # 0755 chu khong 0644: mot trong cac lib la binary ksud (~6 MB), manager
    # can chay no. De 0644 thi no khong exec duoc.
    chmod 0755 "$APP_DIR/lib/arm64/"*.so
    big=$(ls -S "$APP_DIR/lib/arm64" | head -1)
    big_sz=$(stat -c%s "$APP_DIR/lib/arm64/$big")
    if [ "$big_sz" -lt 1000000 ]; then
        warn "SukiSU: lib lớn nhất chỉ $big_sz byte - có thể thiếu ksud, manager sẽ báo 'chưa cài đặt'"
    fi
    mods "SukiSU: lib arm64 -> product/app/SukiSUUltra/lib/arm64 ($lib_count file, lớn nhất $big)"
    mods "SukiSU: manager v$SUKISU_VER -> product/app/SukiSUUltra"
else
    warn "SukiSU: không thấy product/ - manager không được cài sẵn"
fi

mods "SukiSU: xong - ROM có root sẵn, mở app SukiSU Ultra để cấp quyền"
exit 0
