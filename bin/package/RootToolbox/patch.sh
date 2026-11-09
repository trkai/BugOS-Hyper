#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
# ---------------------------------------------------------------------------
# Root Toolbox - Đã tích hợp trực tiếp vào Settings -> Mod (Settings.apk).
#
# Không cài đặt app độc lập vào product/app/RootToolbox để tránh trùng lặp.
# Asset (sukisu_ultra.apk, ZygiskNext+AlwaysStrongInject.zip) được trích xuất
# thẳng vào Settings.apk bởi Settings_ROMInformation/patch_settings_mod.py.
# ---------------------------------------------------------------------------

work_dir=$(pwd)
source "$work_dir/functions.sh"

ENABLE=$(grep -m1 '^bugos_toolbox=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$ENABLE" = "false" ]; then
    mods "Toolbox: bỏ qua (bugos_toolbox=false)"
    exit 0
fi

IMG="$work_dir/build/baserom/images"
APP_DIR="$IMG/product/app/RootToolbox"

# Dọn sạch app độc lập nếu có để tránh trùng lặp trên launcher
if [ -d "$APP_DIR" ]; then
    rm -rf "$APP_DIR"
fi

mods "Toolbox: đã tích hợp vào Cài đặt -> Mod (Settings.apk), bỏ app độc lập"
exit 0
