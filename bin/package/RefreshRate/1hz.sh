#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# RefreshRate/1hz.sh - thêm 120Hz / 90Hz / 1Hz và SmartFPS vào device_features.
#
# VÌ SAO PHẢI LẶP TỪNG FILE (bản cũ có bug thật):
#   gfFile="$.../device_features/*.xml"     <- giữ nguyên chuỗi glob trong biến
#   sed '...' $gfFile > ${gfFile}.new       <- KHÔNG quote, KHÔNG lặp
#   mv ${gfFile}.new $gfFile
#
#   Khi ROM có nhiều hơn một file .xml:
#     - sed nhận nhiều file, đọc hết rồi ghi GỘP vào một .new
#     - mv ghi đè file đầu tiên, các file còn lại KHÔNG được sửa
#   => device_features bị trộn nội dung của nhiều thiết bị vào một file.
#
#   Ngoài ra log cũ in ra nguyên chuỗi "*.xml" nên không biết đã sửa file nào.
#
# Bản này: nullglob + lặp từng file thật, sửa tại chỗ bằng sed -i, log đúng tên.
# ---------------------------------------------------------------------------
work_dir=$(pwd)
source "$work_dir/functions.sh"

FEATURE_DIR="$work_dir/build/baserom/images/product/etc/device_features"

if [ ! -d "$FEATURE_DIR" ]; then
    debug "RefreshRate: không có thư mục device_features - bỏ qua"
    exit 0
fi

# nullglob: nếu không khớp file nào thì mảng rỗng, thay vì giữ nguyên chuỗi "*.xml"
# (giữ nguyên thì sed sẽ báo "can't read *.xml" và mảng có 1 phần tử rác).
shopt -s nullglob
files=("$FEATURE_DIR"/*.xml)
shopt -u nullglob

if [ ${#files[@]} -eq 0 ]; then
    debug "RefreshRate: không có .xml nào trong device_features - bỏ qua"
    exit 0
fi

for f in "${files[@]}"; do
    name=$(basename "$f")
    added=""

    # Thứ tự có phụ thuộc: 120 chèn sau 144, rồi 90 chèn sau 120, 1 chèn sau 60.
    # Phải giữ đúng thứ tự này, nếu không 90 sẽ không có mốc 120 để bám vào.
    if ! grep -qF '<item>120</item>' "$f"; then
        sed -i '/<item>144<\/item>/a\        <item>120<\/item>' "$f"
        added="$added 120Hz"
    fi

    if ! grep -qF '<item>90</item>' "$f"; then
        sed -i '/<item>120<\/item>/a\        <item>90<\/item>' "$f"
        added="$added 90Hz"
    fi

    if ! grep -qF '<item>1</item>' "$f"; then
        sed -i '/<item>60<\/item>/a\        <item>1<\/item>' "$f"
        added="$added 1Hz"
    fi

    if ! grep -qF '<bool name="support_smart_fps">true</bool>' "$f"; then
        # Hai thẻ trên hai dòng riêng (bản cũ nhét chung một dòng bằng \< - vẫn
        # hợp lệ XML nhưng khó đọc khi so sánh diff).
        sed -i '/<integer name="defaultFps">60<\/integer>/a\    <bool name="support_smart_fps">true</bool>\n    <integer name="smart_fps_value">120</integer>' "$f"
        added="$added SmartFPS"
    fi

    if [ -n "$added" ]; then
        mods "RefreshRate: $name +$added"
    else
        debug "RefreshRate: $name đã đủ - không sửa"
    fi
done
