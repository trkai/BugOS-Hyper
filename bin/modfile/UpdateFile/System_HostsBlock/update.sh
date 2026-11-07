#!/bin/bash
# ---------------------------------------------------------------------------
# System_HostsBlock - chặn domain giám sát ngay ở tầng DNS.
#
# VÌ SAO CHỌN CÁCH NÀY THAY VÌ XOÁ APP (đo trên máy 08/11, a17 / OS4.0.5.0):
#   com.miui.securitycenter chứa 15 module, không xoá lẻ được. Xoá cả app là mất
#   luôn những thứ có ích nằm cùng APK:
#     gamebooster (1811 class refs)  Game Turbo
#     networkassistant (1553)        quản lý data, TƯỜNG LỬA
#     permcenter (660)               QUẢN LÝ QUYỀN ứng dụng
#     powercenter (612)              Power Center, tiết kiệm pin
#     antivirus (438)                quét virus
#     warningcenter (378)            CẢNH BÁO THIÊN TAI + ĐỘNG ĐẤT
#     antispam (241)                 chặn SMS/cuộc gọi rác
#     applicationlock (225)          KHOÁ APP
#     luckymoney/antipeeping/...     lì xì, chống nhìn trộm
#   Chặn DNS giữ được tất cả những cái trên mà vẫn cắt đường gửi dữ liệu.
#
# HOSTS CÓ TÁC DỤNG THẬT KHÔNG: có. Đã kiểm trên máy bằng bind-mount:
#   ping flash.sec.miui.com -> 127.0.0.1
#   ping eps.caict.ac.cn    -> 127.0.0.1
#   mở 手机管家 vẫn chạy, logcat không có FATAL.
# Android đọc /system/etc/hosts (netd), resolver KHÔNG cache qua lần reboot nên
# sửa file trong image là đủ, không cần app hỗ trợ.
#
# DANH SÁCH MẶC ĐỊNH - mỗi domain kèm chứng cứ đọc từ chính APK:
#   flash.sec.miui.com
#     MIUISecurityCenter: POST /user/cat, /user/ra, /detect/app
#       payload: android_id, device, carrier, region, miuiVersion, apps, sign
#       gọi từ PrivacyRiskDetectionActivity (chỉ khi bấm quét) và
#       GuardProvider NetworkApiHelper.
#     SecurityCenter: /gc/dir (RemoteDirDataManager), /satisfaction/questionnaire
#   fraud-detection.engine.miui.com
#     NfcAccessHttpUtil: GET /nfc/antifraud/config - chỉ TẢI config về, nhưng
#     chặn để không có đường nhận lệnh mới.
#   eps.caict.ac.cn
#     com.miui.policeassist.EPSManager: POST /eps/collect
#       payload: lng, lat, hAccuracy, vAccuracy, altitude, address, caller,
#       called, time, device  -> GPS + số điện thoại.
#   gateway-papa.cloud.weizhi.com
#     com.miui.warningcenter.policeassist.PaUtils: POST /papa/upload
#       payload: phone, CallNumber, CallTime, channelNo=3016, activate_phone
#
# KHÔNG đưa vào đây: dm.wo.com.cn (Baidu Location SDK trong SystemHelper). Hai
# lý do: user không yêu cầu, và SystemHelper đã nằm trong APPLIST debloat nên
# SDK đó không còn chạy. Muốn chặn thêm thì thêm vào block_hosts trong config.
#
# ĐÁNH ĐỔI: mất cảnh báo lừa đảo online, mất cấu hình NFC anti-fraud cập nhật,
# và app có thể log lỗi mạng (không crash). Hai tính năng gửi GPS/số gọi
# (EPS, Police Assist) trên máy đang TẮT sẵn: com_miui_warningcenter_eps_status
# và _pa_status đều = -1, nên chặn là lớp bảo hiểm thêm.
# ---------------------------------------------------------------------------
work_dir=$(pwd)
source "$work_dir/functions.sh"

MAIN_FOLDER="$work_dir/build/baserom/images"
HOSTS="$MAIN_FOLDER/system/system/etc/hosts"

# Cùng định nghĩa với ApplyPatch trên Android: 0.0.0.0 là "chặn, không đi đâu".
DEFAULT_HOSTS="
flash.sec.miui.com
fraud-detection.engine.miui.com
eps.caict.ac.cn
gateway-papa.cloud.weizhi.com
"

skip=$(grep -m1 '^block_tracking_hosts=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$skip" = "false" ]; then
    mods "HostsBlock: block_tracking_hosts=false - bỏ qua"
    exit 0
fi

# block_hosts="a.com b.com" trong config để thay danh sách mặc định.
custom=$(grep -m1 '^block_hosts=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2- | tr -d '"')
if [ -n "$custom" ]; then
    hosts_list=$(printf '%s\n' "$custom" | tr ' ' '\n' | sed '/^$/d')
    mods "HostsBlock: dùng block_hosts từ config"
else
    hosts_list=$(printf '%s\n' "$DEFAULT_HOSTS" | sed '/^$/d')
fi

if [ ! -d "$MAIN_FOLDER" ]; then
    warn "HostsBlock: không thấy $MAIN_FOLDER - bỏ qua"
    exit 0
fi

# Thư mục etc phải có sẵn trong image; thiếu thì tạo (một số bản ROM để hosts ở
# system_ext/etc thay vì system/etc, nhưng netd luôn đọc /system/etc/hosts).
mkdir -p "$(dirname "$HOSTS")"
if [ ! -f "$HOSTS" ]; then
    printf '127.0.0.1       localhost\n::1             ip6-localhost\n' > "$HOSTS"
    mods "HostsBlock: tạo mới system/etc/hosts"
fi

added=0
skipped=0
while IFS= read -r d; do
    [ -n "$d" ] || continue
    case "$d" in \#*) continue ;; esac
    # idempotent: build lại không sinh dòng trùng
    if grep -qE "^[[:space:]]*0\.0\.0\.0[[:space:]]+${d}[[:space:]]*$" "$HOSTS"; then
        skipped=$((skipped + 1))
        continue
    fi
    printf '0.0.0.0 %s\n' "$d" >> "$HOSTS"
    added=$((added + 1))
done <<< "$hosts_list"

if [ "$added" -eq 0 ]; then
    mods "HostsBlock: đã có đủ ${skipped} domain, không thêm"
else
    mods "HostsBlock: thêm $added domain vào system/etc/hosts (bỏ qua $skipped đã có)"
fi

# Kiểm lại cho chắc: file phải đọc được và có ít nhất 1 dòng 0.0.0.0
if ! grep -q '^0\.0\.0\.0 ' "$HOSTS" 2>/dev/null; then
    warn "HostsBlock: hosts không có dòng 0.0.0.0 nào - kiểm lại đường dẫn"
    exit 0
fi
mods "HostsBlock: xong, $(grep -c '^0\.0\.0\.0 ' "$HOSTS") domain bị chặn"
