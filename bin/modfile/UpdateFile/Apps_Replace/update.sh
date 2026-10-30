#!/bin/bash
# ---------------------------------------------------------------------------
# Thay app hệ thống bằng bản APK có sẵn trong apks/
#
# Áp cho mọi phiên bản HyperOS (OS3 / OS4 ...), vì chỉ thay file APK.
#
# Cách tìm app đích: đọc AndroidManifest.xml của từng APK trong images và so
# khớp TÊN PACKAGE, không dựa vào tên thư mục (MIUIGallery / Weather / ... đổi
# theo từng bản ROM).
#
# Lưu ý về package:
#   - Thư viện ảnh : com.miui.gallery
#   - Thời tiết    : com.miui.weather2   (KHÔNG phải com.miui.weather)
# File trong apks/ phải đặt tên đúng bằng package name.
# ---------------------------------------------------------------------------
WORK_DIR=$(pwd)
source "$WORK_DIR/functions.sh"
MAIN_FOLDER="$WORK_DIR/build/baserom/images"
SRC_DIR="$WORK_DIR/bin/modfile/UpdateFile/Apps_Replace"
FINDER="$SRC_DIR/find_apk_by_package.py"

if [ ! -d "$MAIN_FOLDER" ]; then
    warn "Apps_Replace: không thấy images - bỏ qua"
    exit 0
fi

shopt -s nullglob
apks=("$SRC_DIR"/apks/*.apk)
shopt -u nullglob

if [ ${#apks[@]} -eq 0 ]; then
    warn "Apps_Replace: apks/ rỗng - bỏ qua"
    exit 0
fi

mods "Apps_Replace: thay ${#apks[@]} app (OS $(cat "$WORK_DIR/bin/ddevice/rom_os.txt" 2>/dev/null | tr -d '\r\n'))"

for apk in "${apks[@]}"; do
    pkg=$(basename "$apk" .apk)

    dest=$(python3 "$FINDER" "$MAIN_FOLDER" "$pkg" 2>/dev/null)
    if [ -z "$dest" ]; then
        warn "Apps_Replace: KHÔNG thấy package '$pkg' trong images - bỏ qua"
        continue
    fi

    appdir=$(dirname "$dest")
    base=$(basename "$dest")
    rel="${dest#$MAIN_FOLDER/}"
    rel="${rel#$MAIN_FOLDER}"
    # nếu đường dẫn không khớp tiền tố (khác kiểu path giữa các HĐH) thì rút gọn
    [ "$rel" = "$dest" ] && rel=$(printf '%s' "$dest" | awk -F/ '{print $(NF-2)"/"$(NF-1)"/"$NF}')
    old_size=$(wc -c < "$dest" 2>/dev/null || echo 0)
    new_size=$(wc -c < "$apk" 2>/dev/null || echo 0)

    # APK mới phải là zip hợp lệ, tránh copy file hỏng vào ROM
    if ! unzip -t "$apk" >/dev/null 2>&1; then
        warn "Apps_Replace: $pkg - APK nguồn hỏng, bỏ qua"
        continue
    fi

    # Xoá mã đã biên dịch sẵn của bản cũ. Giữ lại sẽ chạy code cũ hoặc lỗi
    # verify vì odex không khớp APK mới.
    rm -rf "$appdir/oat"
    find "$appdir" -maxdepth 1 -type f \( -name "*.odex" -o -name "*.vdex" -o -name "*.art" \) -delete 2>/dev/null

    if cp -f "$apk" "$appdir/$base"; then
        mods "Apps_Replace: $rel  ($((old_size/1024))KB -> $((new_size/1024))KB)"
    else
        warn "Apps_Replace: $pkg - copy thất bại"
    fi
done

mods "Apps_Replace: done"
