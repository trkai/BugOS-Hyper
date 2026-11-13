#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
# ---------------------------------------------------------------------------
# AppSpoof - đóng cấu hình mặc định vào /system/etc/bugos/app-spoof.json.
#
# File này là danh sách profile (package -> Build props) mà framework hook
# com.bugos.spoof.AppSpoof đọc khi Settings.Global chưa có gì. Toolbox có thể
# ghi đè runtime bằng Settings.Global "bugos_app_spoof" (base64 JSON).
#
# Bản thân việc patch framework.jar nằm trong apply_app_spoof():
#   - a17: hàm inline trong jar_patcher_a17.sh
#   - a15/a16: source từ bin/package/AppSpoof/apply.sh
# Không nằm ở file này.
# ---------------------------------------------------------------------------

work_dir=$(pwd)
source "$work_dir/functions.sh"

ENABLE=$(grep -m1 '^app_spoof=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$ENABLE" = "false" ]; then
    mods "AppSpoof: bỏ qua (app_spoof=false)"
    exit 0
fi

SRC="$work_dir/bin/package/AppSpoof/app-spoof.json"
IMG="$work_dir/build/baserom/images"

if [ ! -f "$SRC" ]; then
    warn "AppSpoof: chưa có $SRC - bỏ qua"
    exit 0
fi

# Layout system.img khác nhau giữa các bản: có bản root ảnh là "system/..."
# (images/system/system), có bản root ảnh là "/" (images/system). Dò cả hai.
SYS="$IMG/system/system"
[ -d "$SYS/etc" ] || SYS="$IMG/system"
if [ ! -d "$SYS" ]; then
    warn "AppSpoof: không thấy phân vùng system đã giải nén - bỏ qua"
    exit 0
fi

DEST="$SYS/etc/bugos"
mkdir -p "$DEST" || { warn "AppSpoof: tạo $DEST thất bại"; exit 0; }

cp -f "$SRC" "$DEST/app-spoof.json" || { warn "AppSpoof: copy json thất bại"; exit 0; }
chmod 0644 "$DEST/app-spoof.json"

REL="${SYS#$IMG/}"
FS_CFG="$IMG/config/system_fs_config"
if [ -f "$FS_CFG" ]; then
    {
        echo "$REL/etc/bugos 0 0 0755"
        echo "$REL/etc/bugos/app-spoof.json 0 0 0644"
    } >> "$FS_CFG"
fi

mods "AppSpoof: /$REL/etc/bugos/app-spoof.json ($(python3 -c "import json,sys;print(len(json.load(open(sys.argv[1]))))" "$SRC" 2>/dev/null || echo '?') profile)"
exit 0
