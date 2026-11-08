#!/bin/bash
# ---------------------------------------------------------------------------
# System_GmsCoreAlwaysOn - ép "Dịch vụ cơ bản của Google" luôn BẬT.
#
# TRIỆU CHỨNG: tắt switch đó thì CH Play biến mất khỏi màn hình chính.
#
# NGUYÊN NHÂN (đọc smali SecurityCenter, không đoán):
#   com.miui.googlebase.ui.GmsCoreSettings$SettingsFragment.onPreferenceChange
#   gọi sc.a.g(Context, int) với:
#       checked = true  -> g(ctx, 1)   COMPONENT_ENABLED_STATE_ENABLED
#       checked = false -> g(ctx, 2)   COMPONENT_ENABLED_STATE_DISABLED
#   sc.a.g() gọi setApplicationEnabledSetting() cho đúng 3 package
#   (sc.a.b trong <clinit>):
#       com.android.vending, com.google.android.gms, com.google.android.gsf
#   và sc.a.c() đọc getApplicationEnabledSetting() để quyết định switch hiển thị.
#   => "CH Play biến mất" là cả 3 package bị DISABLE, không phải app bị gỡ.
#      Vì vậy không có key Settings nào để đặt sẵn - trạng thái nằm trong
#      PackageManager, không nằm trong Settings provider.
#
# CÁCH SỬA (một dòng smali): trong sc.a.g(), ngay sau "move/from16 v0, p1"
# (v0 giữ tham số state), chèn "const/4 v0, 0x1" để state luôn là ENABLED.
# Hệ quả: không tắt được nữa - gạt sang tắt thì g() vẫn bật lại, và
# onPreferenceChange gọi lại c() nên switch tự nhảy về ON.
#
# ĐO TRÊN MÁY 08/11 (annibale, OS4.0.5.0), bản SecurityCenter đang chạy:
#   trước patch: gạt tắt -> "pm list packages -d" có đủ 3 gói,
#                launcher mất CH Play (query-activities đếm 0)
#   sau patch:   gạt tắt -> 3 gói vẫn enabled (đếm 0), CH Play vẫn mở được
#                (topResumedActivity = com.android.vending/.AssetBrowserActivity),
#                mở lại màn hình đó thì switch = checked true
#
# RỦI RO: SecurityCenter có thể bị kho Xiaomi cập nhật, bản mới sẽ đè patch này.
# Muốn chặn hẳn thì thêm com.miui.securitycenter vào pin_app_versions.
#
# Nếu anchor không khớp (bản SecurityCenter khác), mod cảnh báo và BỎ QUA,
# để nguyên APK gốc - không bao giờ đẩy APK hỏng vào images.
# ---------------------------------------------------------------------------
WORK_DIR=$(pwd)
source "$WORK_DIR/functions.sh"

MAIN_FOLDER="$WORK_DIR/build/baserom/images"
APKEDITOR="java -jar $WORK_DIR/bin/apktool/apke.jar"
FINDER="$WORK_DIR/bin/modfile/UpdateFile/Apps_Replace/find_apk_by_package.py"
WORK_ROOT="$WORK_DIR/.gmscore_patch"

ENABLED=$(grep -m1 '^gmscore_always_on=' "$WORK_DIR/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$ENABLED" = "false" ]; then
    mods "GmsCore: gmscore_always_on=false - bỏ qua"
    exit 0
fi

if [ ! -d "$MAIN_FOLDER" ]; then
    warn "GmsCore: không thấy images - bỏ qua"
    exit 0
fi

if [ ! -f "$FINDER" ]; then
    warn "GmsCore: thiếu find_apk_by_package.py - bỏ qua"
    exit 0
fi

APK=$(python3 "$FINDER" "$MAIN_FOLDER" com.miui.securitycenter 2>/dev/null)
if [ -z "$APK" ] || [ ! -f "$APK" ]; then
    warn "GmsCore: không thấy SecurityCenter (com.miui.securitycenter) trong images - bỏ qua"
    exit 0
