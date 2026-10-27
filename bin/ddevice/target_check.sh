#!/bin/bash
# ---------------------------------------------------------------------------
# Cổng chặn version: chạy ngay sau khi bung ROM, TRƯỚC mọi bước mod.
#
# Mục đích: không bao giờ build ra một ROM "nửa vời" cho phiên bản Android mà
# mình chưa có đủ bộ patch. Ví dụ Android 17 khi chưa có jar_patcher_a17.sh thì
# framework.jar sẽ không được bypass verify chữ ký APK -> mọi APK mod bị từ chối
# nạp -> treo logo. Thà dừng sớm với thông báo rõ ràng.
#
# Đọc: bin/ddevice/{androidver,sdkLevel,rom_os}.txt
# Đọc: bin/ddevice/targets/android<VER>.env
# ---------------------------------------------------------------------------
work_dir=$(pwd)
source "$work_dir/functions.sh"

ANDROID_VER=$(cat "$work_dir/bin/ddevice/androidver.txt" 2>/dev/null | tr -d '\r\n ')
SDK_LEVEL=$(cat "$work_dir/bin/ddevice/sdkLevel.txt" 2>/dev/null | tr -d '\r\n ')
ROM_OS=$(cat "$work_dir/bin/ddevice/rom_os.txt" 2>/dev/null | tr -d '\r\n ')
REGION=$(cat "$work_dir/bin/ddevice/device_type.txt" 2>/dev/null | tr -d '\r\n ')

if [ -z "$ANDROID_VER" ]; then
    error "Không đọc được androidver.txt - không xác định được phiên bản Android. Dừng."
    exit 1
fi

# Chuẩn hoá "16.0" -> "16"
ANDROID_MAJOR="${ANDROID_VER%%.*}"

TARGET_ENV="$work_dir/bin/ddevice/targets/android${ANDROID_MAJOR}.env"

mods "Android $ANDROID_VER (SDK ${SDK_LEVEL:-?}) / $ROM_OS / ${REGION:-?}"

if [ ! -f "$TARGET_ENV" ]; then
    error "Chưa hỗ trợ Android $ANDROID_VER."
    error "Không có file cấu hình: bin/ddevice/targets/android${ANDROID_MAJOR}.env"
    echo ""
    echo "  Các target đang có:"
    for f in "$work_dir"/bin/ddevice/targets/*.env; do
        [ -f "$f" ] || continue
        echo "    - $(basename "$f" .env)"
    done
    echo ""
    echo "  Muốn thêm Android $ANDROID_VER: tạo targets/android${ANDROID_MAJOR}.env,"
    echo "  bổ sung jar_patcher_a${ANDROID_MAJOR}.sh + NOTIFICATION_FIX/A${ANDROID_MAJOR}/"
    echo "  rồi build lại. Xem documentation/ANDROID17.md."
    exit 1
fi

# shellcheck disable=SC1090
source "$TARGET_ENV"

if [ -n "$TARGET_SDK" ] && [ -n "$SDK_LEVEL" ] && [ "$TARGET_SDK" != "$SDK_LEVEL" ]; then
    warn "SDK thực tế ($SDK_LEVEL) khác cấu hình target ($TARGET_SDK) - vẫn tiếp tục nhưng cần rà lại patch"
fi

# Mọi file bắt buộc phải có
MISSING=""
for f in $REQUIRED_FILES; do
    [ -f "$work_dir/$f" ] || MISSING="$MISSING\n    - $f"
done

if [ -n "$MISSING" ]; then
    error "Thiếu file bắt buộc cho Android $ANDROID_VER:$MISSING"
    error "Dừng build để tránh tạo ra ROM không boot được."
    exit 1
fi

case "$TARGET_STATUS" in
    stable)
        mods "Target Android $ANDROID_VER: STABLE"
        ;;
    experimental)
        warn "=============================================================="
        warn " Target Android $ANDROID_VER đang ở mức EXPERIMENTAL."
        warn " Nhánh này CHƯA được kiểm chứng trên ROM thật."
        warn " Hãy test kỹ: boot, Settings, thông báo, Fake Lock."
        warn "=============================================================="
        ;;
    *)
        warn "Target Android $ANDROID_VER: trạng thái '$TARGET_STATUS' (không rõ) - vẫn tiếp tục"
        ;;
esac

exit 0
