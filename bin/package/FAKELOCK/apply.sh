#!/bin/bash
# ---------------------------------------------------------------------------
# Dat script + init service fake lock vao system image.
#
# Co che: goi `ksud resetprop -n` cua SukiSU de ghi thang vung property, nen
# getprop / JNI / vendor HAL deu thay green - khong chi app Java nhu
# boot_state_spoof. Kem che /proc/bootconfig (bind-mount ban da sua).
#
# Da thu tren annibale: getprop ro.boot.verifiedbootstate doi orange -> green
# ngay khi chay, va bind-mount /proc/bootconfig thay duoc tu ca shell khong root.
#
# Vi sao khong vá boot.img/vendor_boot.img: bootloader tu noi
# androidboot.verifiedbootstate vao bootconfig SAU phan cua ROM, nen moi gia
# tri dat trong anh deu bi no ghi de. Xem config.env.
# ---------------------------------------------------------------------------
work_dir=$(pwd)
source "$work_dir/functions.sh"

enabled=$(grep -m1 '^boot_state_spoof_fakelock=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$enabled" != "true" ]; then
    debug "FakeLock: boot_state_spoof_fakelock != true - bỏ qua"
    exit 0
fi

SYS="$work_dir/build/baserom/images/system/system"
SRC="$work_dir/bin/package/FAKELOCK"

if [ ! -d "$SYS/bin" ]; then
    warn "FakeLock: không thấy $SYS/bin - bỏ qua"
    exit 0
fi

install -m 0755 "$SRC/bugos-fakelock.sh" "$SYS/bin/bugos-fakelock.sh" \
    || { error "FakeLock: không chép được script"; exit 1; }

mkdir -p "$SYS/etc/init"
install -m 0644 "$SRC/bugos-fakelock.rc" "$SYS/etc/init/bugos-fakelock.rc" \
    || { error "FakeLock: không chép được init service"; exit 1; }

# Tu kiem: ca hai file phai nam dung cho va dung quyen.
[ -x "$SYS/bin/bugos-fakelock.sh" ] || { error "FakeLock: script không có quyền chạy"; exit 1; }
[ -f "$SYS/etc/init/bugos-fakelock.rc" ] || { error "FakeLock: thiếu file .rc"; exit 1; }

mods "FakeLock: script + init service đã vào /system (property + /proc/bootconfig)"
