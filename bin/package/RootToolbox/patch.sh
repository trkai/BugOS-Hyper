#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
# ---------------------------------------------------------------------------
# Root Toolbox - Package hệ thống nội bộ cung cấp giao diện cho Settings -> Toolbox.
#
# Đã gỡ bỏ category.LAUNCHER trong AndroidManifest.xml:
#   - Không hiển thị biểu tượng nào ngoài màn hình chính (tránh trùng lặp).
#   - Chỉ mở được thông qua Cài đặt -> Toolbox (settings_headers.xml).
#   - Tự chứa SukiSU manager (assets/sukisu_ultra.apk) và module
#     (assets/ZygiskNext+AlwaysStrongInject.zip).
# ---------------------------------------------------------------------------

work_dir=$(pwd)
source "$work_dir/functions.sh"

ENABLE=$(grep -m1 '^bugos_toolbox=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$ENABLE" = "false" ]; then
    mods "Toolbox: bỏ qua (bugos_toolbox=false)"
    exit 0
fi

SRC="$work_dir/bin/package/RootToolbox/RootToolbox.apk"
IMG="$work_dir/build/baserom/images"

if [ ! -f "$SRC" ]; then
    warn "Toolbox: chưa có $SRC - bỏ qua"
    exit 0
fi

if [ ! -d "$IMG/product" ]; then
    warn "Toolbox: không thấy product/ - bỏ qua"
    exit 0
fi

APP_DIR="$IMG/product/app/RootToolbox"
mkdir -p "$APP_DIR" || { warn "Toolbox: tạo thư mục thất bại"; exit 0; }

cp -f "$SRC" "$APP_DIR/RootToolbox.apk" || { warn "Toolbox: copy APK thất bại"; exit 0; }
chmod 0644 "$APP_DIR/RootToolbox.apk"

FS_CFG="$IMG/config/product_fs_config"
if [ -f "$FS_CFG" ]; then
    {
        echo "product/app/RootToolbox 0 0 0755"
        echo "product/app/RootToolbox/RootToolbox.apk 0 0 0644"
    } >> "$FS_CFG"
fi

mods "Toolbox: cài đặt internal package -> product/app/RootToolbox ($(stat -c%s "$SRC") byte, không icon launcher)"
exit 0
