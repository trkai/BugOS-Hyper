#!/bin/bash
# ---------------------------------------------------------------------------
# Build BugOSToolbox.apk - chạy trên máy có Android SDK (không cần Gradle).
#
# CI KHÔNG chạy script này: workflow đã xoá /usr/local/lib/android để lấy chỗ,
# nên APK được build sẵn ở máy dev rồi commit vào repo. patch.sh chỉ copy nó
# vào /product/priv-app.
#
# Cần: build-tools (aapt2, d8, zipalign, apksigner) + platforms/android-37.
#   ANDROID_SDK_ROOT  mặc định ~/AppData/Local/Android/Sdk (Windows Git Bash)
#   BUILD_TOOLS       mặc định 36.0.0
#   JAVA_HOME         bắt buộc nếu java không có trong PATH
# ---------------------------------------------------------------------------
set -e

HERE="$(cd "$(dirname "$0")" && pwd)"
SDK="${ANDROID_SDK_ROOT:-$HOME/AppData/Local/Android/Sdk}"
BT="$SDK/build-tools/${BUILD_TOOLS:-36.0.0}"
PLATFORM="$SDK/platforms/android-37.0/android.jar"
OUT_APK="$HERE/BugOSToolbox.apk"
KEYSTORE="$HERE/bugos-toolbox.keystore"
KS_PASS="bugos-toolbox"
KS_ALIAS="bugos"

if [ -n "$JAVA_HOME" ] && [ -d "$JAVA_HOME/bin" ]; then
    PATH="$JAVA_HOME/bin:$PATH"
fi
# aapt2/d8/... trên Windows có đuôi .exe và .bat
exe() {
    for c in "$1" "$1.exe" "$1.bat"; do
        [ -f "$c" ] && { echo "$c"; return; }
    done
    echo "$1"
}

for tool in aapt2 d8 zipalign apksigner; do
    found=0
    for c in "$BT/$tool" "$BT/$tool.exe" "$BT/$tool.bat"; do
        [ -f "$c" ] && found=1
    done
    [ "$found" -eq 1 ] || { echo "Thiếu: $BT/$tool"; exit 1; }
done
[ -f "$PLATFORM" ] || { echo "Thiếu: $PLATFORM"; exit 1; }
command -v java >/dev/null || { echo "Không thấy java - đặt JAVA_HOME"; exit 1; }

AAPT2=$(exe "$BT/aapt2")
ZIPALIGN=$(exe "$BT/zipalign")
APKSIGNER=$(exe "$BT/apksigner")
D8=$(exe "$BT/d8")

WORK="$HERE/.build"
rm -rf "$WORK"
mkdir -p "$WORK/compiled" "$WORK/classes" "$WORK/dex"

echo "== aapt2 compile =="
"$AAPT2" compile --dir "$HERE/res" -o "$WORK/compiled/res.zip"

echo "== aapt2 link =="
"$AAPT2" link \
    -o "$WORK/base.apk" \
    -I "$PLATFORM" \
    --manifest "$HERE/AndroidManifest.xml" \
    --min-sdk-version 34 \
    --target-sdk-version 37 \
    "$WORK/compiled/res.zip"

echo "== javac =="
# cd vào src rồi dùng đường dẫn TƯƠNG ĐỐI: đường dẫn tuyệt đối của repo có dấu
# cách ("New folder") làm javac tách sai tham số.
#
# Không dùng -bootclasspath: javac 21 từ chối nó khi -target > 8. Chỉ cần
# -classpath android.jar là đủ; java.* lấy từ JDK, android.* từ android.jar.
( cd "$HERE/src" && javac -source 17 -target 17 -encoding UTF-8 -nowarn \
    -classpath "$PLATFORM" -d "$WORK/classes" $(find . -name '*.java') )

echo "== d8 =="
( cd "$WORK/classes" && "$D8" --lib "$PLATFORM" --min-api 34 \
    --output "$WORK/dex" $(find . -name '*.class') )

echo "== đóng gói classes.dex =="
python - "$WORK/base.apk" "$WORK/dex/classes.dex" "$WORK/unsigned.apk" <<'PY'
import sys, zipfile, shutil
src, dex, dst = sys.argv[1], sys.argv[2], sys.argv[3]
shutil.copyfile(src, dst)
with zipfile.ZipFile(dst, 'a', zipfile.ZIP_DEFLATED) as z:
    z.write(dex, 'classes.dex')
print("   thêm classes.dex:", __import__('os').path.getsize(dex), "byte")
PY

echo "== zipalign =="
"$ZIPALIGN" -f 4 "$WORK/unsigned.apk" "$WORK/aligned.apk"

echo "== ký =="
if [ ! -f "$KEYSTORE" ]; then
    echo "   tạo keystore mới: $KEYSTORE"
    keytool -genkeypair -keystore "$KEYSTORE" -alias "$KS_ALIAS" \
        -keyalg RSA -keysize 2048 -validity 10000 \
        -storepass "$KS_PASS" -keypass "$KS_PASS" \
        -dname "CN=BugOS Toolbox, O=BugOS, C=VN" >/dev/null 2>&1
fi
"$APKSIGNER" sign --ks "$KEYSTORE" --ks-key-alias "$KS_ALIAS" \
    --ks-pass "pass:$KS_PASS" --key-pass "pass:$KS_PASS" \
    --out "$OUT_APK" "$WORK/aligned.apk"

"$APKSIGNER" verify "$OUT_APK" >/dev/null && echo "   chữ ký OK"
rm -rf "$WORK"
echo "== xong: $OUT_APK ($(stat -c%s "$OUT_APK") byte) =="
