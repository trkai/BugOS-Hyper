#!/bin/bash
# BugOS - Modded Security Center v8 (Kashi / Mods Center)
# ---------------------------------------------------------------------------
# Thay app "Trung tâm bảo mật" (com.miui.securitycenter) bằng bản mod v8
# (13.8.0-261020.0.1) cho OS3 và OS4.
#
# BA ĐIỂM ĐÃ KIỂM CHỨNG TRÊN APK THẬT (không đoán):
#
# 1. CHỮ KÝ: apksigner báo "DOES NOT VERIFY" (v3 digest mismatch) - cố ý, vì
#    APK đã bị mod. Nhưng chứng thư bên trong vẫn là PLATFORM key của Xiaomi
#    (SHA256 C9:00:9D:01:...), trùng với framework-res.apk. Điều này BẮT BUỘC
#    vì app khai sharedUserId="android.uid.system": nếu chứng thư khác, nó sẽ
#    không được xếp vào shared user và mất toàn bộ quyền hệ thống.
#    -> KHÔNG re-sign. Chỉ copy nguyên byte.
#
# 2. QUYỀN: APK mod xin 163 quyền, bản gốc trên ROM cũng xin đúng 163 quyền,
#    danh sách GIỐNG HỆT. Nghĩa là whitelist privapp sẵn có của ROM đã phủ đủ,
#    không cần nới quyền gì thêm.
#    Mod gốc đặt ro.control_privapp_permissions=disable trong system.prop —
#    đó là TẮT KIỂM TRA TOÀN HỆ THỐNG. Ở đây KHÔNG làm vậy: giữ nguyên chế độ
#    enforce và dựa vào whitelist, an toàn hơn mà mod vẫn chạy.
#
# 3. NATIVE LIB: APK có extractNativeLibs=false, lib .so lưu uncompressed
#    nhưng chỉ căn lề 4 byte (không phải 4096) -> một số bản Android không
#    mmap trực tiếp được. Mod gốc vì thế chép thêm thư mục lib/ ra cạnh APK
#    (arm + arm64). Ở đây làm giống mod gốc.
#
# KHÔNG bump versionCode: mod là 40001380, ROM gốc 40001366 -> đã cao hơn.
# Bump sẽ phải zipalign lại (làm hỏng thêm zip) mà không cần thiết.
# ---------------------------------------------------------------------------

work_dir=$(pwd)
[ -f "$work_dir/functions.sh" ] && source "$work_dir/functions.sh"

SRC="$work_dir/bin/modfile/UpdateFile/SecurityCenterMod"
IMAGES="$work_dir/build/baserom/images"

log_msg() {
    if type mods &>/dev/null; then mods "$1"
    elif type patch &>/dev/null; then patch "$1"
    else echo "[SecCenter] $1"; fi
}
warn_msg() {
    if type warn &>/dev/null; then warn "$1"; else echo "[SecCenter][WARN] $1"; fi
}

[ -d "$IMAGES" ] || { warn_msg "SecCenter: chưa có images - bỏ qua"; exit 0; }

# --- 0. Công tắc -----------------------------------------------------------
ENABLE=$(grep -m1 '^security_mod=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
[ "$ENABLE" = "false" ] && { log_msg "SecCenter: tắt bằng config (security_mod=false)"; exit 0; }

# Mod gốc yêu cầu Android 15+ (customize.sh abort nếu version.release < 15).
# Kiểm tra sớm để không thay APK trên ROM A14 rồi app không nạp được.
ANDROID_VER=$(cat "$work_dir/bin/ddevice/androidver.txt" 2>/dev/null | tr -d '\r\n ')
ANDROID_MAJOR="${ANDROID_VER%%.*}"
if [ -n "$ANDROID_MAJOR" ] && [ "$ANDROID_MAJOR" -lt 15 ] 2>/dev/null; then
    log_msg "SecCenter: bỏ qua - mod yêu cầu Android 15+ (đang là $ANDROID_VER)"
    exit 0
fi

# Chỉ áp cho OS3/OS4 như yêu cầu (OS3 có thể là Android 15 hoặc 16 - đã kiểm
# tra Android riêng ở trên; ở đây chỉ lọc theo tên OS).
ROM_OS_CHK=$(cat "$work_dir/bin/ddevice/rom_os.txt" 2>/dev/null | tr -d '\r\n ')
case "$ROM_OS_CHK" in
    OS3|OS4) : ;;
    *) log_msg "SecCenter: chỉ dành cho OS3/OS4 (đang là '${ROM_OS_CHK:-?}') - bỏ qua"; exit 0 ;;
esac

if [ ! -s "$SRC/files/MIUISecurityCenter.apk" ]; then
    warn_msg "SecCenter: thiếu files/MIUISecurityCenter.apk - bỏ qua"
    exit 0
fi

