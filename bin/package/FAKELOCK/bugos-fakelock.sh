#!/system/bin/sh
# ---------------------------------------------------------------------------
# BugOS fakelock - gia verified-boot state o tang property.
#
# Chay tu /system/etc/init/bugos-fakelock.rc sau khi boot xong.
#
# VI SAO TANG PROPERTY, KHONG PHAI BOOT.IMG:
#   Da do tren annibale (BugOS 1.1 / OS4.0.6.0.XPKCNXM):
#     - boot.img khong chua bootconfig nao (chi la padding + AVB footer).
#     - verifiedbootstate / vbmeta.device_state nam trong section bootconfig
#       cua vendor_boot.img, nhung bootloader tu noi ban cua no vao SAU khi
#       boot, nen vá anh khong thang (da thu: /proc/cmdline green, getprop
#       van orange).
#     - `ksud resetprop -n` ghi thang vung property -> getprop, JNI,
#       __system_property_get, vendor HAL deu thay gia tri moi. Da thu: OK.
#   /proc/bootconfig van noi that nen phai che rieng (bind-mount ban da sua).
#
# KHONG dat ro.boot.vbmeta.digest: may unlocked co TEE tra verifiedBootHash
# khac, ep prop sang gia tri khac tao mismatch -> bi bat de hon la de nguyen.
# ---------------------------------------------------------------------------
LOG_TAG=bugos-fakelock
say() { echo "$LOG_TAG: $*" > /dev/kmsg 2>/dev/null; }

# SukiSU dat ksud o /data/adb, co the chua co o lan boot dau. Cho toi 90s roi
# bo qua - khong duoc treo boot vi mot prop.
KS=/data/adb/ksud
i=0
while [ ! -x "$KS" ] && [ "$i" -lt 90 ]; do
    sleep 1
    i=$((i + 1))
done
if [ ! -x "$KS" ]; then
    say "khong thay $KS sau ${i}s - bo qua"
    exit 0
fi

ok=0
total=0
for kv in \
    "ro.boot.verifiedbootstate green" \
    "ro.boot.vbmeta.device_state locked" \
    "ro.boot.flash.locked 1" \
    "ro.secureboot.lockstate locked" \
    "vendor.boot.verifiedbootstate green" \
    "vendor.boot.vbmeta.device_state locked"
do
    total=$((total + 1))
    set -- $kv
    "$KS" resetprop -n "$1" "$2" 2>/dev/null && ok=$((ok + 1))
done
say "resetprop $ok/$total prop"

# --- che /proc/bootconfig -------------------------------------------------
# Giu nguyen moi dong khac (serialno, hardware, slot_suffix...) va chi thay
# dong trang thai, de khong pha thu gi dang doc file nay.
BC=/data/local/tmp/.bugos_bootconfig
if [ -r /proc/bootconfig ] && cp /proc/bootconfig "$BC" 2>/dev/null; then
    sed -i \
        -e 's|^androidboot\.verifiedbootstate.*|androidboot.verifiedbootstate = "green"|' \
        -e 's|^androidboot\.vbmeta\.device_state.*|androidboot.vbmeta.device_state = "locked"|' \
        -e 's|^androidboot\.flash\.locked.*|androidboot.flash.locked = "1"|' \
        "$BC"
    if mount --bind "$BC" /proc/bootconfig 2>/dev/null; then
        say "da che /proc/bootconfig"
    else
        say "bind mount /proc/bootconfig that bai"
    fi
fi
exit 0
