work_dir=$(pwd)
source "$work_dir/functions.sh"

# ---------------------------------------------------------------------------
# Setup Wizard chỉ cho chọn 2 kiểu Gần đây (Dọc / Ngang), thiếu "Xếp chồng".
#
# com.android.provision, RecentTaskStyleFragment:
#
#   adjustLayoutByStyleCount()
#       nums = Utils.getRecentsLayoutStyleNums(activity);
#       if (!isSupportStackedLayout()) {                  // nums < 3
#           mVisualCheckGroup.removeView(mRecentStackedCheckBox);   // xoá ô thứ 3
#       }
#
#   isSupportStackedLayout()
#       return recentsLayoutStyleNums >= 3;
#
#   Utils.getRecentsLayoutStyleNums(Context)
#       int v3 = 2;                                       // ← MẶC ĐỊNH
#       ... resolver.call(uri, "getRecentsLayoutStyleNums")  // hỏi launcher
#       if (bundle == null) return v3;                    // launcher chưa trả lời
#
# Bản vá trước chỉ đổi hằng số mặc định 2 -> 3. Nó không ăn, vì:
#   * hằng số đó nằm trong một thanh ghi cụ thể (bản OS3 là v3, bản OS4 có thể
#     là v0/v1/v2) nên điều kiện 'const/4 v3, 0x2' không khớp -> script lặng lẽ
#     bỏ qua, giữ nguyên APK gốc;
#   * và kể cả khi khớp, nếu launcher kịp trả lời provider thì giá trị mặc định
#     không bao giờ được dùng tới.
#
# Bản này không phụ thuộc thanh ghi và không phụ thuộc provider: thay hẳn thân
# hai hàm bằng giá trị hằng.
#   getRecentsLayoutStyleNums(...)  ->  return 3
#   isSupportStackedLayout()        ->  return true
# nums cũng được dùng cho setupImageViewsLayout/setupHintTextViewsLayout nên
# trả 3 là bố cục 3 ô cũng chia đúng (ép mỗi isSupportStackedLayout thì ô thứ 3
# hiện ra nhưng bị chia theo 2).
# ---------------------------------------------------------------------------

MAIN_FOLDER="$work_dir/build/baserom/images"
FINDER="$work_dir/bin/modfile/UpdateFile/Apps_Replace/find_apk_by_package.py"
DEXTOOL="$work_dir/bin/tools/apk_dex_patch.py"
DUMPDIR="$work_dir/documentation/provision_src"
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

mods "Provision: vá bộ chọn kiểu Gần đây cho Setup Wizard ($rel)"

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

# Bản gốc của hai file quyết định, để lần sau đọc được mà không cần máy thật.
mkdir -p "$DUMPDIR"
for f in $(grep -rls --include="*.smali" "getRecentsLayoutStyleNums" "$TMP/smali" 2>/dev/null); do
    cp -f "$f" "$DUMPDIR/$(basename "$f").orig" 2>/dev/null
done
for f in $(grep -rls --include="*.smali" "isSupportStackedLayout" "$TMP/smali" 2>/dev/null); do
    b=$(basename "$f").orig
    [ -f "$DUMPDIR/$b" ] || cp -f "$f" "$DUMPDIR/$b" 2>/dev/null
done

cat > "$TMP/patch_provision.py" << 'PYEOF'
import re, sys
from pathlib import Path

# name -> (gia tri tra ve, cau lenh nap)
FORCE = [
    ("getRecentsLayoutStyleNums", "const/4 v0, 0x3"),
    ("isSupportStackedLayout",    "const/4 v0, 0x1"),
]