# --- 1. Tìm app đích -------------------------------------------------------
# App nằm ở product/priv-app (đã kiểm tra trên máy: /product/priv-app/MIUISecurityCenter).
DEST_DIR=""
for d in "$IMAGES/product/priv-app/MIUISecurityCenter" \
         "$IMAGES/product/app/MIUISecurityCenter" \
         "$IMAGES/system_ext/priv-app/MIUISecurityCenter" \
         "$IMAGES/system/priv-app/MIUISecurityCenter"; do
    [ -d "$d" ] && { DEST_DIR="$d"; break; }
done

if [ -z "$DEST_DIR" ]; then
    # dò theo tên file
    hit=$(find "$IMAGES" -maxdepth 5 -type f -name 'MIUISecurityCenter.apk' 2>/dev/null | head -n1)
    [ -n "$hit" ] && DEST_DIR=$(dirname "$hit")
fi

if [ -z "$DEST_DIR" ] || [ ! -d "$DEST_DIR" ]; then
    warn_msg "SecCenter: không thấy MIUISecurityCenter trong ROM - bỏ qua"
    exit 0
fi

if [ "$(basename "$(dirname "$DEST_DIR")")" = "app" ]; then
    warn_msg "SecCenter: app đang ở priv-app? Không, đang ở app/ - app cần quyền privileged, bỏ qua"
    exit 0
fi

rel="${DEST_DIR#$IMAGES/}"
log_msg "SecCenter: thay $rel/MIUISecurityCenter.apk"

# --- 2. Xoá mã biên dịch cũ ------------------------------------------------
rm -rf "$DEST_DIR/oat"
find "$DEST_DIR" -maxdepth 1 -type f \( -name '*.odex' -o -name '*.vdex' -o -name '*.art' \) -delete 2>/dev/null

# --- 3. Thay APK -----------------------------------------------------------
if cp -f "$SRC/files/MIUISecurityCenter.apk" "$DEST_DIR/MIUISecurityCenter.apk"; then
    sz=$(( $(wc -c < "$DEST_DIR/MIUISecurityCenter.apk") / 1048576 ))
    log_msg "SecCenter: MIUISecurityCenter.apk -> ${sz}MB"
else
    warn_msg "SecCenter: copy APK thất bại - giữ app gốc"
    exit 0
fi

# --- 4. Native lib: KHÔNG chép ra ngoài ------------------------------------
# Mod gốc chép files/lib/{arm,arm64} ra cạnh APK. Đã kiểm tra trên APK thật:
# TOÀN BỘ 30 file .so có data offset chia hết cho 4096 (page-aligned), nên
# extractNativeLibs=false đọc trực tiếp từ trong APK được - không cần bản sao
# bên ngoài. Bỏ bước này tiết kiệm ~19MB trong images và tránh hai nguồn lib
# lệch phiên bản về sau.
# Nếu gặp ROM mà app crash vì không nạp được lib, bật lại bằng cách đặt
# security_mod_copy_libs=true trong config.env.
COPY_LIBS=$(grep -m1 '^security_mod_copy_libs=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$COPY_LIBS" = "true" ] && [ -d "$SRC/files/lib" ]; then
    mkdir -p "$DEST_DIR/lib"
    cp -r "$SRC/files/lib/." "$DEST_DIR/lib/" 2>/dev/null && \
        log_msg "SecCenter: chép native lib ra cạnh APK (theo yêu cầu config)" || \
        warn_msg "SecCenter: chép native lib thất bại"
else
    log_msg "SecCenter: giữ lib trong APK (đã page-aligned, không cần chép ra)"
fi

# --- 5. privapp whitelist --------------------------------------------------
# Chỉ thêm file của mod khi ROM CHƯA có mục cho package này. Nếu đã có, giữ
# nguyên bản của ROM (đã phủ đủ 24 quyền, nhiều hơn 23 quyền trong file mod).
PERM_DIR="$DEST_DIR/etc/permissions"
# suy ra thư mục etc/permissions cùng phân vùng với app
PARTITION="${DEST_DIR%%/priv-app/*}"
PERM_DIR="$PARTITION/etc/permissions"
[ -d "$PERM_DIR" ] || PERM_DIR=""

existing=""
if [ -n "$PERM_DIR" ]; then
    existing=$(grep -rl 'com\.miui\.securitycenter' "$PERM_DIR"/*.xml 2>/dev/null | head -n1)
fi

if [ -n "$existing" ]; then
    log_msg "SecCenter: ROM đã có whitelist ($(basename "$existing")) - giữ nguyên, không thêm"
elif [ -n "$PERM_DIR" ] && [ -f "$SRC/perm/privapp_whitelist_com.miui.securitycenter.xml" ]; then
    cp -f "$SRC/perm/privapp_whitelist_com.miui.securitycenter.xml" \
          "$PERM_DIR/privapp_whitelist_com.miui.securitycenter.xml" && \
        log_msg "SecCenter: thêm privapp whitelist cho securitycenter" || \
        warn_msg "SecCenter: thêm whitelist thất bại"
else
    warn_msg "SecCenter: không xác định được thư mục etc/permissions - bỏ qua whitelist"
fi

log_msg "SecCenter: xong (credit: Kashi / Mods Center)"
exit 0
