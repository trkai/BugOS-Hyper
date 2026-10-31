work_dir=$(pwd)
source "$work_dir/functions.sh"

# ---------------------------------------------------------------------------
# Giả trạng thái bootloader đã khóa (Cài đặt -> Trạng thái Mở khóa Mi).
#
# Trang đó là com.android.settings/.bootloader.BootloaderStatusActivity. Đọc
# dexdump của Settings.apk (classes2.dex) thì onCreate chỉ làm đúng thế này:
#
#     String state = sDeviceStateOverride;                  // luôn null
#     if (state == null)
#         state = SystemProperties.get("ro.secureboot.lockstate", null);
#     if ("locked".equals(state)) setContentView(R.layout.bootloader_status_locked);
#     else                        setContentView(R.layout.bootloader_status_unlocked);
#
# Nên toàn bộ việc hiện "đã mở khóa" nằm ở prop ro.secureboot.lockstate.
#
# Prop đó do /system_ext/etc/init/init.secureboot.rc đặt:
#
#     on init && property:ro.secureboot.devicelock=1 && property:ro.boot.verifiedbootstate=green
#         setprop ro.secureboot.lockstate locked
#     on init && property:ro.secureboot.devicelock=1 && property:ro.boot.verifiedbootstate=orange
#         setprop ro.secureboot.lockstate unlocked
#     on init && property:ro.secureboot.devicelock=1
#         setprop ro.secureboot.lockstate unknown
#
# Nhưng trigger `property:...=orange` KHÔNG BAO GIỜ chạy: ro.boot.* đã được set
# từ cmdline trước khi init đọc file này, mà trigger của init chỉ bắn khi prop
# *đổi* giá trị sau khi trigger được đăng ký. Kết quả trên máy thật:
# ro.boot.verifiedbootstate=orange nhưng ro.secureboot.lockstate=unknown -> rơi
# vào nhánh else -> hiện "Thiết bị này đã mở khóa".
#
# Sửa: bỏ hết các nhánh điều kiện, đặt thẳng "locked". ro.* là write-once nên
# không nhánh nào ghi đè lại được.
#
# Lưu ý phạm vi: đây là fake ở mức *báo cáo*. ro.boot.verifiedbootstate và
# ro.boot.vbmeta.device_state vẫn là orange/unlocked (do bootloader truyền vào,
# init không sửa được), nên app nào đọc trực tiếp hai prop đó hoặc dùng key
# attestation (Play Integrity, app ngân hàng) vẫn thấy máy đã mở khóa.
# ---------------------------------------------------------------------------

FAKE=$(grep -m1 '^fake_locked_bootloader=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d '\r\n ')
if [ "$FAKE" = "false" ]; then
    mods "FakeLocked: bỏ qua (fake_locked_bootloader=false)"
    exit 0
fi

MAIN_FOLDER="$work_dir/build/baserom/images"
if [ ! -d "$MAIN_FOLDER" ]; then
    warn "FakeLocked: không thấy $MAIN_FOLDER - bỏ qua"
    exit 0
fi

# ROM có 2 bản copy giống nhau: system_ext/etc/init/ (init thật sự đọc) và
# system_ext/etc/ (bản trùng). Vá cả hai cho chắc.
# Đọc bằng -print0 + while read: đường dẫn repo có dấu cách ("New folder"),
# tách bằng $IFS sẽ vỡ đường dẫn.
FOUND=$(find "$MAIN_FOLDER" -type f -name "init.secureboot.rc" 2>/dev/null | wc -l)
if [ "$FOUND" -eq 0 ]; then
    warn "FakeLocked: không thấy init.secureboot.rc trong images - bỏ qua"
    exit 0
fi

COUNT=0
while IFS= read -r -d '' rc; do
    [ -f "$rc" ] || continue
    before=$(grep -c '^[[:space:]]*setprop ro\.secureboot\.lockstate' "$rc" 2>/dev/null)

    cat > "$rc" << 'RCEOF'
# BugOS: luôn báo bootloader đã khóa.
# Bản gốc đặt ro.secureboot.lockstate theo ro.boot.verifiedbootstate, nhưng
# trigger property:...=orange không bao giờ chạy (ro.boot.* đã có giá trị từ
# trước khi init đọc file này) nên prop kẹt ở "unknown" và Cài đặt hiện
# "Thiết bị này đã mở khóa". ro.* là write-once, đặt thẳng ở đây là chốt.
on init
    setprop ro.secureboot.lockstate locked
RCEOF

    if [ "$(grep -c 'setprop ro\.secureboot\.lockstate locked' "$rc")" != "1" ]; then
        warn "FakeLocked: ghi $rc không như mong đợi"
        continue
    fi
    if grep -q 'lockstate unlocked' "$rc"; then
        warn "FakeLocked: $rc vẫn còn nhánh unlocked"
        continue
    fi
    COUNT=$((COUNT + 1))
    mods "FakeLocked: $(echo "$rc" | sed "s|$MAIN_FOLDER/||") ($before -> 1 setprop, locked)"
done < <(find "$MAIN_FOLDER" -type f -name "init.secureboot.rc" -print0 2>/dev/null)

if [ "$COUNT" -eq 0 ]; then
    warn "FakeLocked: không vá được file nào"
    exit 0
fi
mods "FakeLocked: bootloader sẽ báo đã khóa ($COUNT file)"
