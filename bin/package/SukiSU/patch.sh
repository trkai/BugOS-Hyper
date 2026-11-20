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
# Repo SukiSU-Ultra đã đổi tên thành SukiSU-Nova và tag cũ (v4.3.0-r1) KHÔNG còn
# -> build 17/11 tải manager APK 404. Giữ cấu hình cũ làm fallback, thêm bản
# mới làm nguồn chính.
#
# Tên asset thật trên release v3.0.0 (kiểm tra qua GitHub API 18/11):
#   SukiSU_Nova_v3.0.0_35000-arm64-v8a-release.apk
# Tức build number là 35000 (không phải 30000) và có hậu tố ABI. Thiếu một
# trong hai thứ đó là 404 -> script bỏ qua root mà build vẫn báo thành công.
SUKISU_NOVA_VER=3.0.0
SUKISU_NOVA_BUILD=35000
SUKISU_NOVA_ABI=arm64-v8a
BASE_LEGACY="https://github.com/SukiSU-Ultra/SukiSU-Ultra/releases/download/v${SUKISU_VER}"
BASE_NOVA="https://github.com/SukiSU-Nova/SukiSU-Nova/releases/download/v${SUKISU_NOVA_VER}"
# Mặc định dùng Nova; đặt sukisu_url_legacy=true để quay lại đường cũ.
USE_LEGACY=$(grep -m1 '^sukisu_url_legacy=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$USE_LEGACY" = "true" ]; then
    BASE="$BASE_LEGACY"
    APK_NAME="SukiSU_v${SUKISU_VER}_${SUKISU_BUILD}-release.apk"
else
    BASE="$BASE_NOVA"
    APK_NAME="SukiSU_Nova_v${SUKISU_NOVA_VER}_${SUKISU_NOVA_BUILD}-${SUKISU_NOVA_ABI}-release.apk"
fi

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
# APK_NAME đã được quyết định ở khối cấu hình phía trên (Nova / legacy).
APK="$CACHE/$APK_NAME"

fetch "$KSUD_BASE/ksud-x86_64-unknown-linux-musl" "$KSUSD" 5000000 || { error "SukiSU: không tải được ksud host"; exit 1; }
if ! fetch "$BASE/$APK_NAME" "$APK" 10000000; then
    # Nguồn chính hỏng -> thử nguồn còn lại trước khi bỏ cuộc (repo đã từng đổi
    # tên SukiSU-Ultra -> SukiSU-Nova, làm tag cũ biến mất).
    if [ "$BASE" = "$BASE_NOVA" ]; then
        ALT_BASE="$BASE_LEGACY"; ALT_NAME="SukiSU_v${SUKISU_VER}_${SUKISU_BUILD}-release.apk"
    else
        ALT_BASE="$BASE_NOVA"; ALT_NAME="SukiSU_Nova_v${SUKISU_NOVA_VER}_${SUKISU_NOVA_BUILD}-${SUKISU_NOVA_ABI}-release.apk"
    fi
    warn "SukiSU: nguồn chính 404 - thử $ALT_BASE"
    if fetch "$ALT_BASE/$ALT_NAME" "$APK" 10000000; then
        BASE="$ALT_BASE"; APK_NAME="$ALT_NAME"
    else
        error "SukiSU: không tải được manager APK (cả 2 nguồn) - bỏ qua root, build tiếp"
        exit 0
    fi
fi
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

# ---------------------------------------------------------------------------
# Chọn cách vá boot.img.
#
#   v2   - boot-patch-v2: nhúng kernelsu.ko vào CHÍNH kernel (capsule).
#          Yêu cầu kernel là ARM64 Image "sạch": số byte phải đúng bằng
#          image_size trong header. Nhiều máy Qualcomm (vd marble / Redmi Note
#          12 Turbo) có DTB hoặc metadata gắn sau kernel -> ksud từ chối:
#            "input has bytes beyond ARM64 image_size; appended DTB/metadata
#             is unsupported"
#
#   v1   - boot-patch: nhét ksuinit + kernelsu.ko vào RAMDISK, kernel giữ nguyên.
#          Không quan tâm DTB gắn sau, nhưng cần boot.img có ramdisk thật và
#          boot header v3+ (Android 13 trở lên).
#
#   auto - thử v2 trước, hỏng thì tự chuyển v1. Mặc định.
#
# Đặt sukisu_patch_mode=v1|v2 trong config.env để ép một đường.
# ---------------------------------------------------------------------------
PATCH_MODE=$(grep -m1 '^sukisu_patch_mode=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
[ -z "$PATCH_MODE" ] && PATCH_MODE=auto

patch_v2() {
    mods "SukiSU: vá boot.img bằng ksud boot-patch-v2 (capsule trong kernel) ..."
    "$KSUSD" boot-patch-v2 --boot "$BOOT" --module "$KO" --output "$OUT" --force
}

patch_v1() {
    local outdir="$CACHE/v1"
    rm -rf "$outdir"
    mkdir -p "$outdir"

    mods "SukiSU: vá boot.img bằng ksud boot-patch (ramdisk, kernel giữ nguyên) ..."
    "$KSUSD" boot-patch --boot "$BOOT" --module "$KO" --out "$outdir" --out-name boot_v1.img || return 1

    if [ ! -s "$outdir/boot_v1.img" ]; then
        warn "SukiSU: boot-patch báo xong nhưng không thấy boot_v1.img"
        return 1
    fi
    mv -f "$outdir/boot_v1.img" "$OUT"
}

sukisu_fail() {
    error "SukiSU: KHÔNG vá được boot.img - ROM sẽ không có root."
    error "SukiSU: đặt sukisu=false trong config.env nếu muốn bỏ qua hẳn bước này."
    exit 1
}

case "$PATCH_MODE" in
    v2)
        patch_v2 || sukisu_fail
        ;;
    v1)
        patch_v1 || sukisu_fail
        ;;
    auto|*)
        if ! patch_v2; then
            warn "SukiSU: boot-patch-v2 không dùng được cho boot.img này (thường do DTB gắn sau kernel)."
            warn "SukiSU: chuyển sang boot-patch (ramdisk) ..."
            patch_v1 || sukisu_fail
        fi
        ;;
