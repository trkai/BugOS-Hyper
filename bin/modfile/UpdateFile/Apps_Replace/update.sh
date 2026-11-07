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

# App đã thay thì không cho kho cập nhật đè (xem khối bump bên dưới).
# pin_app_versions trong config.env: danh sách package, cách nhau bởi dấu cách.
PIN_PKGS=$(grep -m1 '^pin_app_versions=' "$WORK_DIR/config.env" 2>/dev/null | cut -d= -f2- | tr -d '"')
[ -z "$PIN_PKGS" ] && PIN_PKGS="com.miui.gallery com.miui.weather2"
PIN_CODE=$(grep -m1 '^pin_app_versioncode=' "$WORK_DIR/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
[ -z "$PIN_CODE" ] && PIN_CODE=2000000000

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

    # APK nguồn phải thật sự khai đúng package (tránh đặt sai tên file)
    src_pkg=$(python3 "$FINDER" x --pkg-of "$apk" 2>/dev/null)
    if [ "$src_pkg" != "$pkg" ]; then
        warn "Apps_Replace: $pkg - APK nguồn khai package '$src_pkg' - bỏ qua"
        continue
    fi

    dest=$(python3 "$FINDER" "$MAIN_FOLDER" "$pkg" 2>/dev/null)
    if [ -z "$dest" ]; then
        warn "Apps_Replace: KHÔNG thấy package '$pkg' trong images - bỏ qua"
        continue
    fi

    appdir=$(dirname "$dest")
    base=$(basename "$dest")

    # Chốt lần 2: APK đích phải khai đúng package này. Nếu không thì bỏ, vì thay
    # nhầm sẽ phá app khác (đã từng xảy ra với MIUICloudService / CarWith).
    dest_pkg=$(python3 "$FINDER" x --pkg-of "$dest" 2>/dev/null)
    if [ "$dest_pkg" != "$pkg" ]; then
        warn "Apps_Replace: ${dest#$MAIN_FOLDER/} khai package '$dest_pkg' != '$pkg' - bỏ qua"
        continue
    fi
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

        # Giữ app đã thay khỏi bị kho ghi đè. Kho so versionCode máy với bản nó
        # phục vụ; nâng versionCode lên rất cao thì kho không còn chào bản mới,
        # và nếu bị ép cài thì đó là downgrade nên PackageManager tự chặn.
        #
        # Cần vì bản CN của 2 app này KHÔNG chọn được tiếng Việt: resources có
        # values-vi thật, nhưng khi system locale là vi/vi-VN app lại hiện tiếng
        # Ả Rập (đo trên máy 07/11). Bản global trong apks/ thì hiện đúng.
        pinned=false
        for pk in $PIN_PKGS; do
            [ "$pkg" = "$pk" ] && pinned=true
        done
        if [ "$pinned" = true ]; then
            if python3 "$SRC_DIR/bump_versioncode.py" "$appdir/$base" "$PIN_CODE" >/dev/null 2>&1; then
                got=$(python3 "$SRC_DIR/bump_versioncode.py" --show "$appdir/$base" 2>/dev/null)
                case "$got" in
                    *"=$PIN_CODE"*)
                        mods "Apps_Replace: $pkg -> versionCode $PIN_CODE, kho sẽ không chào cập nhật"
                        ;;
                    *)
                        warn "Apps_Replace: $pkg - bump versionCode không đọc lại được ($got)"
                        ;;
                esac
            else
                warn "Apps_Replace: $pkg - bump versionCode thất bại, kho vẫn có thể ghi đè"
            fi
        fi
    else
        warn "Apps_Replace: $pkg - copy thất bại"
    fi
done

mods "Apps_Replace: done"
