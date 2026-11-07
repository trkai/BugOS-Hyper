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

# ---------------------------------------------------------------------------
# Kho ứng dụng Xiaomi - tuỳ chọn, bật bằng cờ keep_getapps trong config.env.
#
# APPLIST debloat cả cụm kho (MIUISuperMarket / MiuiSuperMarket / MIUIMiPicks /
# MIUISystemAppUpdater). Mất kho thì app hệ thống không có đường cập nhật nào,
# kể cả khi máy có mạng và đã đăng nhập - đây là lỗi cấu hình, không phải lỗi
# của Xiaomi.
#
# Cờ này chỉ LỌC BỎ tên khỏi danh sách vừa đọc, không sửa APPLIST.txt, nên danh
# sách gốc vẫn là thứ duy nhất quyết định debloat mặc định.
#
# Vì sao cài cập nhật vẫn được dù app trong /product bị mod/ký lại: services.jar
# đã patch matchSignaturesCompat -> 1 trong bước COREPATCH.
# ---------------------------------------------------------------------------
KEEP_GETAPPS=$(grep -m1 '^keep_getapps=' "$WORK_DIR/config.env" 2>/dev/null | cut -d= -f2 | tr -d '\r\n ')
keep_apps=()
keep_pkgs=()
if [ "$KEEP_GETAPPS" != "false" ]; then
    keep_apps=( MIUISuperMarket MiuiSuperMarket MIUIMiPicks MIUISystemAppUpdater )
    keep_pkgs=( com.xiaomi.market com.xiaomi.mipicks com.miui.systemAppUpdater )

    filtered_apps=()
    for a in "${debloat_apps[@]}"; do
        keep=false
        for k in "${keep_apps[@]}"; do
            [ "$a" = "$k" ] && keep=true
        done
        [ "$keep" = true ] && continue
        filtered_apps+=("$a")
    done

    filtered_pkgs=()
    for p in "${debloat_pkgs[@]}"; do
        keep=false
        for k in "${keep_pkgs[@]}"; do
            [ "$p" = "$k" ] && keep=true
        done
        [ "$keep" = true ] && continue
        filtered_pkgs+=("$p")
    done

    dropped=$(( ${#debloat_apps[@]} + ${#debloat_pkgs[@]} - ${#filtered_apps[@]} - ${#filtered_pkgs[@]} ))
    debloat_apps=("${filtered_apps[@]}")
    debloat_pkgs=("${filtered_pkgs[@]}")
    mods "Debloat: keep_getapps=true - giữ $dropped mục kho ứng dụng (GetApps / 应用商店)"
fi

# ---------------------------------------------------------------------------
# Nhóm tài khoản Mi - tuỳ chọn, bật bằng cờ remove_mi_account trong config.env.
#
# Bỏ ba package này thì ROM không còn đường đăng nhập Mi và không đăng ký máy
# với Find Device, nên máy không bị gắn tài khoản sau khi flash.
#
# KHÔNG gỡ được máy ĐÃ bị khoá: bản ghi khoá nằm ở server Xiaomi theo IMEI,
# không nằm trong file ROM. Cờ này chỉ có nghĩa với máy chưa gắn tài khoản.
#
# Hệ quả khi bật: mất Find Device (không khoá/xoá dữ liệu từ xa được), mất
# Mi Cloud backup và đồng bộ, mất mục tài khoản Mi trong Cài đặt.
#
# Thêm vào sau khi đọc APPLIST để danh sách gốc vẫn là thứ duy nhất quyết định
# debloat mặc định - cờ này chỉ chèn thêm, không sửa file.
# ---------------------------------------------------------------------------
REMOVE_MI_ACCOUNT=$(grep -m1 '^remove_mi_account=' "$WORK_DIR/config.env" 2>/dev/null | cut -d= -f2 | tr -d '\r\n ')
if [ "$REMOVE_MI_ACCOUNT" = "true" ]; then
    mi_account_pkgs=(
        com.xiaomi.account
        com.xiaomi.finddevice
        com.miui.cloudservice
    )
    debloat_pkgs+=("${mi_account_pkgs[@]}")
    mods "Debloat: remove_mi_account=true - bỏ ${#mi_account_pkgs[@]} package tài khoản Mi"
fi

# Kho China cần đăng nhập Mi mới tải/cập nhật được. remove_mi_account bỏ hẳn
# com.xiaomi.account nên hai cờ này đá nhau - cảnh báo để không mất thời gian
# flash rồi mới thấy kho trống.
if [ "$KEEP_GETAPPS" != "false" ] && [ "$REMOVE_MI_ACCOUNT" = "true" ]; then
    warn "Debloat: keep_getapps=true nhưng remove_mi_account=true - kho China cần đăng nhập Mi, app tài khoản đã bị bỏ -> không cập nhật được"
fi

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
#
# CHỈ xoá thư mục nằm ngay trong app/ priv-app/ data-app/ overlay/. Khớp glob
# trần "*$tên*" trên toàn bộ images thì tên ngắn ăn cả thư mục hệ thống: bản
# OS4.0.5.0 có entry "mab" và nó khớp "*mab*" -> d/bpf/d**mab**uf, build xoá
# luôn /system/system/etc/bpf/dmabuf. Cùng lý do, entry "Mi" sẽ khớp MiuiHome.
# pkg: vẫn là cách đúng; nhánh này chỉ còn để tương thích APPLIST cũ.
for debloat_app in "${debloat_apps[@]}"; do
    [ -z "$debloat_app" ] && continue
    all_app_dirs=$(
        find "$MAIN_FOLDER/system" "$MAIN_FOLDER/product" "$MAIN_FOLDER/mi_ext" \
             "$MAIN_FOLDER/system_ext" \
             -type d -name "*$debloat_app*" \
             \( -path '*/app/*' -o -path '*/priv-app/*' -o -path '*/data-app/*' -o -path '*/overlay/*' \) \
             2>/dev/null
    )

    while IFS= read -r app_dir; do
        [ -n "$app_dir" ] || continue
        [[ -d $app_dir ]] || continue
        # keep_getapps: nhánh này khớp glob nên entry ngắn ăn cả thư mục kho.
        # Ví dụ entry "Updater" (com.android.updater) khớp "*Updater*" ->
        # xoá luôn MIUISystemAppUpdater, tức bỏ đúng cái app cập nhật hệ thống.
        # Chặn theo tên thư mục ở đây, không chỉ lọc danh sách.
        app_name=$(basename "$app_dir")
        kept=false
        for k in "${keep_apps[@]}"; do
            [ "$app_name" = "$k" ] && kept=true
        done
        if [ "$kept" = true ]; then
            mods "Debloat: giữ $app_name (keep_getapps)"
            continue
        fi
        case "$(basename "$(dirname "$app_dir")")" in
            app|priv-app|data-app|overlay)
                info "Removing directory: $app_dir"
                rm -rf "$app_dir"
                ;;
            *)
                warn "Debloat: bỏ qua '$app_dir' - thư mục mẹ không phải app/priv-app/data-app/overlay"
                ;;
        esac
    done <<< "$all_app_dirs"
done

info "Debloat Done"

# Xác nhận kho ứng dụng còn thật sự trong images. Nếu base ROM không có sẵn
# GetApps thì cờ keep_getapps không tạo ra được gì - báo ngay trong log build
# thay vì để phát hiện sau khi flash.
if [ "$KEEP_GETAPPS" != "false" ]; then
    store_dir=$(find "$MAIN_FOLDER/system" "$MAIN_FOLDER/product" \
                     "$MAIN_FOLDER/system_ext" "$MAIN_FOLDER/mi_ext" \
                     -maxdepth 4 -type d \( -name MIUISuperMarket -o -name MiuiSuperMarket -o -name MIUIMiPicks \) \
                     2>/dev/null | head -n 1)
    if [ -n "$store_dir" ]; then
        mods "Debloat: kho ứng dụng còn trong ROM -> ${store_dir#$MAIN_FOLDER/}"
    else
        warn "Debloat: keep_getapps=true nhưng KHÔNG thấy app kho nào trong images - base ROM không kèm GetApps"
    fi
fi