esac

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
PREINSTALL=$(grep -m1 '^sukisu_preinstall_manager=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$PREINSTALL" != "true" ]; then
    # Không cài sẵn app: kernel trong boot.img vẫn có root sẵn, nhưng KHÔNG có
    # app nào để nói chuyện với nó (Root Toolbox đã bị xoá khỏi repo). Người
    # dùng phải tự cài APK manager thì mới có root dùng được.
    mods "SukiSU: không cài sẵn manager (sukisu_preinstall_manager=false) - người dùng phải tự cài APK"
elif [ -d "$IMG/product" ]; then
    # Tải manager có thể đã thất bại ở trên (script in "bỏ qua root, build tiếp")
    # nhưng preinstall vẫn chạy tới đây. Thiếu guard thì cp im lặng, unzip im
    # lặng, rồi báo nhầm là "APK không có lib".
    if [ ! -f "$APK" ]; then
        error "SukiSU: không có file manager APK ($APK) - không cài sẵn được"
        exit 1
    fi
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
    mods "SukiSU: manager $APK_NAME -> product/app/SukiSUUltra"
else
    warn "SukiSU: không thấy product/ - manager không được cài sẵn"
fi

# ---------------------------------------------------------------------------
# Cài manager thành APP DỮ LIỆU (/data/app) ở lần boot đầu.
#
# VÌ SAO BẮT BUỘC - đọc từ source kernel, không phải thử mò:
#   kernel/manager/throne_tracker.c -> track_throne() -> search_manager("/data/app", 2)
#   Nó chỉ quét /data/app/<pkg>/base.apk, xác minh chữ ký rồi mới
#   ksu_set_manager_appid(). App hệ thống ở /product/app KHÔNG BAO GIỜ được quét
#   tới, nên ksu_manager_appid giữ KSU_INVALID_APPID, is_manager() luôn false,
#   mọi supercall bị từ chối -> app hiện "Chưa cài đặt" dù kernelsu.ko đã nạp.
#
#   Đo trên máy 05/11: app ở /product/app -> "chưa cài đặt"; `pm install -r` đúng
#   APK đó -> /data/app/~~xxx/com.sukisu.ultra-yyy/base.apk, flags có
#   UPDATED_SYSTEM_APP, kernel crowning ngay (package observer) -> hết lỗi.
#   Cài ở /data/app còn có lợi thứ hai: PackageManager tự giải nén lib ra
#   lib/arm64 với mode 0755 và nhãn apk_data_file, nên ksud exec được.
#
# VÌ SAO KHÔNG dùng `exec` của init: domain init không có binder, `pm` cần
# binder để gọi package service. Khuôn đã có sẵn trong init.miui.ext.rc
# (pubcert_download): init exec /system/bin/sh với seclabel u:r:shell:s0 -
# domain shell có binder. Dùng lại đúng khuôn đó, không cần thêm rule SELinux.
#
# Script chạy mỗi lần boot nhưng tự thoát nếu app đã nằm trong /data/app, nên
# chỉ thực sự cài đúng một lần. Cài lỗi thì app hệ thống vẫn còn (chỉ là chưa
# dùng được) - không mất app, không boot loop.
# ---------------------------------------------------------------------------
INSTALL_SH="$IMG/system_ext/bin/bugos_sukisu_manager.sh"
INSTALL_RC="$IMG/system_ext/etc/init/init.bugos.sukisu.rc"
if [ "$PREINSTALL" != "true" ]; then
    mods "SukiSU: bỏ qua service tự cài manager (đã tắt preinstall)"
elif [ -d "$IMG/system_ext" ]; then
    mkdir -p "$(dirname "$INSTALL_SH")" "$(dirname "$INSTALL_RC")"

    cat > "$INSTALL_SH" << 'SHEOF'
#!/system/bin/sh
# BugOS - cài SukiSU Ultra thành app dữ liệu (/data/app) ở lần boot đầu.
# Kernel chỉ nhận manager khi thấy base.apk trong /data/app; xem chú thích
# trong bin/package/SukiSU/patch.sh.

APK=/product/app/SukiSUUltra/SukiSUUltra.apk
LOG=/data/local/tmp/bugos_sukisu_install.log

# Ghi dòng đầu TIÊN, trước mọi thứ khác: uid ở đây là thứ duy nhất cho biết
# service chạy bằng user nào. Không có dòng này thì khi hỏng chỉ thấy im lặng.
echo "=== $(date) start uid=$(id -u) gid=$(id -g)" >> "$LOG" 2>&1

# Chờ framework lên. Service chạy ở class late_start (init tự khởi động, không
# phụ thuộc trigger sys.boot_completed) nên phải tự đợi, tối đa 240s.
i=0
while [ "$(getprop sys.boot_completed 2>/dev/null)" != "1" ] && [ "$i" -lt 120 ]; do
    sleep 2
    i=$((i + 1))
done
echo "--- boot_completed=$(getprop sys.boot_completed 2>/dev/null) sau ${i} lần chờ" >> "$LOG" 2>&1

if [ ! -f "$APK" ]; then
    echo "--- không thấy $APK - bỏ qua" >> "$LOG" 2>&1
    exit 0
fi

# Đã là app dữ liệu rồi thì thôi (cài rồi, hoặc người dùng đã tự cài).
#
# Tên package KHÔNG hard-code một giá trị: bản APK này là com.sukisu.nova, không
# phải com.sukisu.ultra như các bản SukiSU khác. Đo trên máy: pm list packages
# chỉ có com.sukisu.nova, nên mọi lệnh `pm path com.sukisu.ultra` luôn rỗng và
# guard "đã cài rồi" không bao giờ đúng -> cài lại mỗi lần boot.
find_pkg() {
    for _p in com.sukisu.nova com.sukisu.ultra; do
        case "$(pm path "$_p" 2>/dev/null)" in
            *"/data/app/"*) echo "$_p"; return 0 ;;
        esac
    done
    # Fallback: dò theo tên gói, phòng khi bản sau đổi tên lần nữa.
    pm list packages 2>/dev/null | sed -n 's/^package:\(com\.sukisu\.[a-z0-9._]*\)$/\1/p' | head -n1
}