def patch_method(text, name, insn):
    pat = re.compile(r"(\.method[ \t][^\n]*?\b" + re.escape(name) + r"\()([^\n]*\n)(.*?)(\.end method)", re.S)
    m = pat.search(text)
    if not m:
        return text, "khong-thay"
    decl, args, body, endm = m.group(1), m.group(2), m.group(3), m.group(4)
    if "return v0" in body and insn in body and len(body) < 120:
        return text, "da-roi"
    # giu lai annotation (neu co) de khong lam hong metadata cua method
    anns = re.findall(r"[ \t]*\.annotation[^\n]*\n(?:.*?\n)?[ \t]*\.end annotation[ \t]*\n", body, re.S)
    new_body = ""
    for a in anns:
        new_body += a
    new_body += "    .locals 1\n\n    %s\n\n    return v0\n" % insn
    text = text[:m.start()] + decl + args + new_body + endm + text[m.end():]
    return text, "da-vá"

changed_any = False
report = []

def nop_stacked_removal(text):
    """Bo lenh removeView(o Xep chong) neu trong ham chi co dung mot lenh do."""
    m = re.search(r"(\.method[ \t][^\n]*\badjustLayoutByStyleCount\([^\n]*\n)(.*?)(\.end method)", text, re.S)
    if not m:
        return text, "khong-thay"
    body = m.group(2)
    hits = [l for l in body.splitlines()
            if "Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V" in l]
    if len(hits) != 1:
        return text, "bo-qua(%d)" % len(hits)
    return text[:m.start(2)] + body.replace(hits[0], "    nop") + text[m.end(2):], "da-nop"

for path in sys.argv[1:]:
    p = Path(path)
    s = p.read_text()
    orig = s
    for name, insn in FORCE:
        s, st = patch_method(s, name, insn)
        report.append("%s:%s=%s" % (p.name, name, st))
        if st == "da-vá":
            changed_any = True
    s, st = nop_stacked_removal(s)
    if st != "khong-thay":
        report.append("%s:adjustLayoutByStyleCount=%s" % (p.name, st))
        if st == "da-nop":
            changed_any = True
    if s != orig:
        p.write_text(s)

print("; ".join(report))
sys.exit(0 if changed_any else 1)
PYEOF

TARGETS=$(grep -rls --include="*.smali" "getRecentsLayoutStyleNums\|isSupportStackedLayout" "$TMP/smali" 2>/dev/null)
if [ -z "$TARGETS" ]; then
    warn "Provision: APK không có getRecentsLayoutStyleNums/isSupportStackedLayout - giữ nguyên APK gốc"
    exit 0
fi

# File nào thật sự khai báo từng hàm (để kiểm tra lại sau khi vá).
U=$(grep -rls --include="*.smali" -E "\.method[[:space:]].*getRecentsLayoutStyleNums\(" "$TMP/smali" 2>/dev/null | head -n1)
S=$(grep -rls --include="*.smali" -E "\.method[[:space:]].*isSupportStackedLayout\(" "$TMP/smali" 2>/dev/null | head -n1)

# shellcheck disable=SC2086
PATCHMSG=$(python3 "$TMP/patch_provision.py" $TARGETS 2>&1)
PYRC=$?
mods "Provision: $PATCHMSG"
if [ "$PYRC" -ne 0 ]; then
    warn "Provision: không thay được thân hàm nào - giữ nguyên APK gốc"
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
if ! grep -q "const/4 v0, 0x3" "$U" 2>/dev/null; then
    warn "Provision: bản vá không nằm trong $U - giữ nguyên bản gốc"; exit 0
fi
if [ -n "$S" ] && ! grep -q "const/4 v0, 0x1" "$S" 2>/dev/null; then
    warn "Provision: bản vá isSupportStackedLayout không nằm trong $S - giữ nguyên bản gốc"; exit 0
fi

APKDIR=$(dirname "$APK")
rm -f "$APKDIR"/*.odex "$APKDIR"/*.vdex "$APKDIR"/*.art 2>/dev/null
rm -rf "$APKDIR/oat"
cp -f "$OUT" "$APK"
mods "Provision: Setup Wizard giờ hiện đủ 3 kiểu Gần đây (Dọc/Ngang/Xếp chồng)"
