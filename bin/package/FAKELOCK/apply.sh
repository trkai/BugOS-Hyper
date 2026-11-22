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
# packROM.sh goi: python3 fspatch.py $IMG_DIR/system $IMG_DIR/config/system_fs_config
IMG_CONFIG="$work_dir/build/baserom/images/config/system_fs_config"

if [ ! -d "$SYS/bin" ]; then
    warn "FakeLock: không thấy $SYS/bin - bỏ qua"
    exit 0
fi

install -m 0755 "$SRC/bugos-fakelock.sh" "$SYS/bin/bugos-fakelock.sh" \
    || { error "FakeLock: không chép được script"; exit 1; }

mkdir -p "$SYS/etc/init"
install -m 0644 "$SRC/bugos-fakelock.rc" "$SYS/etc/init/bugos-fakelock.rc" \
    || { error "FakeLock: không chép được init service"; exit 1; }

# fspatch.py dong 0750 cho MOI file .sh duoi /bin (quy uoc ROM goc) nen
# `install -m 0755` bi nuot o buoc mkfs -> tren may do duoc
#   -rwxr-x--- 1 0 2000 /system/bin/bugos-fakelock.sh
# Ghi entry fs_config de giu 0755 va gid 2000 cho khop ROM goc.
python3 - "$IMG_CONFIG" <<'PYEOF'
import sys, os
p = sys.argv[1]
rows = {
    "system/bin/bugos-fakelock.sh": "system/bin/bugos-fakelock.sh 0 2000 0755",
    "system/etc/init/bugos-fakelock.rc": "system/etc/init/bugos-fakelock.rc 0 0 0644",
}
out, seen = [], set()
if os.path.exists(p):
    with open(p, encoding="utf-8", errors="replace") as f:
        for line in f.read().splitlines():
            if not line.strip():
                continue
            key = line.split(" ")[0]
            if key in rows:
                if key in seen:
                    continue
                out.append(rows[key]); seen.add(key)
            else:
                out.append(line.rstrip())
for k, v in rows.items():
    if k not in seen:
        out.append(v)
tmp = p + ".bugos_tmp"
with open(tmp, "w", encoding="utf-8", newline="\n") as f:
    f.write("\n".join(out) + "\n")
os.replace(tmp, p)
PYEOF
mods "FakeLock: fs_config -> script /system/bin 0755 (gid 2000), rc 0644"

# Tu kiem: ca hai file phai nam dung cho va dung quyen.
[ -x "$SYS/bin/bugos-fakelock.sh" ] || { error "FakeLock: script không có quyền chạy"; exit 1; }
[ -f "$SYS/etc/init/bugos-fakelock.rc" ] || { error "FakeLock: thiếu file .rc"; exit 1; }

mods "FakeLock: script + init service đã vào /system (property + /proc/bootconfig)"
