WORK_DIR=$(pwd)
source $WORK_DIR/functions.sh
AndroidVER=$(cat $WORK_DIR/bin/ddevice/androidver.txt 2>/dev/null | tr -d '\r\n ')
regionTYPE=$(cat $WORK_DIR/bin/ddevice/device_type.txt 2>/dev/null | tr -d '\r\n ')

# THỨ TỰ QUAN TRỌNG:
# Patch A16 đổi Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z -> IS_MIUI trong
# miui-services.jar. Mod FCM_NotificationFix (chạy ở bước UpdateFile, TRƯỚC bước
# package này) lại cần thấy IS_INTERNATIONAL_BUILD trong
# BroadcastQueueModernStubImpl để vá vector V4. Vì vậy FCM phải chạy trước;
# nếu đảo lại, engine FCM sẽ báo FAIL V4 và huỷ toàn bộ 4 vector.

if [[ $regionTYPE == *"Global"* ]]; then
    warn "No Support Global ROM!Skipping..."
    exit 0
fi

# Chọn thư mục patch theo số Android chính (12/13/14/15/16...), không hard-code
# chuỗi if/elif nữa: thêm A17 chỉ cần thêm thư mục, không phải sửa file này.
MAJOR="${AndroidVER%%.*}"
NF_DIR="$WORK_DIR/bin/package/NOTIFICATION_FIX/A$MAJOR"

if [ -z "$MAJOR" ]; then
    warn "NOTIFICATION_FIX: không đọc được androidver.txt - bỏ qua"
    exit 0
fi

if [ -f "$NF_DIR/RUN.SH" ]; then
    mods "Applying NOTIFICATION_FIX for Android $AndroidVER (A$MAJOR)"
    bash "$NF_DIR/RUN.SH"
else
    warn "NOTIFICATION_FIX: chưa có patch cho Android '$AndroidVER' (thiếu A$MAJOR/RUN.SH) - bỏ qua"
fi
