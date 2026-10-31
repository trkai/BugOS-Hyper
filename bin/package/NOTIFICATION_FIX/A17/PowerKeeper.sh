#!/bin/bash
# BugOS - NOTIFICATION_FIX A17 - PowerKeeper
# Credit: hướng dẫn gốc của @MMETMAmods
#
# Hai điểm khác bản A16, cả hai đều do cấu trúc A17 đã đổi (kiểm tra trên
# PowerKeeper.apk thật lấy từ máy bằng `adb pull`):
#
# 1. KHÔNG rebuild cả APK bằng apke.jar. Trên A17 `apke.jar b` thất bại, nên bản
#    A16 rơi vào nhánh "giữ nguyên bản gốc" và bản vá không được áp:
#        [PATCH] - Fail: không build lại được PowerKeeper.apk, giữ nguyên bản gốc!
#    Ở đây chỉ thay classes.dex bên trong APK (bin/tools/apk_dex_patch.py).
#
# 2. KHÔNG còn MilletConfig.smali, và KHÔNG vá tràn lan IS_INTERNATIONAL_BUILD.
#
#    Bản A16 sửa đúng MilletConfig.smali. Trên A17 file đó không tồn tại
#    (đã xác nhận: find không ra), nên bản cũ báo "không vá được MilletConfig".
#
#    Cám dỗ là thay IS_INTERNATIONAL_BUILD -> IS_MIUI ở mọi file (28 class). Đã
#    thử và ĐỪNG làm vậy: DeviceIdleController dùng cờ này để chọn 1 trong 2
#    whitelist doze:
#        !IS_INTERNATIONAL_BUILD -> "doze_always_white_apps"
#                                   = com.tencent.mm, mobileqq, qqlite
#        IS_INTERNATIONAL_BUILD  -> "doze_power_save_mode_intl_third_party"
#                                   = app Trustonic / payjoy / airtelkiosk
#    Ép thành "international" sẽ BỎ WeChat/QQ khỏi whitelist mà không thêm được
#    Google nào (cả 2 danh sách đều không có Google). Tức là làm tệ hơn.
#
#    Việc thật sự cần làm chỉ là tắt giới hạn mạng GMS của PowerKeeper:
#    A16 có isGmsControlEnabled(), A17 đổi thành updateFrameworkGmsNetStatus(Z)Z
#    (gọi greeze để đặt limit mạng cho GMS). Cho nó trả false = không đặt limit.

work_dir=$(pwd)
[ -f "$work_dir/functions.sh" ] && source "$work_dir/functions.sh"

MAIN_FOLDER="$work_dir/build/baserom/images"
TMP="$work_dir/apk_temp_pk"
DEXTOOL="$work_dir/bin/tools/apk_dex_patch.py"
METHTOOL="$work_dir/bin/tools/patch_smali_method.py"

SDK=$(cat "$work_dir/bin/ddevice/sdkLevel.txt" 2>/dev/null | tr -d '\r\n ')
[ -z "$SDK" ] && SDK=37

BAK="java -jar $work_dir/bin/apktool/baksmaliv2.jar d --api $SDK"
SMA="java -jar $work_dir/bin/apktool/smaliv2.jar a --api $SDK"

log_msg() {
    if type patch &>/dev/null; then patch "$1"
    elif type mods &>/dev/null; then mods "$1"
    elif type info &>/dev/null; then info "$1"
    else echo "[PowerKeeper] $1"; fi
}

log_msg "Bắt đầu Patching PowerKeeper (Fix Thông Báo)..."

APK=$(find "$MAIN_FOLDER" -type f -name "PowerKeeper.apk" 2>/dev/null | head -n1)
if [ -z "$APK" ]; then
    log_msg "Không có PowerKeeper.apk trong ROM này, bỏ qua!"
    exit 0
fi
APKDIR=$(dirname "$APK")

cleanup() { rm -rf "$TMP"; }
trap cleanup EXIT

rm -rf "$TMP"
mkdir -p "$TMP"

# ---- 1. tách dex -----------------------------------------------------------
if ! python3 "$DEXTOOL" unpack "$APK" "$TMP" >/dev/null 2>&1; then
    log_msg "Fail: không tách được dex khỏi PowerKeeper.apk, giữ nguyên bản gốc!"
    exit 0
fi

