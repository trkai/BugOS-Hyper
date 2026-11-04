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
bash $target_dir/NOTIFICATION_FIX/notificationFIX.sh
bash $target_dir/RefreshRate/1hz.sh

# ---------------------------------------------------------------------------
# Chốt chặn cuối chuỗi jar: FcmWakeFilter phải còn trong CẢ HAI jar.
#
# Đây là class mà FCM_NotificationFix chèn vào để push vẫn tới khi màn hình tắt.
# Nó nằm trong 2 dex khác nhau (services.dex và miui-services classes2.dex), và
# mỗi bước sau đó (COREPATCH, FixDevicePolicy, FixDelayPowerMenu, NOTIFICATION_FIX)
# đều giải nén rồi đóng gói lại jar. Chỉ cần một bước đóng gói sai là class biến
# mất, push chết, mà build vẫn "thành công" - đúng kiểu lỗi đã gặp.
#
# Chỉ áp cho ROM China: Global bị FCM bỏ qua có chủ ý.
# ---------------------------------------------------------------------------
fcm_final_check() {
    local region missing="" j rel
    region=$(cat "$work_dir/bin/ddevice/device_type.txt" 2>/dev/null | tr -d '\r\n ')
    [ "$region" = "China" ] || return 0

    # grep thẳng lên jar chỉ đúng khi dex được lưu uncompressed (các bước đóng gói
    # của repo đều dùng 7za -mx=0 nên thường đúng). Nếu jar bị nén lại thì grep
    # trượt oan, nên fallback: giải nén từng dex rồi tìm.
    jar_has_fcm() {
        local jar="$1" d
        grep -aqm1 FcmWakeFilter "$jar" 2>/dev/null && return 0
        while IFS= read -r d; do
            unzip -p "$jar" "$d" 2>/dev/null | grep -aqm1 FcmWakeFilter && return 0
        done < <(unzip -Z1 "$jar" '*.dex' 2>/dev/null)
        return 1
    }

    for j in system/system/framework/services.jar system_ext/framework/miui-services.jar; do
        # đường dẫn tuyệt đối: hàm này có thể được gọi khi CWD không phải gốc repo
        rel="$work_dir/build/baserom/images/$j"
        [ -f "$rel" ] || continue
        if ! jar_has_fcm "$rel"; then
            missing="$missing $j"
        fi
    done

    if [ -n "$missing" ]; then
        error "FCM: thiếu FcmWakeFilter trong:$missing"
        error "Push sẽ KHÔNG tới khi màn hình tắt. Xem log FCM ở bước UpdateFile"
        error "và log các bước đóng gói lại jar (COREPATCH / NOTIFICATION_FIX)."
        return 1
    fi
    mods "FCM: FcmWakeFilter còn trong cả 2 jar (push OK)"
}

fcm_final_check || exit 1

mods "Add Package Done"
