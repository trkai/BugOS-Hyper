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

# Cau hinh luc chay: chi 2 tuy chon nay thay doi theo y nguoi dung.
# Phan GMS/PowerKeeper/GCM luon chay - do la loi cua ROM China, khong phai
# tuy chon.
wake=$(grep -m1 '^fcm_fix_wake_screen=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
content=$(grep -m1 '^fcm_fix_lockscreen_content=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
# case thay cho `[ ] && ...`: chuoi && cuoi cung tra ma khac 0 se lam chet
# script khi functions.sh bat set -e.
case "$wake" in true|1) wake=1 ;; *) wake=0 ;; esac
case "$content" in true|1) content=1 ;; *) content=0 ;; esac

{
    echo "# BugOS FCM fix - cau hinh luc chay."
    echo "# wake_screen=1: bat man hinh khi co thong bao."
    echo "# lockscreen_content=1: hien day du noi dung tren man hinh khoa (rieng tu)."
    echo "wake_screen=$wake"
    echo "lockscreen_content=$content"
} > "$SYS/etc/bugos-fcm.conf"
chmod 0644 "$SYS/etc/bugos-fcm.conf"

# Tu kiem
[ -x "$SYS/bin/bugos-fcm.sh" ] || { error "FCMFix: script không có quyền chạy"; exit 1; }
[ -f "$SYS/etc/init/bugos-fcm.rc" ] || { error "FCMFix: thiếu file .rc"; exit 1; }
[ -f "$SYS/etc/bugos-fcm.conf" ] || { error "FCMFix: thiếu file cấu hình"; exit 1; }

mods "FCMFix: script + service đã vào /system (GMS/Doze/PowerKeeper/GCM, wake=$wake content=$content)"
