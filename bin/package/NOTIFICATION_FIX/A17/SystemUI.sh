#!/bin/bash
# BugOS - NOTIFICATION_FIX A17 - SystemUI
#
# VẤN ĐỀ (đã kiểm chứng trên máy annibale, OS4.0.6 / Android 17):
#   - Thông báo tới nhưng KHÔNG sáng màn hình và KHÔNG có chuông.
#   - Chỉ một vài app (WeChat...) mới kêu và đánh thức được.
#
# NGUYÊN NHÂN GỐC: bản ROM Trung Quốc bật chế độ "whitelist" cho thông báo.
#   NotificationSettingsManager.<clinit> tính:
#       USE_WHITE_LISTS = !IS_INTERNATIONAL_BUILD
#   Trên ROM CN, IS_INTERNATIONAL_BUILD = false -> USE_WHITE_LISTS = TRUE.
#   Khi cờ này bật, cả ba hàm quyết định trải nghiệm đều chỉ trả TRUE nếu app
#   nằm trong mảng whitelist của SystemUI:
#       canSound(ctx, pkg, channel)          -> có chuông?
#       canVibrate(ctx, pkg, channel)        -> có rung?
#       canShowOnKeyguard(ctx, pkg, channel) -> hiện trên màn hình khoá?
#   App không có tên trong whitelist -> canSound=false, canVibrate=false,
#   canShowOnKeyguard=false. Hệ quả kéo theo:
#       * AlertCoordinator.buzzBeepBlink tính buzz/beep = 0 -> im lặng.
#       * MiuiAlertManager không gọi wakeUpForNotificationInternal() vì
#         chuỗi gate "f,!show on keyguard" return sớm -> màn hình không sáng.
#   (Đo thực tế: chỉ com.xiaomi.aicr có mBuzzBeepBlinkCode=2; mọi app người
#    dùng khác đều =0, dù channel của chúng importance=4 và có sound URI.)
#
# CÁCH VÁ: ép USE_WHITE_LISTS = false. Khi đó MIUI chuyển sang chế độ
#   "blocklist": app được phép mặc định, chỉ chặn nếu tên nằm trong
#   mBlockFloatPackages. Đây đúng là hành vi của bản quốc tế, không phải nới
#   lỏng tuỳ tiện: mọi giới hạn người dùng đã đặt (tắt chuông từng app,
#   DND, mức importance của channel) vẫn còn nguyên tác dụng.
#
# KHÔNG sửa APK theo cách khác (không đổi chữ ký): dùng APKEditor để build
# lại giữ nguyên chữ ký gốc, nếu không PackageManager sẽ từ chối SystemUI.

work_dir=$(pwd)
[ -f "$work_dir/functions.sh" ] && source "$work_dir/functions.sh"

MAIN_FOLDER="$work_dir/build/baserom/images"
TOOLS_DIR="$work_dir/bin/apktool"

log_msg() {
    if type mods &>/dev/null; then mods "$1"
    elif type patch &>/dev/null; then patch "$1"
    else echo "[SystemUI] $1"; fi
}

warn_msg() {
    if type warn &>/dev/null; then warn "$1"; else echo "[SystemUI][WARN] $1"; fi
}

APK=$(find "$MAIN_FOLDER" -type f -name "MiuiSystemUI.apk" 2>/dev/null | head -n1)
if [ -z "$APK" ]; then
    warn_msg "SystemUI: ROM không có MiuiSystemUI.apk - bỏ qua"
    exit 0
fi

DEC="$work_dir/systemui_decompile"
rm -rf "$DEC"

log_msg "SystemUI: giải nén $(basename "$APK")…"
if ! java -jar "$TOOLS_DIR/apke.jar" d -i "$APK" -o "$DEC" >/dev/null 2>&1; then
    warn_msg "SystemUI: APKEditor không giải nén được - bỏ qua"
    exit 0
fi

TARGET=$(find "$DEC" -path '*/com/miui/systemui/notification/NotificationSettingsManager.smali' 2>/dev/null | head -n1)
if [ -z "$TARGET" ]; then
    # Phòng khi đường dẫn khác giữa các bản ROM.
    TARGET=$(grep -rl "USE_WHITE_LISTS" "$DEC" 2>/dev/null | grep 'NotificationSettingsManager.smali' | head -n1)
fi
if [ -z "$TARGET" ] || [ ! -f "$TARGET" ]; then
    warn_msg "SystemUI: không thấy NotificationSettingsManager.smali - bỏ qua"
    exit 0
fi

python3 - "$TARGET" <<'PY'
import io, re, sys

path = sys.argv[1]
src = io.open(path, encoding='utf-8').read()

# Chỉ can thiệp đúng một dòng: dòng ghi USE_WHITE_LISTS trong <clinit>.
# Chèn "const/4 v0, 0x0" ngay trước nó để giá trị ghi vào luôn là false.
# Cách này không phụ thuộc định dạng smali của từng bộ công cụ (có/không có
# dòng trống giữa các lệnh, tên thanh ghi khác nhau), và để nguyên phần
# sget/xor phía trước — kết quả của chúng bị const/4 ghi đè ngay sau đó.
pat = re.compile(
    r'^([ \t]*)sput-boolean\s+(\w+),\s*Lcom/miui/systemui/notification/NotificationSettingsManager;->USE_WHITE_LISTS:Z',
    re.M)

def repl(m):
    indent = m.group(1)
    reg = m.group(2)   # dùng đúng thanh ghi mà sput sẽ đọc
    return (f'{indent}const/4 {reg}, 0x0\n\n'
            f'{indent}sput-boolean {reg}, Lcom/miui/systemui/notification/NotificationSettingsManager;->USE_WHITE_LISTS:Z')

src2, n = pat.subn(repl, src, count=1)

if n == 0:
    print("[SystemUI] KHONG tim thay dong ghi USE_WHITE_LISTS - bo qua")
    sys.exit(2)

io.open(path, 'w', encoding='utf-8', newline='\n').write(src2)
print("[SystemUI] da va USE_WHITE_LISTS -> false")
PY

if [ $? -ne 0 ]; then
    warn_msg "SystemUI: vá smali thất bại - giữ APK gốc"
    rm -rf "$DEC"
    exit 0
fi

log_msg "SystemUI: build lại APK (giữ chữ ký gốc)…"
OUT="$work_dir/MiuiSystemUI_patched.apk"
rm -f "$OUT"
if ! java -jar "$TOOLS_DIR/apke.jar" b -i "$DEC" -o "$OUT" >/dev/null 2>&1; then
    warn_msg "SystemUI: build lại thất bại - giữ APK gốc"
    rm -rf "$DEC"
    exit 0
fi

if [ ! -s "$OUT" ]; then
    warn_msg "SystemUI: APK ra rỗng - giữ APK gốc"
    rm -rf "$DEC"
    exit 0
fi

cp -f "$OUT" "$APK" && log_msg "SystemUI: đã thay APK trong ROM (whitelist thông báo đã tắt)"

rm -rf "$DEC"
rm -f "$OUT"
exit 0
