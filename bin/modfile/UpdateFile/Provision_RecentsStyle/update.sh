work_dir=$(pwd)
source "$work_dir/functions.sh"

# ---------------------------------------------------------------------------
# Setup Wizard chỉ cho chọn 2 kiểu Gần đây (Dọc / Ngang), thiếu "Xếp chồng".
#
# Đọc com.android.provision (lấy từ máy) thì ra đúng chuỗi này:
#
#   RecentTaskStyleFragment.adjustLayoutByStyleCount()
#       nums = Utils.getRecentsLayoutStyleNums(activity);
#       if (!isSupportStackedLayout()) {                  // nums < 3
#           mVisualCheckGroup.removeView(mRecentStackedCheckBox);   // xoá ô thứ 3
#       }
#
#   RecentTaskStyleFragment.isSupportStackedLayout()
#       return recentsLayoutStyleNums >= 3;
#
#   Utils.getRecentsLayoutStyleNums(Context)
#       int v3 = 2;                                       // ← MẶC ĐỊNH
#       ... resolver.call(uri, "getRecentsLayoutStyleNums")  // hỏi launcher
#       if (bundle == null) return v3;                    // launcher chưa trả lời
#
# Lúc Setup Wizard chạy, launcher chưa sẵn sàng trả lời ContentProvider nên hàm
# này rơi về mặc định 2 -> ô "Xếp chồng" bị removeView -> chỉ còn 2 lựa chọn.
# Sau khi setup xong, trang đầy đủ của launcher hiện đủ 3 (đã xác nhận trên máy).
#
# Sửa: đổi hằng số mặc định 2 -> 3. Một chỗ, và vì nums cũng được dùng cho
# setupImageViewsLayout/setupHintTextViewsLayout nên bố cục 3 ô cũng đúng luôn
# (nếu chỉ ép isSupportStackedLayout()=true thì ô hiện ra nhưng chia theo 2).
# ---------------------------------------------------------------------------

MAIN_FOLDER="$work_dir/build/baserom/images"
FINDER="$work_dir/bin/modfile/UpdateFile/Apps_Replace/find_apk_by_package.py"
DEXTOOL="$work_dir/bin/tools/apk_dex_patch.py"
PKG="com.android.provision"

SDK=$(cat "$work_dir/bin/ddevice/sdkLevel.txt" 2>/dev/null | tr -d '\r\n ')
[ -z "$SDK" ] && SDK=37
BAK="java -jar $work_dir/bin/apktool/baksmaliv2.jar d --api $SDK"
SMA="java -jar $work_dir/bin/apktool/smaliv2.jar a --api $SDK"

TMP="$work_dir/apk_temp_prov"
cleanup() { rm -rf "$TMP"; }
trap cleanup EXIT

[ -f "$FINDER" ] || { warn "Provision: thiếu find_apk_by_package.py - bỏ qua"; exit 0; }
[ -f "$DEXTOOL" ] || { warn "Provision: thiếu apk_dex_patch.py - bỏ qua"; exit 0; }

APK=$(python3 "$FINDER" "$MAIN_FOLDER" "$PKG" 2>/dev/null)
if [ -z "$APK" ]; then
    warn "Provision: không thấy $PKG trong images - bỏ qua"
    exit 0
fi
if [ "$(python3 "$FINDER" x --pkg-of "$APK" 2>/dev/null)" != "$PKG" ]; then
    warn "Provision: $APK không khai đúng package - bỏ qua"
    exit 0
fi

rel="${APK#$MAIN_FOLDER/}"
rel="${rel#$MAIN_FOLDER}"
[ "$rel" = "$APK" ] && rel=$(printf '%s' "$APK" | awk -F/ '{print $(NF-2)"/"$(NF-1)"/"$NF}')

mods "Provision: vá số kiểu Gần đây cho Setup Wizard ($rel)"

rm -rf "$TMP"
mkdir -p "$TMP"

python3 "$DEXTOOL" unpack "$APK" "$TMP" >/dev/null 2>&1 || {
    warn "Provision: không tách được dex - giữ nguyên APK gốc"; exit 0; }

for d in "$TMP"/dex/*.dex; do
    [ -f "$d" ] || continue
    n=$(basename "$d" .dex)
    $BAK "$d" -o "$TMP/smali/$n" >/dev/null 2>&1 || {
        warn "Provision: baksmali $n thất bại - giữ nguyên APK gốc"; exit 0; }
done

U=$(find "$TMP/smali" -type f -path "*/com/android/provision/Utils.smali" 2>/dev/null | head -n1)
if [ -z "$U" ]; then
    warn "Provision: không thấy Utils.smali - giữ nguyên APK gốc"
    exit 0
fi

# Chỉ đổi hằng số bên trong getRecentsLayoutStyleNums, không đụng chỗ khác.
if ! python3 - "$U" << 'PYEOF'
import re, sys
from pathlib import Path
p = Path(sys.argv[1])
s = p.read_text()
m = re.search(r'(\.method public static getRecentsLayoutStyleNums\([^\n]*\).*?\.end method)', s, re.S)
if not m:
    print("khong thay getRecentsLayoutStyleNums")
    sys.exit(1)
body = m.group(1)
if 'const/4 v3, 0x3' in body:
    print("da la 3 roi")
    sys.exit(0)
if 'const/4 v3, 0x2' not in body:
    print("khong thay hang so mac dinh 2")
    sys.exit(1)
s = s[:m.start(1)] + body.replace('const/4 v3, 0x2', 'const/4 v3, 0x3', 1) + s[m.end(1):]
p.write_text(s)
print("da doi mac dinh 2 -> 3")
PYEOF
then
    warn "Provision: không vá được hằng số mặc định - giữ nguyên APK gốc"
    exit 0
fi

for d in "$TMP"/smali/*; do
    [ -d "$d" ] || continue
    n=$(basename "$d")
    $SMA "$d" -o "$TMP/dex/$n.dex" >/dev/null 2>&1 || {
        warn "Provision: smali $n thất bại - giữ nguyên APK gốc"; exit 0; }
done

OUT="$TMP/Provision.apk"
python3 "$DEXTOOL" repack "$APK" "$TMP" "$OUT" >/dev/null 2>&1 || {
    warn "Provision: đóng gói lại thất bại - giữ nguyên APK gốc"; exit 0; }

# Setup Wizard là app sống-còn của lần boot đầu: kiểm tra kỹ trước khi thay.
if ! unzip -t "$OUT" >/dev/null 2>&1; then
    warn "Provision: APK mới hỏng (zip) - giữ nguyên bản gốc"; exit 0
fi
if [ "$(python3 "$FINDER" x --pkg-of "$OUT" 2>/dev/null)" != "$PKG" ]; then
    warn "Provision: APK mới sai package - giữ nguyên bản gốc"; exit 0
fi
if ! grep -q 'const/4 v3, 0x3' "$U"; then
    warn "Provision: APK mới không chứa thay đổi - giữ nguyên bản gốc"; exit 0
fi

APKDIR=$(dirname "$APK")
rm -f "$APKDIR"/*.odex "$APKDIR"/*.vdex "$APKDIR"/*.art 2>/dev/null
rm -rf "$APKDIR/oat"
cp -f "$OUT" "$APK"
mods "Provision: Setup Wizard giờ hiện đủ 3 kiểu Gần đây (Dọc/Ngang/Xếp chồng)"