PKG=$(find_pkg)
echo "--- package hiện có: ${PKG:-khong-co}" >> "$LOG" 2>&1
if [ -n "$PKG" ] && [ "$(pm path "$PKG" 2>/dev/null | head -n1)" != "" ]; then
    case "$(pm path "$PKG" 2>/dev/null)" in
        *"/data/app/"*) echo "--- đã ở /data/app, không làm gì" >> "$LOG" 2>&1; exit 0 ;;
    esac
fi

echo "--- pm install -r $APK" >> "$LOG" 2>&1
pm install -r "$APK" >> "$LOG" 2>&1
_rc=$?
echo "--- pm exit=$_rc" >> "$LOG" 2>&1
echo "--- sau cài: $(pm path "$(find_pkg)" 2>&1)" >> "$LOG" 2>&1
SHEOF
    chmod 0755 "$INSTALL_SH"

    cat > "$INSTALL_RC" << 'RCEOF'
# BugOS - cài SukiSU Ultra vào /data/app ở lần boot đầu.
# Xem bin/package/SukiSU/patch.sh.
#
# VÌ SAO PHẢI ĐI QUA `su`:
# Bản trước dùng `seclabel u:r:shell:s0` với giả định "chỉ domain shell mới có
# binder". Đo trên annibale (A17/OS4.0.6) thì SAI: từ domain shell,
#     runcon u:r:shell:s0 cat /system_ext/bin/bugos_sukisu_manager.sh -> rc=126
#     runcon u:r:shell:s0 sh -c 'echo x > /data/local/tmp/_t'        -> denied
#     runcon u:r:shell:s0 pm path android                             -> rc=126
# tức không đọc được script, không ghi được log, không gọi được pm. Service có
# start (ro.boottime có ghi) nhưng `sh` không mở nổi file nên thoát ngay, không
# một dòng log nào - đúng hiện tượng đã gặp.
#
# Domain duy nhất trên máy này có đủ quyền là u:r:ksu:s0 (domain của `su`).
# Nên: service chạy /system/bin/su -c ... để KernelSU tự chuyển domain.
# /system/bin/su do ksud tạo lúc boot, nên dùng trigger boot_completed thay vì
# class main (ở 5 giây đầu file đó có thể chưa có).
service bugos_sukisu_manager /system/bin/su -c "/system/bin/sh /system_ext/bin/bugos_sukisu_manager.sh"
    class late_start
    user root
    group root system
    oneshot
    disabled

