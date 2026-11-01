work_dir=$(pwd)
source "$work_dir/functions.sh"

# ---------------------------------------------------------------------------
# Port phần runtime của HyperOS FCM Notification Fix v1.4 (biplobsd) vào ROM.
#
# Module gốc là Magisk module: nó chạy script bằng magiskd (uid root, không bị
# SELinux chặn). ROM không có magiskd, nhưng có thể làm tương đương bằng init:
#
#   /system_ext/etc/init/init.bugos.fcm.rc   -> service oneshot, user root,
#                                               seclabel u:r:su:s0, start khi
#                                               sys.boot_completed=1
#   /system_ext/etc/bugos_fcm_boot.sh        -> 4 bước của module
#
# Vì sao dùng service chứ không `exec`: exec của init là đồng bộ, init đứng chờ
# script (có sleep 5/15s) -> chậm boot. service chạy nền nên không ảnh hưởng.
#
# Phần jar patch (V1-V4) KHÔNG nằm ở đây - đã có sẵn ở UpdateFile/
# FCM_NotificationFix và đã kiểm chứng trên máy: FcmWakeFilter có trong cả
# services.jar lẫn miui-services.jar, triggerGMSLimitAction = return-void.
#
# Bật/tắt bằng fcm_boot_apply trong config.env.
#
# LƯU Ý: script phía máy đặt tên bugos_fcm_boot.src (KHÔNG phải .sh). Vì
# UpdateFile/insupdate.sh chạy `bash` mọi file *.sh trong cây UpdateFile, nên nếu
# để .sh thì chính script dành-cho-điện-thoại này bị chạy trên máy build - log
# build sẽ in "log: command not found" 6 lần (hàm log của Android không có trên
# Linux) và các lệnh cmd/settings/content/iptables chạy vào khoảng không. Đừng
# đổi lại đuôi .sh.
# ---------------------------------------------------------------------------

ENABLE=$(grep -m1 '^fcm_boot_apply=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d '\r\n ')
if [ "$ENABLE" = "false" ]; then
    mods "FCMBoot: bỏ qua (fcm_boot_apply=false)"
    exit 0
fi

MAIN_FOLDER="$work_dir/build/baserom/images"
SRC_DIR="$work_dir/bin/modfile/UpdateFile/System_FCMBootApply"
DEST_RC="$MAIN_FOLDER/system_ext/etc/init/init.bugos.fcm.rc"
DEST_SH="$MAIN_FOLDER/system_ext/etc/bugos_fcm_boot.sh"

if [ ! -d "$MAIN_FOLDER/system_ext" ]; then
    warn "FCMBoot: không thấy system_ext trong images - bỏ qua"
    exit 0
fi

if [ ! -f "$SRC_DIR/init.bugos.fcm.rc" ] || [ ! -f "$SRC_DIR/bugos_fcm_boot.src" ]; then
    warn "FCMBoot: thiếu file nguồn trong $SRC_DIR - bỏ qua"
    exit 0
fi

mkdir -p "$MAIN_FOLDER/system_ext/etc/init"

cp -f "$SRC_DIR/init.bugos.fcm.rc" "$DEST_RC" || {
    warn "FCMBoot: copy rc thất bại - bỏ qua"; exit 0; }
cp -f "$SRC_DIR/bugos_fcm_boot.src" "$DEST_SH" || {
    warn "FCMBoot: copy script thất bại - bỏ qua"; exit 0; }

chmod 0644 "$DEST_RC"
chmod 0755 "$DEST_SH"

# Kiểm tra lại sau khi copy
if ! grep -q 'start bugos_fcm_boot' "$DEST_RC"; then
    warn "FCMBoot: rc không có dòng start bugos_fcm_boot"
    exit 0
fi
if ! grep -q 'bugos_fcm_boot.sh' "$DEST_RC"; then
    warn "FCMBoot: rc không trỏ tới bugos_fcm_boot.sh"
    exit 0
fi
if ! grep -q 'cmd greezer thuid' "$DEST_SH"; then
    warn "FCMBoot: script thiếu bước greezer"
    exit 0
fi

mods "FCMBoot: đã cài init service + script (GMS exemption, GCM_RECONNECT, PowerKeeper, settings)"
mods "FCMBoot: log sau khi boot -> adb logcat -s BugOSFCM"
