work_dir=${work_dir:-$(pwd)}
MAIN_FOLDER="$work_dir/build/baserom/images"
source $work_dir/functions.sh
deviceTYPE=$(cat $work_dir/bin/ddevice/device_type.txt 2>/dev/null)
rom_os=$(cat $work_dir/bin/ddevice/rom_os.txt 2>/dev/null | tr -d '\r\n ')

# ---------------------------------------------------------------------------
# ro.miui.build.region quyết định Build.IS_INTERNATIONAL_BUILD.
# Đặt "global" trên một ROM China làm hệ thống coi đây là bản quốc tế, và các
# tính năng CHỈ có trên bản China sẽ bị ẩn - ví dụ "hiệu ứng xếp chồng" trong
# Cài đặt > Màn hình chính > Sắp xếp các mục trong Gần đây (HyperOS 3 ra mắt
# tính năng này ở China trước).
# => mặc định KHÔNG ghi đè build.region nữa; đặt keep_build_region=false trong
#    config.env để quay lại hành vi cũ.
# ---------------------------------------------------------------------------
KEEP_BUILD_REGION=$(grep -m1 '^keep_build_region=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d '\r\n ')
[ -z "$KEEP_BUILD_REGION" ] && KEEP_BUILD_REGION=true

if [[ $deviceTYPE == "China" ]]; then
    mods "Adding MultiLanguage / Vietnamese To ROM..."
    if [ "$KEEP_BUILD_REGION" = "true" ]; then
        mods "Giữ nguyên ro.miui.build.region của ROM (không ép global)"
    fi

    mkdir -p $MAIN_FOLDER/product/overlay/

    # 1. Chọn gói Overlay tương thích theo phiên bản HyperOS
    # Bộ overlay dùng cho OS4+.
    #   zk   (mặc định) = bộ ZK Multi, cũng là bộ OS3 đang chạy tốt
    #   tory           = bộ Tory (updatesource_os4), bản cũ
    #
    # Lý do đổi mặc định sang zk: bộ Tory làm Setup Wizard crash trên OS4
    # (MissingFormatArgumentException '%2$s' trong
    #  interconnection_service_summary_china - chuỗi dịch có 2 placeholder
    #  nhưng code chỉ truyền 1). Bộ ZK dùng đúng 1 placeholder nên không crash.
    # Người dùng cũng xác nhận: chuyển Setup sang tiếng Anh thì vào được.
    MULTILANG_OS4_SET=$(grep -m1 '^multilang_os4_set=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d '\r\n ')
    [ -z "$MULTILANG_OS4_SET" ] && MULTILANG_OS4_SET=zk

    if [[ "$rom_os" == "OS4" ]] || [[ "$rom_os" =~ ^OS[4-9] ]]; then
        ML_DIR="$work_dir/bin/modfile/UpdateFile/MultiLang"
        case "$MULTILANG_OS4_SET" in
            zk)
                mods "OS4: bộ overlay ZK Multi (giống OS3)"
                cp -rf "$ML_DIR/updatesource/"* "$MAIN_FOLDER/product/overlay/"
                ;;
            tory)
                mods "OS4: bộ overlay Tory"
                cp -rf "$ML_DIR/updatesource_os4/"* "$MAIN_FOLDER/product/overlay/"
                ;;
            *)
                # best (mặc định): Tory phủ 58 package, ZK phủ 62, nhưng chỉ trùng 38.
                # Lấy Tory làm nền (mới hơn, nhiều chuỗi hơn: Settings 15.390 vs 12.683)
                # rồi thêm 24 package mà chỉ ZK có -> tổng 82 package có tiếng Việt.
                mods "OS4: ghép Tory + phần độc quyền của ZK (82 package)"
                cp -rf "$ML_DIR/updatesource_os4/"* "$MAIN_FOLDER/product/overlay/"
                added=0
                while IFS= read -r ov; do
                    [ -n "$ov" ] || continue
                    if [ -f "$ML_DIR/updatesource/$ov" ]; then
                        cp -f "$ML_DIR/updatesource/$ov" "$MAIN_FOLDER/product/overlay/"
                        added=$((added + 1))
                    else
                        warn "OS4 best: thiếu $ov trong updatesource/"
                    fi
                done < "$ML_DIR/extra_zk_overlays.txt"
                mods "OS4 best: thêm $added overlay ZK (tổng $((added + 58)) package)"
                ;;
        esac
    else
        mods "Applying HyperOS/MIUI MultiLanguage Overlays (ZK Multi)..."
        cp -rf $work_dir/bin/modfile/UpdateFile/MultiLang/updatesource/* $MAIN_FOLDER/product/overlay/
    fi

    # 2. Thiết lập cấu hình vùng Việt Nam (cust.prop) cho First-Boot OOBE
    if [ -d "$MAIN_FOLDER/system_ext" ] && [ -f "$work_dir/bin/modfile/UpdateFile/MultiLang/cust.prop" ]; then
        mkdir -p "$MAIN_FOLDER/system_ext/cust/vn"
        cp -rf "$work_dir/bin/modfile/UpdateFile/MultiLang/cust.prop" "$MAIN_FOLDER/system_ext/cust/vn/cust.prop"
        mods "Configured system_ext/cust/vn/cust.prop"
    fi

    # 3. Xóa cấu hình ngôn ngữ China và kích hoạt Tiếng Việt mặc định trong build.prop
    mods "Configuring default locale for Vietnamese..."
    for prop in "$MAIN_FOLDER/system/system/build.prop" "$MAIN_FOLDER/product/etc/build.prop"; do
        if [ -f "$prop" ]; then
            # Dọn sạch các biến ngôn ngữ/khu vực cũ tránh xung đột
            sed_args=(
                -e '/^ro\.product\.locale=/d'
                -e '/^persist\.sys\.locale=/d'
                -e '/^ro\.product\.locale\.language=/d'
                -e '/^ro\.product\.locale\.region=/d'
                -e '/^persist\.sys\.timezone=/d'
                -e '/^ro\.miui\.region=/d'
                -e '/^ro\.miui\.cust_variant=/d'
                -e '/^ro\.vendor\.audio\.spk\.clean=/d'
                -e '/^persist\.sys\.zk\.multi=/d'
            )
            [ "$KEEP_BUILD_REGION" = "true" ] || sed_args+=(-e '/^ro\.miui\.build\.region=/d')
            sed -i "${sed_args[@]}" "$prop"

            # Đảm bảo file kết thúc bằng xuống dòng trước khi thêm
            [ -n "$(tail -c1 "$prop")" ] && echo "" >> "$prop"

            # Ghi đè cấu hình Tiếng Việt (vi-VN)
            {
                echo "ro.product.locale=vi-VN"
                echo "persist.sys.locale=vi-VN"
                echo "ro.product.locale.language=vi"
                echo "ro.product.locale.region=VN"
                echo "persist.sys.timezone=Asia/Ho_Chi_Minh"
                echo "ro.miui.region=VN"
                [ "$KEEP_BUILD_REGION" = "true" ] || echo "ro.miui.build.region=global"
                echo "ro.miui.cust_variant=vn"
                echo "ro.vendor.audio.spk.clean=true"
                echo "persist.sys.zk.multi=1"
            } >> "$prop"
        fi
    done

    mods "Done!"
fi