# Trigger theo boot_completed: lúc đó ksud đã tạo xong /system/bin/su.
on property:sys.boot_completed=1
    start bugos_sukisu_manager
RCEOF
    chmod 0644 "$INSTALL_RC"

    # fspatch.py tự đóng 0750 cho mọi file .sh nằm dưới /bin (quy ước của ROM
    # gốc). Với file của mình thì phải là 0755, nếu không `sh` không đọc được
    # khi service không chạy bằng uid 0 - đúng lỗi đã gặp. Ghi thẳng vào
    # fs_config: fspatch giữ nguyên entry đã có, nên entry này thắng.
    FS_CFG="$IMG/config/system_ext_fs_config"
    if [ -f "$FS_CFG" ]; then
        {
            echo "system_ext/bin/bugos_sukisu_manager.sh 0 0 0755"
            echo "system_ext/etc/init/init.bugos.sukisu.rc 0 0 0644"
        } >> "$FS_CFG"
        mods "SukiSU: fs_config -> script 0755, rc 0644"
    else
        warn "SukiSU: không thấy $FS_CFG - script có thể bị đóng 0750 và không chạy được"
    fi

    mods "SukiSU: script cài manager vào /data/app ở boot đầu -> system_ext/bin"
else
    warn "SukiSU: không thấy system_ext/ - manager chỉ nằm ở /product/app và sẽ báo 'chưa cài đặt'"
fi

if [ "$PREINSTALL" = "true" ]; then
    mods "SukiSU: xong - root sẵn; manager cài sẵn, tự sang /data/app ở boot đầu"
else
    mods "SukiSU: xong - kernel có root sẵn; KHÔNG có manager, người dùng phải tự cài APK"
fi
exit 0