fi

REL="${APK#$MAIN_FOLDER/}"
mods "GmsCore: vá ${REL}"

DEC="$WORK_ROOT/decoded"
OUT="$WORK_ROOT/out"
rm -rf "$WORK_ROOT"
mkdir -p "$OUT"

if ! $APKEDITOR d -f -i "$APK" -o "$DEC" > "$WORK_ROOT/decode.log" 2>&1; then
    warn "GmsCore: decode thất bại - bỏ qua. $(tail -n 3 "$WORK_ROOT/decode.log" | tr '\n' ' ')"
    rm -rf "$WORK_ROOT"
    exit 0
fi

SMALI=$(find "$DEC" -type f -path "*/sc/a.smali" 2>/dev/null | head -n 1)
if [ -z "$SMALI" ]; then
    warn "GmsCore: không thấy lớp sc/a trong SecurityCenter - bỏ qua"
    rm -rf "$WORK_ROOT"
    exit 0
fi

RESULT=$(python3 - "$SMALI" <<'PY'
import re
import sys

path = sys.argv[1]
src = open(path, encoding='utf-8').read()

# Chỉ sửa trong đúng method g(Context,int), không đụng method khác.
pat = re.compile(
    r'(\.method[^\n]*\bg\(Landroid/content/Context;I\)V\n)(.*?)(\.end method)',
    re.S,
)
m = pat.search(src)
if not m:
    print('NO_METHOD')
    sys.exit(1)

body = m.group(2)
anchor = 'move/from16 v0, p1\n'
if body.count(anchor) != 1:
    print('ANCHOR_%d' % body.count(anchor))
    sys.exit(1)

# state -> luôn ENABLED. const/4 nằm sau anchor, cùng indent 4 space.
new_body = body.replace(
    anchor,
    anchor + '\n    # BugOS: GmsCore luôn BẬT - ép state = COMPONENT_ENABLED_STATE_ENABLED\n'
             '    const/4 v0, 0x1\n',
)

src = src[:m.start(2)] + new_body + src[m.end(2):]
open(path, 'w', encoding='utf-8').write(src)
print('OK')
PY
)

case "$RESULT" in
    OK)
        ;;
    NO_METHOD)
        warn "GmsCore: không thấy method g(Context,int) - bỏ qua, giữ APK gốc"
        rm -rf "$WORK_ROOT"
        exit 0
        ;;
    *)
        warn "GmsCore: anchor lạ ($RESULT) - bỏ qua, giữ APK gốc"
        rm -rf "$WORK_ROOT"
        exit 0
        ;;
esac

# Ẩn hẳn mục đó khỏi Settings: đặt android:enabled="false" cho activity
# com.miui.googlebase.ui.GmsCoreSettings.
#
# Vì sao cách này là đủ và gọn:
#   SettingsFeatures.isNeedRemoveGmsCoreSettings() trả TRUE (= ẩn mục) khi
#   activity không resolve được. Nó resolve bằng
#   Intent("miui.intent.action.APP_SETTINGS").setClassName(securitycenter,
#   GmsCoreSettings).resolveActivityInfo(pm, MATCH_DEFAULT_ONLY) và nếu kết quả
#   null thì trả true. Component bị disable thì resolve trả null.
#   => Settings tự bỏ mục "Dịch vụ cơ bản của Google", kể cả trong kết quả tìm
#      kiếm (SyncSettingsTree.getStatus cũng dùng đúng hàm đó).
#   Không phải sửa Settings.apk (138 MB) nên build không chậm thêm.
MANIFEST="$DEC/AndroidManifest.xml"
MF_RESULT=$(python3 - "$MANIFEST" <<'PY'
import re
import sys

path = sys.argv[1]
src = open(path, encoding='utf-8').read()

NAME = 'android:name="com.miui.googlebase.ui.GmsCoreSettings"'
pos = src.find(NAME)
if pos < 0:
    print('NO_ACTIVITY')
    sys.exit(1)

# Lùi về đầu thẻ <activity chứa attribute này (chỉ trong phạm vi 800 ký tự để
# không lùi nhầm sang thẻ khác nếu name xuất hiện ở nơi khác).
start = src.rfind('<activity', max(0, pos - 800), pos)
if start < 0:
    print('NO_TAG')
    sys.exit(1)

end = src.find('>', pos)
if end < 0:
    print('NO_END')
    sys.exit(1)

tag = src[start:end + 1]
if 'android:enabled=' in tag:
    new_tag = re.sub(r'android:enabled="[^"]*"', 'android:enabled="false"', tag)
else:
    if tag.endswith('/>'):
        new_tag = tag[:-2].rstrip() + '\n              android:enabled="false" />'
    else:
        new_tag = tag[:-1].rstrip() + '\n              android:enabled="false">'

src = src[:start] + new_tag + src[end + 1:]
open(path, 'w', encoding='utf-8').write(src)
print('OK')
PY
)

