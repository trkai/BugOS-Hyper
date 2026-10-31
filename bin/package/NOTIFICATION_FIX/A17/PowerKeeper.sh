#!/bin/bash
# BugOS - NOTIFICATION_FIX A17 - PowerKeeper
# Credit: hướng dẫn gốc của @MMETMAmods
#
# KẾT LUẬN: trên Android 17, PowerKeeper KHÔNG cần vá cho thông báo, và script này
# cố ý không sửa APK.
#
# Lý do - đã kiểm chứng trên PowerKeeper.apk và miui-services.jar thật của OS4:
#
# 1. Bản A16 sửa MilletConfig.smali. Trên A17 file này KHÔNG tồn tại (find không
#    ra), và phương thức isGmsControlEnabled() cũng không còn. Đó là lý do mọi
#    bản build OS4 in "không vá được MilletConfig" - không phải lỗi, mà là đích
#    vá đã bị Xiaomi xoá.
#
# 2. A17 thay bằng GmsObserver.updateFrameworkGmsNetStatus(Z)Z, gọi sang greeze
#    updateGmsNetStatus(Z)Z. Chuỗi đó dẫn tới:
#        updateGmsNetStatus(true) -> handler.post(lambda) -> triggerGMSLimitAction()
#    và triggerGMSLimitAction() mở đầu bằng:
#        if (!PolicyManager.isCnModel()) return;   // thoát ngay
#    ROM này đặt ro.miui.region=VN nên isCnModel()=false -> cả chuỗi là no-op.
#    Vá thêm vào đây không thay đổi gì, chỉ làm mất chữ ký APK và buộc ART biên
#    dịch lại - không có lợi.
#
# 3. Trường hợp ROM region CN (isCnModel()=true) thì triggerGMSLimitAction có
#    chạy, nhưng vector V3 của FCM_NotificationFix đã vá chính phương thức đó
#    thành return-void. Nên vẫn không cần PowerKeeper.
#
# 4. Trạng thái thật lấy từ máy (dumpsys greezer):
#        [com.google.android.gms] frozen=0s  bg=376s  reason=block:whiteapp
#    GMS chưa bị đóng băng giây nào; greeze chặn đóng băng vì GMS là white app.
#    (Dòng "IM mGmsLimitEnabled : true" là giá trị MẶC ĐỊNH trong constructor của
#     GreezeManagerService, chỉ được đọc bên trong triggerGMSLimitAction - nên
#     nó không có nghĩa là GMS đang bị giới hạn.)
#
# Nếu sau này Xiaomi đưa MilletConfig trở lại, thêm nhánh vá vào đây.

work_dir=$(pwd)
[ -f "$work_dir/functions.sh" ] && source "$work_dir/functions.sh"

MAIN_FOLDER="$work_dir/build/baserom/images"

log_msg() {
    if type patch &>/dev/null; then patch "$1"
    elif type mods &>/dev/null; then mods "$1"
    elif type info &>/dev/null; then info "$1"
    else echo "[PowerKeeper] $1"; fi
}

APK=$(find "$MAIN_FOLDER" -type f -name "PowerKeeper.apk" 2>/dev/null | head -n1)
if [ -z "$APK" ]; then
    log_msg "PowerKeeper: ROM không có PowerKeeper.apk - bỏ qua"
    exit 0
fi

log_msg "PowerKeeper: A17 không cần vá - MilletConfig/isGmsControlEnabled đã bị xoá,"
log_msg "PowerKeeper: và triggerGMSLimitAction tự bỏ qua khi isCnModel()=false (region VN)."
log_msg "PowerKeeper: giữ nguyên APK gốc."
exit 0
