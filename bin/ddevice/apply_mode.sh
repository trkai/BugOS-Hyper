#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
# ---------------------------------------------------------------------------
# apply_mode.sh - chuẩn hoá config.env theo "toolbox_mode" TRƯỚC khi build.
#
#   root    : ROM có root (sukisu=true) + BugOS Toolbox (product/app/RootToolbox)
#   kaorios : ROM KHÔNG root (sukisu=false) + Kaorios Toolbox
#             (product/app/KaoriosToolbox), Settings trỏ com.kousei.kaorios.
#
# Vì sao phải ghi lại vào config.env thay vì export biến môi trường: các script
# patch (bin/package/*/patch.sh, patch_settings_mod.py) đều đọc config.env trực
# tiếp bằng grep, không đọc env. Ghi vào file là cách duy nhất mọi bước thấy
# cùng một giá trị, và log build cũng cho biết mode đang chạy.
# ---------------------------------------------------------------------------

work_dir=$(pwd)
CFG="$work_dir/config.env"

[ -f "$CFG" ] || { echo "[mode] không thấy config.env - bỏ qua"; exit 0; }

mode=$(grep -m1 '^toolbox_mode=' "$CFG" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
case "$mode" in
    kaorios) ;;
    root|"") mode=root ;;
    *)
        echo "[mode] toolbox_mode='$mode' không hợp lệ -> dùng root"
        mode=root
        ;;
esac

set_key() {
    local key="$1" val="$2"
    if grep -q "^${key}=" "$CFG"; then
        sed -i "s|^${key}=.*|${key}=${val}|" "$CFG"
    else
        printf '%s=%s\n' "$key" "$val" >> "$CFG"
    fi
}

if [ "$mode" = "kaorios" ]; then
    set_key sukisu false
    set_key bugos_toolbox false
    set_key kaorios_toolbox true
    set_key toolbox_target_package com.kousei.kaorios
    set_key toolbox_target_class com.kousei.kaorios.MainActivity
else
    set_key sukisu true
    set_key bugos_toolbox true
    set_key kaorios_toolbox false
    set_key toolbox_target_package com.khai.roottoolbox
    set_key toolbox_target_class com.khai.roottoolbox.MainActivity
fi

echo "[mode] toolbox_mode=$mode"
echo "[mode]   sukisu=$(grep -m1 '^sukisu=' "$CFG" | cut -d= -f2)"
echo "[mode]   bugos_toolbox=$(grep -m1 '^bugos_toolbox=' "$CFG" | cut -d= -f2)"
echo "[mode]   kaorios_toolbox=$(grep -m1 '^kaorios_toolbox=' "$CFG" | cut -d= -f2)"
echo "[mode]   Settings -> $(grep -m1 '^toolbox_target_package=' "$CFG" | cut -d= -f2)/$(grep -m1 '^toolbox_target_class=' "$CFG" | cut -d= -f2)"
