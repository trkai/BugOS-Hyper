#!/bin/bash
# ---------------------------------------------------------------------------
# Dat script FCM fix + init service + file cau hinh vao system image.
#
# Nguyen li lay tu module HyperOS_FCM_OnTheFly_Fix v1.4. Xem config.env.
# ---------------------------------------------------------------------------
work_dir=$(pwd)
source "$work_dir/functions.sh"

enabled=$(grep -m1 '^fcm_fix=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$enabled" != "true" ]; then
    debug "FCMFix: fcm_fix != true - bỏ qua"
    exit 0
fi

SYS="$work_dir/build/baserom/images/system/system"
SRC="$work_dir/bin/package/FCMFIX"

if [ ! -d "$SYS/bin" ]; then
    warn "FCMFix: không thấy $SYS/bin - bỏ qua"
    exit 0
fi

install -m 0755 "$SRC/fcm-fix.sh" "$SYS/bin/bugos-fcm.sh" \
    || { error "FCMFix: không chép được script"; exit 1; }

mkdir -p "$SYS/etc/init"
install -m 0644 "$SRC/fcm-fix.rc" "$SYS/etc/init/bugos-fcm.rc" \
    || { error "FCMFix: không chép được init service"; exit 1; }

# ---------------------------------------------------------------------------
# Tat Greezer ngay trong build.prop (khong chi luc chay).
#
# Greezer/powmillet la co che cua MIUI giam process app khi xuong nen. No pha
# vo quy tac "co quyen thong bao thi co thong bao": dumpsys cho thay app co
# notification record day du nhung process van bi giam (Frozen pids), nen thong
# bao den muon 5-15 phut.
#
# Do tren annibale 21/11:
#   /product/etc/build.prop dong 175: persist.sys.powmillet.enable=true
#   cmd greezer ls -> enable=true (persist.sys.powmillet.enable)
#                                 (persist.sys.gz.enable)
#
# Vi sao sua build.prop chu khong chi setprop luc chay:
#   - build.prop duoc doc truoc khi GreezeManagerService khoi tao, nen no tat
#     ngay tu dau, khong co khoang thoi gian app bi giam trong luc boot.
#   - persist.sys.* ghi de len gia tri build.prop, nen ai da doi bang tay thi
#     van con gia tri cu; script luc chay (fcm-fix.sh) xu ly not truong hop do.
#
# `ro.millet.netlink` KHONG dong: chi la so hieu netlink, khong bat/tat gi.
GREEZER_OFF=$(grep -m1 '^fcm_fix_greezer_off=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
case "$GREEZER_OFF" in
    true|1|"") GREEZER_OFF=1 ;;
    *) GREEZER_OFF=0 ;;
esac
if [ "$GREEZER_OFF" = "1" ]; then
    PBP="$work_dir/build/baserom/images/product/etc/build.prop"
    if [ -f "$PBP" ]; then
        if grep -q '^persist\.sys\.powmillet\.enable=' "$PBP"; then
            sed -i -E 's|^persist\.sys\.powmillet\.enable=.*|persist.sys.powmillet.enable=false|' "$PBP"
        else
            echo "persist.sys.powmillet.enable=false" >> "$PBP"
        fi
        # gz.enable khong co san trong build.prop cua ROM nay - them vao de
        # GreezeManagerService doc duoc ngay tu dau.
        if grep -q '^persist\.sys\.gz\.enable=' "$PBP"; then
            sed -i -E 's|^persist\.sys\.gz\.enable=.*|persist.sys.gz.enable=false|' "$PBP"
        else
            echo "persist.sys.gz.enable=false" >> "$PBP"
        fi
        mods "FCMFix: Greezer tắt trong build.prop (powmillet + gz = false)"
    else
        warn "FCMFix: không thấy $PBP - Greezer chỉ được tắt lúc chạy"
    fi
else
    debug "FCMFix: fcm_fix_greezer_off=0 - giữ Greezer bật"
fi

# Cau hinh luc chay: chi 2 tuy chon nay thay doi theo y nguoi dung.
# Phan GMS/PowerKeeper/GCM luon chay - do la loi cua ROM China, khong phai
# tuy chon.
wake=$(grep -m1 '^fcm_fix_wake_screen=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
content=$(grep -m1 '^fcm_fix_lockscreen_content=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
greezer_off=$(grep -m1 '^fcm_fix_greezer_off=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
case "$greezer_off" in true|1|"") greezer_off=1 ;; *) greezer_off=0 ;; esac
keep_apps=$(grep -m1 '^fcm_fix_keep_apps=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2- | tr -d ' \r\n')
# case thay cho `[ ] && ...`: chuoi && cuoi cung tra ma khac 0 se lam chet
# script khi functions.sh bat set -e.
case "$wake" in true|1) wake=1 ;; *) wake=0 ;; esac
case "$content" in true|1) content=1 ;; *) content=0 ;; esac

{
    echo "# BugOS FCM fix - cau hinh luc chay."
    echo "# wake_screen=1: bat man hinh khi co thong bao."
    echo "# lockscreen_content=1: hien day du noi dung tren man hinh khoa (rieng tu)."
    echo "# greezer_off=1: tat Greezer (giam process khi app xuong nen)."
    echo "#   0 = giu nguyen. Xem fcm-fix.sh phan 2b: do tren annibale, Greezer la"
    echo "#   thu pham rieng, khong lien quan GMS; mien tru doze khong cham toi no."
    echo "# keep_apps: package cach nhau bang dau phay, duoc dat bgControl=noRestrict"
    echo "#   -> Greezer KHONG giam khi app xuong nen. Quyen thong bao KHONG du."
    echo "wake_screen=$wake"
    echo "lockscreen_content=$content"
    echo "greezer_off=${greezer_off:-1}"
    echo "fcm_fix_keep_apps=$keep_apps"
} > "$SYS/etc/bugos-fcm.conf"
chmod 0644 "$SYS/etc/bugos-fcm.conf"

# Tu kiem
[ -x "$SYS/bin/bugos-fcm.sh" ] || { error "FCMFix: script không có quyền chạy"; exit 1; }
[ -f "$SYS/etc/init/bugos-fcm.rc" ] || { error "FCMFix: thiếu file .rc"; exit 1; }
[ -f "$SYS/etc/bugos-fcm.conf" ] || { error "FCMFix: thiếu file cấu hình"; exit 1; }

mods "FCMFix: script + service đã vào /system (GMS/Doze/PowerKeeper/GCM, wake=$wake content=$content)"
