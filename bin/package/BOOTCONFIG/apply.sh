#!/bin/bash
# ---------------------------------------------------------------------------
# Gia verified-boot state o dung tang nguon: bootconfig trong boot.img.
#
# Chay SAU SukiSU (boot.img da duoc ksud vá) va TRUOC DISABLE_AVB.
# Mac dinh TAT: bat bang boot_state_spoof_bootconfig=true trong config.env.
# Tool chi ghi khi doc duoc block va checksum goc hop le, nen bat len khong
# lam hong boot.img tren mot layout la.
# ---------------------------------------------------------------------------
work_dir=$(pwd)
source "$work_dir/functions.sh"

enabled=$(grep -m1 '^boot_state_spoof_bootconfig=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$enabled" != "true" ]; then
    debug "BootConfig: boot_state_spoof_bootconfig != true - bỏ qua"
    exit 0
fi

TOOL="$work_dir/bin/package/BOOTCONFIG/bootconfig_patch.py"
BOOT="$work_dir/build/baserom/images/boot.img"

if [ ! -f "$BOOT" ]; then
    warn "BootConfig: không thấy boot.img - bỏ qua"
    exit 0
fi

# --check trước: nếu tool không hiểu layout thì dừng, không đụng file.
out=$(python3 "$TOOL" "$BOOT" 2>&1)
rc=$?
if [ "$rc" -ne 0 ]; then
    warn "BootConfig: không vá được - giữ nguyên boot.img"
    printf '%s\n' "$out" | while IFS= read -r line; do warn "  $line"; done
    exit 0
fi
printf '%s\n' "$out" | while IFS= read -r line; do debug "  $line"; done

out=$(python3 "$TOOL" "$BOOT" --apply 2>&1)
rc=$?
if [ "$rc" -ne 0 ]; then
    error "BootConfig: ghi thất bại (mã $rc) - kiểm tra $BOOT.bootconfig.bak"
    printf '%s\n' "$out" | while IFS= read -r line; do error "  $line"; done
    exit 1
fi

mods "BootConfig: verifiedbootstate=green, flash.locked=1, vbmeta.device_state=locked"
rm -f "$BOOT.bootconfig.bak"
