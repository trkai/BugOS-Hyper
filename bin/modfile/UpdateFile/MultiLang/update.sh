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
    # Cả OS3 và OS4 dùng CÙNG một họ overlay (ZK Multi, file BugOS.Multi.*).
    # OS4 có thư mục riêng để sau này chỉnh riêng nếu cần; hiện nội dung giống hệt
    # updatesource/ nên git chỉ lưu một bản (blob trùng nội dung).
    if [[ "$rom_os" == "OS4" ]] || [[ "$rom_os" =~ ^OS[4-9] ]]; then
        mods "OS4: overlay BugOS.Multi (thư mục updatesource_os4)"
        cp -rf "$work_dir/bin/modfile/UpdateFile/MultiLang/updatesource_os4/"* "$MAIN_FOLDER/product/overlay/"
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

            # Nhớ giá trị build.region TRƯỚC khi sửa. Base XPKCNXM không khai báo
            # prop này trong system/build.prop, nên "giữ nguyên" có thể = không có
            # prop nào cả -> IS_INTERNATIONAL_BUILD phụ thuộc giá trị mặc định của
            # framework, không xác định. Ghi rõ "cn" thì mới chắc.
            keep_region_val=""
            if [ "$KEEP_BUILD_REGION" = "true" ]; then
                keep_region_val=$(grep -m1 '^ro\.miui\.build\.region=' "$prop" 2>/dev/null | cut -d= -f2 | tr -d '\r\n ')
            fi

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

            # ROM China: nếu gốc không có build.region thì ghi thẳng "cn" thay vì
            # bỏ trống. Bỏ trống là để framework tự quyết - và đó chính là chỗ
            # tính năng chỉ-có-trên-China (vd hiệu ứng xếp chồng trong Gần đây)
            # có thể bị ẩn.
            if [ "$KEEP_BUILD_REGION" = "true" ] && [ -z "$keep_region_val" ]; then
                echo "ro.miui.build.region=cn" >> "$prop"
            fi
        fi
    done

    # Tổng kết: in ra đúng những prop quyết định "đây là bản China hay quốc tế",
    # để không phải flash rồi mới biết.
    region_summary() {
        local f="$MAIN_FOLDER/system/system/build.prop"
        [ -f "$f" ] || return 0
        local br rg cv
        br=$(grep -m1 '^ro\.miui\.build\.region=' "$f" | cut -d= -f2 | tr -d '\r\n ')
        rg=$(grep -m1 '^ro\.miui\.region=' "$f" | cut -d= -f2 | tr -d '\r\n ')
        cv=$(grep -m1 '^ro\.miui\.cust_variant=' "$f" | cut -d= -f2 | tr -d '\r\n ')
        mods "Region: build.region=${br:-(không có)} | region=${rg:-(không có)} | cust_variant=${cv:-(không có)}"

        # Nếu product/etc/build.prop cũng khai báo build.region mà khác giá trị,
        # prop nạp trước (system) thắng - nói rõ để không phải đoán khi debug.
        local p2="$MAIN_FOLDER/product/etc/build.prop" br2
        if [ -f "$p2" ]; then
            br2=$(grep -m1 '^ro\.miui\.build\.region=' "$p2" | cut -d= -f2 | tr -d '\r\n ')
            if [ -n "$br2" ] && [ -n "$br" ] && [ "$br2" != "$br" ]; then
                # Đồng bộ luôn, đừng để 2 file nói 2 kiểu: system nạp trước nên nó
                # thắng, nhưng người đọc log sau này sẽ tưởng prop kia có tác dụng.
                sed -i "s|^ro\.miui\.build\.region=.*|ro.miui.build.region=$br|" "$p2"
                warn "Region: product/etc/build.prop có build.region=$br2 -> đã đồng bộ thành $br"
            fi
        fi
        if [ "$br" = "global" ]; then
            mods "Region: build.region=global -> IS_INTERNATIONAL_BUILD=true, tính năng China sẽ bị ẩn"
        else
            mods "Region: build.region=${br:-cn} -> IS_INTERNATIONAL_BUILD=false (giữ tính năng China)"
        fi
    }
    region_summary

    mods "Done!"
fi