case "$MF_RESULT" in
    OK)
        mods "GmsCore: activity GmsCoreSettings -> enabled=false (mục trong Settings sẽ tự ẩn)"
        ;;
    *)
        # Không ẩn được mục thì vẫn giữ patch g(); chỉ cảnh báo.
        warn "GmsCore: không sửa được manifest ($MF_RESULT) - mục trong Settings vẫn hiện"
        ;;
esac

if ! $APKEDITOR b -f -i "$DEC" -o "$OUT/SecurityCenter.apk" > "$WORK_ROOT/build.log" 2>&1; then
    warn "GmsCore: build lại APK thất bại - bỏ qua. $(tail -n 3 "$WORK_ROOT/build.log" | tr '\n' ' ')"
    rm -rf "$WORK_ROOT"
    exit 0
fi

if [ ! -s "$OUT/SecurityCenter.apk" ]; then
    warn "GmsCore: APK build ra rỗng - bỏ qua"
    rm -rf "$WORK_ROOT"
    exit 0
fi

# Tuỳ chọn: kho Xiaomi cập nhật SecurityCenter sẽ đè patch. Nếu người dùng khai
# com.miui.securitycenter trong pin_app_versions thì nâng versionCode lên rất
# cao, kho thôi chào bản mới (cùng cơ chế với Apps_Replace).
PIN_PKGS=$(grep -m1 '^pin_app_versions=' "$WORK_DIR/config.env" 2>/dev/null | cut -d= -f2- | tr -d '"')
PIN_CODE=$(grep -m1 '^pin_app_versioncode=' "$WORK_DIR/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
[ -z "$PIN_CODE" ] && PIN_CODE=2000000000
case " $PIN_PKGS " in
    *" com.miui.securitycenter "*)
        BUMP="$WORK_DIR/bin/modfile/UpdateFile/Apps_Replace/bump_versioncode.py"
        if [ -f "$BUMP" ] && python3 "$BUMP" "$OUT/SecurityCenter.apk" "$PIN_CODE" >/dev/null 2>&1; then
            mods "GmsCore: versionCode -> $PIN_CODE ($(python3 "$BUMP" --show "$OUT/SecurityCenter.apk" 2>/dev/null)), kho sẽ không đè patch"
        else
            warn "GmsCore: bump versionCode thất bại - kho vẫn có thể đè patch"
        fi
        ;;
esac

# Xoá mã đã biên dịch sẵn của bản cũ, giữ lại sẽ chạy code cũ.
APPDIR=$(dirname "$APK")
rm -rf "$APPDIR/oat"
find "$APPDIR" -maxdepth 1 -type f \( -name "*.odex" -o -name "*.vdex" -o -name "*.art" \) -delete 2>/dev/null

if cp -f "$OUT/SecurityCenter.apk" "$APK"; then
    mods "GmsCore: xong - switch 'Dịch vụ cơ bản của Google' không tắt được, CH Play luôn hiện"
else
    warn "GmsCore: copy đè thất bại - APK gốc còn nguyên"
fi

rm -rf "$WORK_ROOT"