# ---- 2. baksmali -----------------------------------------------------------
for d in "$TMP"/dex/*.dex; do
    [ -f "$d" ] || continue
    n=$(basename "$d" .dex)
    if ! $BAK "$d" -o "$TMP/smali/$n" >/dev/null 2>&1; then
        log_msg "Fail: baksmali $n thất bại, giữ nguyên bản gốc!"
        exit 0
    fi
done

if ! compgen -G "$TMP/smali/*" >/dev/null; then
    log_msg "Fail: không có smali nào sau khi baksmali, giữ nguyên bản gốc!"
    exit 0
fi

patched=0
gms_method=""

# ---- 3. tắt giới hạn mạng GMS của PowerKeeper ------------------------------
# A16: isGmsControlEnabled()Z ; A17: updateFrameworkGmsNetStatus(Z)Z
# Thay thân hàm bằng hằng số: không phụ thuộc field, không phụ thuộc tham số.
GMS=$(find "$TMP/smali" -type f -name "GmsObserver.smali" 2>/dev/null | head -n1)
if [ -n "$GMS" ]; then
    for m in isGmsControlEnabled updateFrameworkGmsNetStatus; do
        if python3 "$METHTOOL" "$GMS" "$m" Z 0 >/dev/null 2>&1; then
            patched=1
            gms_method="$m"
            log_msg "Đã vá GmsObserver.$m -> false (thả GMS, không giới hạn mạng)"
            break
        fi
    done
    if [ -z "$gms_method" ]; then
        log_msg "Cảnh báo: GmsObserver không có isGmsControlEnabled/updateFrameworkGmsNetStatus"
    fi
else
    log_msg "Cảnh báo: không thấy GmsObserver.smali"
fi

# ---- 4. chỉ ghi nhận, KHÔNG vá IS_INTERNATIONAL_BUILD ----------------------
n_intl=$(grep -rl 'IS_INTERNATIONAL_BUILD:Z' "$TMP/smali" 2>/dev/null | wc -l)
n_intl=${n_intl:-0}
if [ "$n_intl" -gt 0 ]; then
    log_msg "Ghi chú: $n_intl class còn đọc IS_INTERNATIONAL_BUILD - cố ý không vá (xem đầu file)"
fi

if [ "$patched" -eq 0 ]; then
    log_msg "Không vá được gì, giữ nguyên PowerKeeper.apk gốc!"
    exit 0
fi

# ---- 5. smali lại ----------------------------------------------------------
for d in "$TMP"/smali/*; do
    [ -d "$d" ] || continue
    n=$(basename "$d")
    if ! $SMA "$d" -o "$TMP/dex/$n.dex" >/dev/null 2>&1; then
        log_msg "Fail: smali $n thất bại, giữ nguyên bản gốc!"
        exit 0
    fi
done

# ---- 6. đóng gói lại (chỉ thay dex) ---------------------------------------
OUT="$TMP/PowerKeeper.apk"
if ! python3 "$DEXTOOL" repack "$APK" "$TMP" "$OUT" >/dev/null 2>&1; then
    log_msg "Fail: không đóng gói lại được APK, giữ nguyên bản gốc!"
    exit 0
fi
if ! unzip -t "$OUT" >/dev/null 2>&1; then
    log_msg "Fail: APK mới hỏng (zip không hợp lệ), giữ nguyên bản gốc!"
    exit 0
fi

# ---- 7. kiểm tra dấu vết bản vá trong APK mới -----------------------------
if [ -n "$gms_method" ]; then
    if python3 - "$GMS" "$gms_method" <<'PY' >/dev/null 2>&1
import re, sys
s = open(sys.argv[1], encoding='utf-8').read()
name = re.escape(sys.argv[2])
m = re.search(r'\.method[^\n]*\b' + name + r'\([^\n]*\)Z(.*?)\.end method', s, re.S)
sys.exit(0 if m and 'const/4 v0, 0x0' in m.group(1) else 1)
PY
    then
        :
    else
        log_msg "Fail: APK mới không chứa dấu vết bản vá, giữ nguyên bản gốc!"
        exit 0
    fi
fi

# ---- 8. thay vào ROM, dọn mã biên dịch cũ ---------------------------------
rm -f "$APKDIR"/*.odex "$APKDIR"/*.vdex "$APKDIR"/*.art 2>/dev/null
rm -rf "$APKDIR/oat"
cp -f "$OUT" "$APK"
log_msg "Hoàn tất vá PowerKeeper.apk (chỉ thay dex, không rebuild resource)!"
