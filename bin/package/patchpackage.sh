work_dir=$(pwd)
source "$work_dir/functions.sh"

target_dir="$work_dir/bin/package/"

# COREPATCH là bước sống-còn: nó bypass verify chữ ký APK trong framework.jar.
# Thiếu nó thì mọi APK đã mod - kể cả bộ de-China ở PRECHINAFIX - bị từ chối
# nạp -> ROM không boot được. Trước đây lỗi ở đây bị bỏ qua và build vẫn chạy
# tiếp (xem log OS4 31/10), nên giờ fail-fast.
if ! bash $target_dir/COREPATCH/update.sh; then
    error "COREPATCH thất bại - DỪNG build (không tạo ROM thiếu signature bypass)"
    exit 1
fi

bash $target_dir/DISABLE_AVB/DISABLEavb.sh
bash $target_dir/RefreshRate/1hz.sh

# Thứ tự trong file này BẮT BUỘC: COREPATCH trước, vì nó là bước bypass chữ ký.
# Mọi script sửa APK (DISABLE_AVB không sửa APK, nhưng mod nào thêm sau thì có)
# phải đứng SAU COREPATCH, nếu không APK sẽ mang chữ ký sai và bị từ chối nạp.

mods "Package: xong"
