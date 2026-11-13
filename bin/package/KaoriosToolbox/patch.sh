#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
# ---------------------------------------------------------------------------
# Kaorios Toolbox - đặt APK vào product/app/KaoriosToolbox.
#
# Chỉ chạy khi toolbox_mode=kaorios: bin/ddevice/apply_mode.sh đặt
# kaorios_toolbox=true và tắt bugos_toolbox/sukisu.
#
# Khác RootToolbox: đây là APK có sẵn của Kaorios (không sửa, không ký lại),
# nên giữ nguyên chữ ký gốc của họ. Vì là app hệ thống thường (không phải
# priv-app) và ROM không root, các tính năng cần ghi /data/adb sẽ không hoạt
# động - app chỉ dùng được phần đọc trạng thái/framework hook có sẵn.
#
# Mục Cài đặt -> Toolbox trỏ tới com.kousei.kaorios.MainActivity, do
# patch_settings_mod.py đọc toolbox_target_package|class từ config.env.
# ---------------------------------------------------------------------------

work_dir=$(pwd)
source "$work_dir/functions.sh"

ENABLE=$(grep -m1 '^kaorios_toolbox=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$ENABLE" != "true" ]; then
    mods "KaoriosToolbox: bỏ qua (kaorios_toolbox=$ENABLE)"
    exit 0
fi

SRC="$work_dir/bin/package/KaoriosToolbox/KaoriosToolbox.apk"
IMG="$work_dir/build/baserom/images"

if [ ! -f "$SRC" ]; then
    warn "KaoriosToolbox: chưa có $SRC - bỏ qua"
    exit 0
fi

if [ ! -d "$IMG/product" ]; then
    warn "KaoriosToolbox: không thấy product/ - bỏ qua"
    exit 0
fi

APP_DIR="$IMG/product/app/KaoriosToolbox"
mkdir -p "$APP_DIR" || { warn "KaoriosToolbox: tạo thư mục thất bại"; exit 0; }

cp -f "$SRC" "$APP_DIR/KaoriosToolbox.apk" || { warn "KaoriosToolbox: copy APK thất bại"; exit 0; }
chmod 0644 "$APP_DIR/KaoriosToolbox.apk"

FS_CFG="$IMG/config/product_fs_config"
if [ -f "$FS_CFG" ]; then
    {
        echo "product/app/KaoriosToolbox 0 0 0755"
        echo "product/app/KaoriosToolbox/KaoriosToolbox.apk 0 0 0644"
    } >> "$FS_CFG"
fi

mods "KaoriosToolbox: cài đặt -> product/app/KaoriosToolbox ($(stat -c%s "$SRC") byte)"
exit 0
