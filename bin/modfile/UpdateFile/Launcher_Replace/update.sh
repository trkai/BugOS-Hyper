work_dir=$(pwd)
source "$work_dir/functions.sh"

# ---------------------------------------------------------------------------
# Thay launcher hệ thống (com.miui.home) bằng bản mod.
#
# Nguồn: HyperOS_LauncherV7.5F của @kashis_cringey_stuffs (Magisk module).
# Trong module gốc có 2 APK:
#   files/MiuiHome.apk       com.miui.home    -> dùng
#   files/ext/XiaomiEUExt.apk eu.xiaomi.ext   -> KHÔNG dùng
# Kiểm tra 3 dex của MiuiHome: không có tham chiếu nào tới eu.xiaomi.ext
# (chuỗi "eu.xiaomi" duy nhất là "sdkconfig.eu.xiaomi.com" - endpoint analytics).
# Nên ext không phải phụ thuộc, không cài thêm.
#
# Áp cho cả OS3 (Android 16) và OS4 (Android 17): APK là minSdk 34 / targetSdk 35
# nên chạy được trên cả hai. Không gate theo rom_os.
# ---------------------------------------------------------------------------

MAIN_FOLDER="$work_dir/build/baserom/images"
FINDER="$work_dir/bin/modfile/UpdateFile/Apps_Replace/find_apk_by_package.py"
SRC="$work_dir/bin/modfile/UpdateFile/Launcher_Replace/apks/com.miui.home.apk"
PKG="com.miui.home"

if [ ! -f "$SRC" ]; then
    warn "Launcher_Replace: thiếu $SRC - bỏ qua"
    exit 0
fi

if ! unzip -t "$SRC" >/dev/null 2>&1; then
    warn "Launcher_Replace: APK nguồn hỏng (zip không hợp lệ) - bỏ qua"
    exit 0
fi

if [ ! -f "$FINDER" ]; then
    warn "Launcher_Replace: thiếu find_apk_by_package.py - bỏ qua"
    exit 0
fi

# APK nguồn phải thật sự khai đúng package
src_pkg=$(python3 "$FINDER" x --pkg-of "$SRC" 2>/dev/null)
if [ "$src_pkg" != "$PKG" ]; then
    warn "Launcher_Replace: APK nguồn khai package '$src_pkg' != '$PKG' - bỏ qua"
    exit 0
fi

# Tìm launcher đang có trong images (app/priv-app/data-app, mọi partition)
dest=$(python3 "$FINDER" "$MAIN_FOLDER" "$PKG" 2>/dev/null)
if [ -z "$dest" ]; then
    warn "Launcher_Replace: KHÔNG thấy $PKG trong images - bỏ qua"
    exit 0
fi

dest_pkg=$(python3 "$FINDER" x --pkg-of "$dest" 2>/dev/null)
if [ "$dest_pkg" != "$PKG" ]; then
    warn "Launcher_Replace: ${dest#$MAIN_FOLDER/} khai package '$dest_pkg' != '$PKG' - bỏ qua"
    exit 0
fi

appdir=$(dirname "$dest")
rel="${dest#$MAIN_FOLDER/}"
rel="${rel#$MAIN_FOLDER}"
[ "$rel" = "$dest" ] && rel=$(printf '%s' "$dest" | awk -F/ '{print $(NF-2)"/"$(NF-1)"/"$NF}')

rom_os=$(cat "$work_dir/bin/ddevice/rom_os.txt" 2>/dev/null | tr -d '\r\n ')
androidver=$(cat "$work_dir/bin/ddevice/androidver.txt" 2>/dev/null | tr -d '\r\n ')
mods "Launcher_Replace: thay launcher ($rom_os / Android $androidver)"

size_old=$(wc -c < "$dest" 2>/dev/null || echo 0)

# Mã biên dịch cũ phải bỏ, nếu không hệ thống chạy lại code cũ hoặc lỗi verify
rm -rf "$appdir/oat"
rm -f "$appdir"/*.odex "$appdir"/*.vdex "$appdir"/*.art 2>/dev/null

cp -f "$SRC" "$dest" || {
    warn "Launcher_Replace: copy thất bại - launcher giữ nguyên bản gốc"
    exit 0
}

# Kiểm tra lại sau khi copy: file phải còn hợp lệ và đúng package
if ! unzip -t "$dest" >/dev/null 2>&1; then
    warn "Launcher_Replace: file sau khi copy hỏng - kiểm tra lại dung lượng đĩa"
    exit 0
fi
new_pkg=$(python3 "$FINDER" x --pkg-of "$dest" 2>/dev/null)
if [ "$new_pkg" != "$PKG" ]; then
    warn "Launcher_Replace: file sau khi copy khai '$new_pkg' - không như mong đợi"
    exit 0
fi

size_new=$(wc -c < "$dest" 2>/dev/null || echo 0)
mods "Launcher_Replace: $rel ($((size_old / 1024))KB -> $((size_new / 1024))KB)"

# Đảm bảo hệ thống chọn đúng launcher này (ROM POCO/Global trỏ sang package khác).
# Chỉ sửa dòng đã tồn tại, không thêm mới: mặc định của MIUI vốn là com.miui.home.
for p in \
    "$MAIN_FOLDER/system/system/build.prop" \
    "$MAIN_FOLDER/product/etc/build.prop" \
    "$MAIN_FOLDER/system_ext/etc/build.prop" \
    "$MAIN_FOLDER/vendor/build.prop"; do
    [ -f "$p" ] || continue
    if grep -q '^ro\.miui\.product\.home=' "$p"; then
        sed -i "s|^ro\\.miui\\.product\\.home=.*|ro.miui.product.home=$PKG|" "$p"
    fi
done

mods "Launcher_Replace: done"
