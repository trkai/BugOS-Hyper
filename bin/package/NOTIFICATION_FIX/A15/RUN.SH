#!/bin/bash
# BugOS - NOTIFICATION_FIX (A15)
# Credit: hướng dẫn gốc của @MMETMAmods
# Chạy từ thư mục gốc của repo (work_dir=$(pwd)), sau khi đã có build/baserom/images
#
# Bản cũ gọi thêm patchMIUIFramework.sh - file này chỉ có ở A13/A14, không có ở
# A15, nên mỗi lần build đều in "No such file or directory". Danh sách dưới đây
# khớp đúng file có trong thư mục và bỏ qua file thiếu thay vì chết giữa chừng.

work_dir=$(pwd)
MAIN_FOLDER="$work_dir/build/baserom/images/"
NF="$work_dir/bin/package/NOTIFICATION_FIX/A15"

for s in PowerKeeper.sh patchMIUIServices.sh; do
    if [[ -f "$NF/$s" ]]; then
        bash "$NF/$s" || echo "[NOTIFICATION_FIX] $s kết thúc với lỗi (bỏ qua, build tiếp tục)"
    else
        echo "[NOTIFICATION_FIX] Không thấy $NF/$s, bỏ qua"
    fi
done
