#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
# ---------------------------------------------------------------------------
# BugOS Toolbox - app hệ thống 2 nút:
#   1. cài SukiSU Ultra manager vào /data/app (im lặng, nhờ INSTALL_PACKAGES)
#   2. mở màn hình flash module của SukiSU với module đóng sẵn trong ROM
#
# VÌ SAO CẦN: kernel chỉ "crowning" manager khi thấy base.apk trong /data/app
# (kernel/manager/throne_tracker.c -> search_manager("/data/app", 2)). App hệ
# thống ở /product/app không bao giờ được quét tới, nên phải cài lại thành app
# dữ liệu. Trước đây việc này do một init service làm; cách đó phụ thuộc quyền
# file + SELinux của từng bản recovery/ROM. Nút bấm thì không phụ thuộc gì.
#
# App phải nằm trong product/priv-app và có tên trong privapp-permissions,
# nếu không PackageManager sẽ chặn INSTALL_PACKAGES và mỗi lần cài lại hiện hộp
# thoại xác nhận - mất ý nghĩa "cài ngầm".
#
# Bật/tắt bằng cờ bugos_toolbox trong config.env.
# ---------------------------------------------------------------------------

work_dir=$(pwd)
source "$work_dir/functions.sh"

ENABLE=$(grep -m1 '^bugos_toolbox=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$ENABLE" = "false" ]; then
    mods "Toolbox: bỏ qua (bugos_toolbox=false)"
    exit 0
fi

SRC_DIR="$work_dir/bin/package/BugOSToolbox"
APK="$SRC_DIR/BugOSToolbox.apk"
IMG="$work_dir/build/baserom/images"

if [ ! -f "$APK" ]; then
    warn "Toolbox: chưa có $APK - build bằng bin/package/BugOSToolbox/build_apk.sh"
    exit 0
fi

if [ ! -d "$IMG/product" ]; then
    warn "Toolbox: không thấy product/ - bỏ qua"
    exit 0
fi

APP_DIR="$IMG/product/priv-app/BugOSToolbox"
PERM_DIR="$IMG/product/etc/permissions"
PERM_FILE="$PERM_DIR/privapp-permissions-bugos-toolbox.xml"
MODULE_DIR="$IMG/product/etc/bugos/toolbox"
MODULE_SRC="$SRC_DIR/module.zip"
MODULE_DST="$MODULE_DIR/module.zip"

mkdir -p "$APP_DIR" "$PERM_DIR" "$MODULE_DIR" || { warn "Toolbox: tạo thư mục thất bại"; exit 0; }

cp -f "$APK" "$APP_DIR/BugOSToolbox.apk" || { warn "Toolbox: copy APK thất bại"; exit 0; }
chmod 0644 "$APP_DIR/BugOSToolbox.apk"

# Whitelist privileged permission. Thiếu file này, app giữ INSTALL_PACKAGES sẽ
# bị PackageManager tắt quyền (và trên một số ROM là crash lúc boot).
cat > "$PERM_FILE" << 'XMLEOF'
<?xml version="1.0" encoding="utf-8"?>
<!-- BugOS Toolbox: cần INSTALL_PACKAGES để cài SukiSU manager không hỏi. -->
<permissions>
    <privapp-permissions package="com.bugos.toolbox">
        <permission name="android.permission.INSTALL_PACKAGES" />
    </privapp-permissions>
</permissions>
XMLEOF
chmod 0644 "$PERM_FILE"

# Module đóng sẵn: chỉ copy khi có. Không có thì toolbox vẫn chạy, chỉ báo
# "chưa có module" ở nút 2 - không làm chết app.
if [ -f "$MODULE_SRC" ]; then
    cp -f "$MODULE_SRC" "$MODULE_DST" || warn "Toolbox: copy module.zip thất bại"
    chmod 0644 "$MODULE_DST"
    mods "Toolbox: module $(basename "$MODULE_SRC") ($(stat -c%s "$MODULE_DST") byte) -> product/etc/bugos/toolbox"
else
    warn "Toolbox: chưa có $MODULE_SRC - nút 2 sẽ báo thiếu module"
fi

# fspatch.py đóng 0644 cho file mới và 0755 cho thư mục, đúng như mong muốn,
# nhưng ghi rõ ở đây để không phụ thuộc hành vi mặc định của nó.
FS_CFG="$IMG/config/product_fs_config"
if [ -f "$FS_CFG" ]; then
    {
        echo "product/priv-app/BugOSToolbox 0 0 0755"
        echo "product/priv-app/BugOSToolbox/BugOSToolbox.apk 0 0 0644"
        echo "product/etc/permissions/privapp-permissions-bugos-toolbox.xml 0 0 0644"
        echo "product/etc/bugos 0 0 0755"
        echo "product/etc/bugos/toolbox 0 0 0755"
        [ -f "$MODULE_DST" ] && echo "product/etc/bugos/toolbox/module.zip 0 0 0644"
    } >> "$FS_CFG"
fi

mods "Toolbox: product/priv-app/BugOSToolbox ($(stat -c%s "$APK") byte) + privapp-permissions"
exit 0
