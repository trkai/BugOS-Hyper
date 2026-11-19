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

# ---------------------------------------------------------------------------
# CHỈ NHẬN ROM CHINA - lớp 2, đọc từ build.prop THẬT.
#
# Lớp 1 (getROM.sh) đoán region từ tên file; cách đó bị qua mặt nếu ai đổi tên
# zip. Ở đây đọc ro.miui.build.region trong build.prop của ROM đã bung - đó là
# sự thật, không phải suy đoán.
#
# Vì sao chặn Global: toàn bộ bộ mod de-China (gmsservices, MultiLang,
# Settings_GoogleShowUpCN, enhanchedkeyboard, Fonts, Framework_FixDelayPowerMenu,
# PRECHINAFIX, FEATURE_UNLOCK) giả định base là ROM China. Chạy trên base Global
# sẽ chép chồng GMS, sai vùng ngôn ngữ, và patch vào những anchor không tồn tại.
#
# Giá trị thường gặp: CN (China), GL (Global), EE (EEA), RU, IN, ID, TR, TW, JP.
# ---------------------------------------------------------------------------
BUILD_PROP="$work_dir/build/baserom/images/system/system/build.prop"
if [ -f "$BUILD_PROP" ]; then
    ROM_REGION_REAL=$(grep -m1 '^ro\.miui\.build\.region=' "$BUILD_PROP" 2>/dev/null | cut -d= -f2 | tr -d '\r\n ')
    [ -z "$ROM_REGION_REAL" ] && ROM_REGION_REAL=$(grep -m1 '^ro\.miui\.region=' "$BUILD_PROP" 2>/dev/null | cut -d= -f2 | tr -d '\r\n ')

    if [ -n "$ROM_REGION_REAL" ]; then
        mods "Vùng ROM thực tế (build.prop): $ROM_REGION_REAL"
        if [ "$ROM_REGION_REAL" != "CN" ]; then
            error "ROM này là vùng '$ROM_REGION_REAL', KHÔNG phải China (CN)."
            error "Repo chỉ build ROM CHINA. Bộ mod de-China sẽ chạy sai trên base Global."
            error "Dừng build - không tạo ra ROM hỏng."
            exit 1
        fi
    else
        warn "ROM: build.prop không có ro.miui.build.region / ro.miui.region - bỏ qua kiểm tra vùng"
    fi
else
    warn "ROM: không thấy $BUILD_PROP - bỏ qua kiểm tra vùng bằng build.prop"
fi

# DEVICE_TYPE đoán từ tên file: nếu nó nói Global thì cũng dừng, vì hai lớp
# phải đồng ý với nhau.
if echo "$REGION" | grep -qiv '^china$' && [ -n "$REGION" ]; then
    error "Region nhận từ tên file là '$REGION' - chỉ nhận China. Dừng."
    exit 1
fi

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
    echo "  bổ sung jar_patcher_a${ANDROID_MAJOR}.sh"
    echo "  rồi build lại. Xem documentation/ANDROID17.md."
    exit 1
fi

# shellcheck disable=SC1090
source "$TARGET_ENV"

if [ -n "$TARGET_SDK" ] && [ -n "$SDK_LEVEL" ] && [ "$TARGET_SDK" != "$SDK_LEVEL" ]; then
    error "SDK thực tế ($SDK_LEVEL) khác cấu hình target ($TARGET_SDK)."
    error "Bộ patch (smali anchor) được viết cho SDK $TARGET_SDK; chạy trên SDK khác"
    error "sẽ trượt anchor hoặc tạo ROM không boot. Dừng."
    exit 1
fi

# TARGET_HYPEROS phải được kiểm tra thật, không chỉ khai báo trong .env.
# Trước đây biến này có trong targets/android17.env ("OS4 OS5 OS6") nhưng KHÔNG
# chỗ nào đọc -> OS5/OS6 lọt qua bước này và chỉ bị chặn muộn ở getROM.sh.
if [ -n "$TARGET_HYPEROS" ] && [ -n "$ROM_OS" ]; then
    hyper_ok=0
    for h in $TARGET_HYPEROS; do
        [ "$h" = "$ROM_OS" ] && hyper_ok=1
    done
    if [ "$hyper_ok" -eq 0 ]; then
        error "HyperOS '$ROM_OS' không nằm trong target hỗ trợ của Android $ANDROID_MAJOR."
        error "Target cho phép: $TARGET_HYPEROS"
        error "Dừng build."
        exit 1
    fi
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
