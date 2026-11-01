WORK_DIR=$(pwd)
source $WORK_DIR/functions.sh

MAIN_FOLDER="$WORK_DIR/build/baserom/images"
FINDER="$WORK_DIR/bin/modfile/UpdateFile/Apps_Replace/find_apk_by_package.py"
APPLIST="$WORK_DIR/bin/ddevice/DEBLOAT/APPLIST.txt"

# ---------------------------------------------------------------------------
# APPLIST.txt có hai loại dòng:
#   - tên thư mục (cách cũ):  MIUIVideo   -> xoá mọi thư mục khớp *MIUIVideo*
#   - "pkg:<package>"        -> tra APK theo thuộc tính package trong manifest
#
# Loại thứ hai mới là cách đúng: tên thư mục khác nhau giữa các ROM, và khớp
# glob theo tên ngắn (ví dụ "ab") rất dễ xoá nhầm. pkg: khớp theo AXML nên
# không phụ thuộc tên thư mục.
# ---------------------------------------------------------------------------
debloat_apps=()
debloat_pkgs=()
while IFS= read -r line || [[ -n "$line" ]]; do
    line="${line%$'\r'}"
    [ -z "$line" ] && continue
    case "$line" in \#*) continue ;; esac
    case "$line" in
        pkg:*) debloat_pkgs+=("${line#pkg:}") ;;
        *)     debloat_apps+=("$line") ;;
    esac
done < "$APPLIST"

rm -rf "$MAIN_FOLDER/product/etc/auto-install"*
rm -rf "$MAIN_FOLDER/product/app/Updater"
rm -rf "$MAIN_FOLDER/product/etc/permissions/cn.google.services.xml"

# --- 1. Debloat theo package (chính xác) -----------------------------------
if [ "${#debloat_pkgs[@]}" -gt 0 ]; then
    if [ -f "$FINDER" ] && [ -d "$MAIN_FOLDER" ]; then
        pkg_csv=$(IFS=,; echo "${debloat_pkgs[*]}")
        mods "Debloat: tra ${#debloat_pkgs[@]} package theo manifest..."
        while IFS=$'\t' read -r pkg apk; do
            # finder in ra "pkg\t<path>" và trên Windows kết thúc bằng \r.
            # Không cắt \r thì apk="\r" (không rỗng), dirname "\r" = "." và
            # rm -rf "." sẽ xoá sạch thư mục làm việc. Đã bắt được lỗi này
            # bằng dry-run nên chặn ở đây, kèm kiểm tra đường dẫn.
            pkg="${pkg%$'\r'}"
            apk="${apk%$'\r'}"
            [ -n "$pkg" ] || continue
            if [ -z "$apk" ] || [ ! -f "$apk" ]; then
                warn "Debloat: không thấy $pkg trong images"
                continue
            fi
            dir=$(dirname "$apk")
            case "$dir" in
                ""|.|/|"$MAIN_FOLDER")
                    warn "Debloat: đường dẫn bất thường cho $pkg ('$apk') - bỏ qua"
                    continue
                    ;;
            esac
            case "$(basename "$dir")" in
                # APK nằm trực tiếp trong thư mục chứa app -> chỉ xoá APK,
                # KHÔNG xoá thư mục mẹ (sẽ xoá cả app/ hay priv-app/).
                app|priv-app|data-app|overlay|framework)
                    info "Debloat: xoá APK $pkg -> $apk"
                    rm -f "$apk"
                    rm -rf "$dir/oat"
                    ;;
                *)
                    info "Debloat: xoá thư mục $pkg -> $dir"
                    rm -rf "$dir"
                    ;;
            esac
        done < <(python3 "$FINDER" "$MAIN_FOLDER" --list "$pkg_csv" 2>/dev/null)
    else
        warn "Debloat: thiếu finder hoặc images - bỏ qua phần pkg:"
    fi
fi

# --- 2. Debloat theo tên thư mục (cách cũ, giữ để tương thích) -------------
for debloat_app in "${debloat_apps[@]}"; do
    [ -z "$debloat_app" ] && continue
    all_app_dirs=$(
        find "$MAIN_FOLDER/system" -type d -name "*$debloat_app*" 2>/dev/null
        find "$MAIN_FOLDER/product" -type d -name "*$debloat_app*" 2>/dev/null
        find "$MAIN_FOLDER/mi_ext" -type d -name "*$debloat_app*" 2>/dev/null
        find "$MAIN_FOLDER/system_ext" -type d -name "*$debloat_app*" 2>/dev/null
    )

    while IFS= read -r app_dir; do
        [ -n "$app_dir" ] || continue
        if [[ -d "$app_dir" ]]; then
            info "Removing directory: $app_dir"
            rm -rf "$app_dir"
        fi
    done <<< "$all_app_dirs"
done

info "Debloat Done"
