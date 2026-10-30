work_dir=$(pwd)
source $work_dir/functions.sh

mods "Add Package..."
target_dir="$work_dir/bin/package/"

# COREPATCH là bước sống-còn: nó bypass verify chữ ký APK trong framework.jar.
# Thiếu nó thì mọi APK đã mod bị từ chối nạp -> ROM không dùng được.
# Trước đây lỗi ở đây bị bỏ qua và build vẫn chạy tiếp (xem log OS4 31/10).
if ! bash $target_dir/COREPATCH/update.sh; then
    error "COREPATCH thất bại - DỪNG build (không tạo ROM thiếu signature bypass)"
    exit 1
fi

bash $target_dir/DISABLE_AVB/DISABLEavb.sh
bash $target_dir/KouseiPatcher/update.sh
bash $target_dir/NOTIFICATION_FIX/notificationFIX.sh
bash $target_dir/RefreshRate/1hz.sh
mods "Add Package Done"
