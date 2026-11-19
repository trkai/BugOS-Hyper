#!/system/bin/sh
# ---------------------------------------------------------------------------
# BugOS FCM fix - phan chay luc boot.
#
# Nguyen li lay tu module HyperOS_FCM_OnTheFly_Fix v1.4 (biplobsd). Module do
# va bytecode services.jar/miui-services.jar de noi long NotificationAttention
# Helper va Greezer; phan do khong port duoc (xem config.env: GreezeManagerService
# khong con tren A17). Nhung thu module do lam bang shell moi boot thi port duoc
# va khong phu thuoc phien ban - do chinh la noi dung file nay.
#
# Bon nhom:
#   1. Mien tru GMS khoi Doze/AppOps/cgroup freezer.
#   2. Pha "tuong lua GMS" cua PowerKeeper (gms_control=false + flush chain).
#   3. Ep GCM noi lai socket ngay (GCM_RECONNECT).
#   4. (tuy chon) bat man hinh khi co thong bao.
#
# Doc /system/etc/bugos-fcm.conf de biet bat/tat tung phan.
# ---------------------------------------------------------------------------
LOG_TAG=bugos-fcm
say() { echo "$LOG_TAG: $*" > /dev/kmsg 2>/dev/null; }

CONF=/system/etc/bugos-fcm.conf
conf_get() {
    [ -f "$CONF" ] || return 1
    sed -n "s/^$1=//p" "$CONF" 2>/dev/null | head -n1 | tr -d ' \r'
}

i=0
while [ "$(getprop sys.boot_completed)" != "1" ] && [ "$i" -lt 120 ]; do
    sleep 2
    i=$((i + 1))
done

# --- 1. GMS: Doze whitelist + AppOps + cgroup freezer ----------------------
GMS=com.google.android.gms
UID_GMS=$(pm list packages -U "$GMS" 2>/dev/null | grep -E "^package:$GMS " | grep -o 'uid:[0-9]*' | cut -d: -f2 | head -n1)
[ -z "$UID_GMS" ] && UID_GMS=$(stat -c %u "/data/data/$GMS" 2>/dev/null)

if [ -n "$UID_GMS" ]; then
    cmd deviceidle whitelist +"$GMS" 2>/dev/null
    cmd deviceidle sys-whitelist +"$GMS" 2>/dev/null
    cmd appops set "$GMS" RUN_IN_BACKGROUND allow 2>/dev/null
    cmd appops set "$GMS" RUN_ANY_IN_BACKGROUND allow 2>/dev/null
    cmd appops set "$GMS" 10008 allow 2>/dev/null
    cmd appops set "$GMS" WAKE_LOCK allow 2>/dev/null

    # Greezer cua MIUI: tha GMS khoi bi dong bang trong 24h va bo theo doi.
    # Lenh khong ton tai tren vai ban -> bo qua im lang.
    cmd greezer thuid "$UID_GMS" 86400000 2>/dev/null
    cmd greezer unmonitor "$UID_GMS" 2>/dev/null

    # cgroup freezer (ca v1 va v2)
    for fz in "/sys/fs/cgroup/apps/uid_${UID_GMS}/cgroup.freeze" \
              "/sys/fs/cgroup/uid_${UID_GMS}/cgroup.freeze" \
              "/sys/fs/cgroup/apps/uid_${UID_GMS}"/*/cgroup.freeze \
              "/sys/fs/cgroup/uid_${UID_GMS}"/*/cgroup.freeze \
              "/dev/freezer/apps/uid_${UID_GMS}/freezer.state"; do
        [ -f "$fz" ] || continue
        case "$fz" in
            *freezer.state) echo THAWED > "$fz" 2>/dev/null ;;
            *)              echo 0 > "$fz" 2>/dev/null ;;
        esac
    done
    say "GMS uid=$UID_GMS: da mien tru Doze/AppOps/freezer"
else
    say "khong tim thay uid cua $GMS"
fi

# --- 2. PowerKeeper: pha tuong lua GMS ------------------------------------
# Tren ROM China, PowerKeeper co GmsObserver dung iptables chain gms_wall de
# chan TCP/DNS cua GMS khi khong voi toi server Google -> FCM chet han.
# gms_control=false tat ca: chain, DNS blocker, thu hoi wakelock, chan alarm.
# Provider co the chua len ngay sau boot -> thu 3 lan.
pk_disarm() {
    content call --uri content://com.miui.powerkeeper.configure/SimpleSettings/misc \
        --method PUT_misc --arg gms_control --extra value:s:false 2>/dev/null || return 1
    for p in com.google.android.gms com.android.vending; do
        content update --uri content://com.miui.powerkeeper.configure/userTable \
            --bind bgControl:s:noRestrict \
            --where "pkgName='${p}' AND userId=0" 2>/dev/null
        has=$(content query --uri content://com.miui.powerkeeper.configure/userTable \
              --where "pkgName='${p}' AND userId=0" 2>/dev/null | grep -c "pkgName=$p")
        [ "$has" = "0" ] && content insert \
            --uri content://com.miui.powerkeeper.configure/userTable \
            --bind pkgName:s:"$p" --bind userId:i:0 --bind bgControl:s:noRestrict 2>/dev/null
    done
    iptables -F gms_wall 2>/dev/null
    ip6tables -F gms_wall 2>/dev/null
    return 0
}

if command -v content >/dev/null 2>&1; then
    for d in 0 5 15; do
        [ "$d" -gt 0 ] && sleep "$d"
        if pk_disarm; then
            say "PowerKeeper: gms_control=false, gms_wall da flush"
            break
        fi
        [ "$d" = "15" ] && say "PowerKeeper: khong dat duoc gms_control (provider chua san sang)"
    done
fi

# --- 3. Ep GCM noi lai socket ---------------------------------------------
# Khong co tac dung phu: day la broadcast noi bo cua GMS.
am broadcast -a com.google.android.intent.action.GCM_RECONNECT -p com.google.android.gms >/dev/null 2>&1
say "da gui GCM_RECONNECT"

# --- 4. Tuy chon: sang man hinh khi co thong bao ---------------------------
# Mac dinh TAT noi dung khoa man hinh: do la lua chon rieng tu, khong nen tu bat.
if [ "$(conf_get wake_screen)" = "1" ]; then
    settings put system wake_up_for_notification 1 2>/dev/null
    settings put system wakeup_for_keyguard_notification 1 2>/dev/null
    settings put secure lock_screen_wake_up_for_notification 1 2>/dev/null
    say "da bat sang man hinh khi co thong bao"
fi

if [ "$(conf_get lockscreen_content)" = "1" ]; then
    settings put secure lock_screen_show_notifications 1 2>/dev/null
    settings put secure lock_screen_allow_private_notifications 1 2>/dev/null
    settings put system pref_key_enable_notification_body 1 2>/dev/null
    say "da bat hien noi dung thong bao tren man hinh khoa"
fi

exit 0
