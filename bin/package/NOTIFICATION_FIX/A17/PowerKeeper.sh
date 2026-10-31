#!/bin/bash
# BugOS - NOTIFICATION_FIX A17 - PowerKeeper
# Credit: hướng dẫn gốc của @MMETMAmods
#
# Khác bản A16: KHÔNG rebuild cả APK bằng apke.jar.
#
# Trên Android 17, `apke.jar b` không dựng lại được PowerKeeper.apk (build im
# lặng thất bại), nên bản A16 rơi vào nhánh "giữ nguyên bản gốc" và bản vá thông
# báo không được áp - đúng như log build OS4:
#     [PATCH] - Fail: không build lại được PowerKeeper.apk, giữ nguyên bản gốc!
#
# Ở đây chỉ thay classes*.dex bên trong APK (bin/tools/apk_dex_patch.py), mọi
# entry khác giữ nguyên byte: không đụng resources.arsc, không đụng res/, nên
# không có chỗ nào để hỏng.

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

# ---- 3. MilletConfig: IS_INTERNATIONAL_BUILD -> IS_MIUI --------------------
# A16 chỉ sửa đúng file MilletConfig.smali. Trên A17 chỗ tham chiếu đó có thể
# nằm ở class khác (hoặc MilletConfig.smali đổi tên) nên quét TOÀN BỘ smali.
n_files=$(grep -rl 'Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z' "$TMP/smali" 2>/dev/null | wc -l)
n_files=${n_files:-0}
if [ "$n_files" -gt 0 ]; then
    grep -rl 'Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z' "$TMP/smali" 2>/dev/null \
        | while IFS= read -r f; do
            sed -i 's|Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z|Lmiui/os/Build;->IS_MIUI:Z|g' "$f"
        done
    patched=1
    log_msg "Đã vá IS_INTERNATIONAL_BUILD -> IS_MIUI ở $n_files file (PowerKeeper)"
else
    log_msg "Cảnh báo: PowerKeeper không tham chiếu IS_INTERNATIONAL_BUILD"
fi

# ---- 4. GmsObserver: isGmsControlEnabled()Z -> false ----------------------
# Thay cả thân hàm bằng hằng số: bản A16 chèn lại một thân hàm cụ thể có tham
# chiếu tới field mContext/mGmsUserConfigure - nếu A17 đổi tên field thì smali
# không assemble được và mất luôn cả bản vá. Stub thì không phụ thuộc field.
GMS=$(find "$TMP/smali" -type f -name "GmsObserver.smali" 2>/dev/null | head -n1)
if [ -n "$GMS" ]; then
    if python3 "$METHTOOL" "$GMS" isGmsControlEnabled Z 0 >/dev/null 2>&1; then
        patched=1
        log_msg "Đã vá thành công GmsObserver (Thả rông GMS)"
    else
        log_msg "Cảnh báo: không thấy isGmsControlEnabled()Z trong GmsObserver"
    fi
else
    log_msg "Cảnh báo: không thấy GmsObserver.smali"
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
ok=0
if [ "$n_files" -gt 0 ] && grep -aq "IS_MIUI" "$OUT" 2>/dev/null; then
    ok=1
fi
if [ -n "$GMS" ]; then
    if python3 - "$GMS" <<'PY' >/dev/null 2>&1
import re, sys
s = open(sys.argv[1], encoding='utf-8').read()
m = re.search(r'\.method[^\n]*isGmsControlEnabled\([^\n]*\)Z(.*?)\.end method', s, re.S)
sys.exit(0 if m and 'const/4 v0, 0x0' in m.group(1) else 1)
PY
    then
        ok=1
    fi
fi
if [ "$ok" -eq 0 ]; then
    log_msg "Fail: APK mới không chứa dấu vết bản vá, giữ nguyên bản gốc!"
    exit 0
fi

# ---- 8. thay vào ROM, dọn mã biên dịch cũ ---------------------------------
rm -f "$APKDIR"/*.odex "$APKDIR"/*.vdex "$APKDIR"/*.art 2>/dev/null
rm -rf "$APKDIR/oat"
cp -f "$OUT" "$APK"
log_msg "Hoàn tất vá PowerKeeper.apk (chỉ thay dex, không rebuild resource)!"
