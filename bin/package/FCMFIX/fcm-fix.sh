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
    # GMS co the bi MIUI tat han (khong chi dong bang). Do tren annibale:
    #   dumpsys package com.google.android.gms -> enabled=0
    #   logcat: MIUIAutoUIManagerImpl: pkg = com.google.android.gms is disabled by system
    # Khong co lenh disable nao trong build script - MIUI tu tat khi PowerKeeper
    # chua co cau hinh gms_control. Bat lai truoc khi lam gi khac.
    if dumpsys package "$GMS" 2>/dev/null | grep -q "enabled=0"; then
        pm enable "$GMS" 2>/dev/null && say "GMS bi disable - da bat lai"
    fi

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

    # Doc lai de chac row da ghi. Tren may that, PUT_misc tra "Result: null"
    # nhung row duoc tao that (da thu tren annibale: _id=121 gms_control=false),
    # nen khong dung ket qua tra ve lam dieu kien.
    got=$(content query --uri content://com.miui.powerkeeper.configure/SimpleSettings/misc \
          --where "name='gms_control'" 2>/dev/null | grep -o "value=[^,]*" | head -n1 | cut -d= -f2-)
    [ "$got" = "false" ] || return 1

    for p in com.google.android.gms com.android.vending; do
        content update --uri content://com.miui.powerkeeper.configure/userTable \
            --bind bgControl:s:noRestrict \
            --where "pkgName='${p}' AND userId=0" 2>/dev/null
        # grep -F chi de chac chan: "$p" chua dau cham nen neu de grep hieu la
        # regex thi ve li thuyet khop rong. Tren du lieu that no van dung, nhung
        # -F loai bo hoan toan kha nang do.
        has=$(content query --uri content://com.miui.powerkeeper.configure/userTable \
              --where "pkgName='${p}' AND userId=0" 2>/dev/null | grep -cF "pkgName=$p")
        if [ "$has" = "0" ]; then
            content insert --uri content://com.miui.powerkeeper.configure/userTable \
                --bind pkgName:s:"$p" --bind userId:i:0 --bind bgControl:s:noRestrict 2>/dev/null
        fi
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

# --- 2a. App nguoi dung can thong bao: bgControl=noRestrict ----------------
# Day la phan tra loi cau hoi "cap quyen thong bao thi co duoc on dinh khong".
# Tra loi: KHONG. Quyen thong bao chi cho phep HIEN thi; no khong ngan duoc
# PowerKeeper/Greezer giam process. Hai tang khac nhau:
#   - Quyen thong bao (POST_NOTIFICATIONS) -> NotificationManager co hien hay khong
#   - bgControl trong PowerKeeper userTable -> process co bi giam khi xuong nen
#
# Do tren annibale 21/11 voi nekogram (da co quyen thong bao, da co notification
# record trong dumpsys):
#   bgControl=miuiAuto + Greezer bat -> Frozen pids co 18030 (chinh nekogram),
#       thong bao cham 5-15 phut. Quyen thong bao khong cuu duoc.
#   bgControl=noRestrict + Greezer bat -> ve nen + tat man hinh 3 phut, pid
#       18030 van song, khong bi giam.
#   Greezer tat han -> cung khong bi giam.
# => noRestrict la du; khong phai tat Greezer toan cuc (do la danh doi pin).
#
# Nen: set bgControl=noRestrict cho tung app trong fcm_fix_keep_apps, va de
# Greezer bat nhu mac dinh ROM.
KEEP=$(conf_get fcm_fix_keep_apps)
if [ -n "$KEEP" ]; then
    _n=0
    for p in $(echo "$KEEP" | tr ',' ' '); do
        [ -n "$p" ] || continue
        # Bo qua GMS/Vending: da xu ly trong pk_disarm.
        case "$p" in
            com.google.android.gms|com.android.vending) continue ;;
        esac
        # Chi lam voi app da cai - tranh tao row rac trong userTable.
        if ! pm list packages 2>/dev/null | grep -qF "package:$p"; then
            say "keep-apps: $p chua cai - bo qua"
            continue
        fi
        has=$(content query --uri content://com.miui.powerkeeper.configure/userTable \
              --where "pkgName='${p}' AND userId=0" 2>/dev/null | grep -cF "pkgName=$p")
        if [ "$has" = "0" ]; then
            content insert --uri content://com.miui.powerkeeper.configure/userTable \
                --bind pkgName:s:"$p" --bind userId:i:0 --bind bgControl:s:noRestrict 2>/dev/null
        else
            content update --uri content://com.miui.powerkeeper.configure/userTable \
                --bind bgControl:s:noRestrict \
                --where "pkgName='${p}' AND userId=0" 2>/dev/null
        fi
        # Xac nhan bang cach doc lai, khong tin exit code (xem ghi chu o pk_disarm).
        now=$(content query --uri content://com.miui.powerkeeper.configure/userTable \
              --where "pkgName='${p}' AND userId=0" 2>/dev/null | grep -o 'bgControl=[^,]*' | head -n1 | cut -d= -f2)
        if [ "$now" = "noRestrict" ]; then
            _n=$((_n + 1))
        else
            say "keep-apps: $p -> bgControl=$now (khong dat duoc)"
        fi
    done
    say "keep-apps: $_n app da dat bgControl=noRestrict"
fi

# --- 2b. Greezer: tha app ra va tat launch-freeze -------------------------
# Do tren annibale (21/11): GMS da duoc mien tru hoan toan (gms_control=false,
# bgControl=noRestrict, cgroup.freeze=0, doze 3 muc) nhung Telegram/nekogram
# VAN cham. Nguyen nhan la Greezer, khong phai GMS:
#
#     cmd greezer ls
#       -> Frozen pids: [16411, 18030]
#       -> /proc/18030/cmdline = tw.nekomimi.nekogram
#     cmd greezer history
#       -> th: launch_mode   (115 lan trong 1 phien)
#
# Greezer giam process khi app xuong nen, nen thong bao bi giu lai den lan mo
# app ke tiep. Mien tru doze/AppOps khong cham toi no - hai co che khac nhau.
#
# Do duoc cach xu ly:
#   setprop persist.sys.gz.enable false        -> tat Greezer
#   setprop persist.sys.powmillet.enable false -> tat cong tac chinh
#   cmd greezer thaw                           -> tha moi process dang bi giam
# Sau do 2 phut theo doi: nekogram khong bi giam lai.
#
# Luu y: `cmd greezer enable false` chi tat launch-freeze trong phien, khong
# ghi prop, nen boot sau lai bat. Phai dung setprop.
GZ_OFF=$(conf_get greezer_off)
if [ "$GZ_OFF" != "0" ] && [ "$GZ_OFF" != "false" ]; then
    if cmd greezer ls >/dev/null 2>&1; then
        setprop persist.sys.gz.enable false
        setprop persist.sys.powmillet.enable false
        # Tha ngay, khong doi app nao bi giam san tu truoc.
        cmd greezer thaw >/dev/null 2>&1
        frozen=$(cmd greezer ls 2>/dev/null | sed -n 's/^Frozen pids: //p')
        say "Greezer: da tat (gz.enable=false, powmillet=false), thaw -> frozen=${frozen:-?}"
    else
        say "Greezer: khong co lenh cmd greezer - bo qua"
    fi
else
    say "Greezer: greezer_off=0 - giu nguyen"
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
