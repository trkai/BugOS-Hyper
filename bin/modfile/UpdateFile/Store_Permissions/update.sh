#!/bin/bash
# ---------------------------------------------------------------------------
# Cấp quyền cài đặt cho kho ứng dụng Xiaomi.
#
# VÌ SAO CẦN (đo trên máy, không đoán):
#   GetApps tải bản cập nhật xong, tạo session, commit - rồi thất bại:
#     Market-SessionInstallReceiver: session receive com.miui.personalassistant
#       failed with [status=-1,message=null]
#     Market-PackageInstallObserver: install ... with returnCode=-10000
#   dumpsys package com.xiaomi.market cho thấy android.permission.INSTALL_PACKAGES
#   nằm trong "requested permissions" nhưng KHÔNG có trong "install permissions".
#   Cùng lúc `adb install` (shell có INSTALL_PACKAGES) cài đúng APK đó thành công,
#   nên đường cài của ROM không hỏng - chỉ thiếu quyền cho caller.
#
#   INSTALL_PACKAGES là quyền privileged: chỉ app nằm trong priv-app + có tên
#   trong một file privapp-permissions*.xml mới được cấp. Không file nào trong
#   ROM nhắc tới com.xiaomi.market (đã grep cả system/ system_ext/ product/
#   etc/permissions trên máy), nên dù kho có nằm trong priv-app thì vẫn bị từ
#   chối. Đó là lý do phải tự viết file whitelist.
#
# Mod này làm hai việc, chỉ khi keep_getapps != false:
#   1. nếu thư mục kho nằm trong app/ thì chuyển sang priv-app/ cùng cấp
#      (app thường không phải privileged -> không bao giờ được cấp quyền)
#   2. ghi privapp-permissions cho kho vào product/etc/permissions
#
# Không sửa APPLIST, không xoá gì.
# ---------------------------------------------------------------------------
work_dir=$(pwd)
source "$work_dir/functions.sh"

MAIN_FOLDER="$work_dir/build/baserom/images"

KEEP_GETAPPS=$(grep -m1 '^keep_getapps=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d '\r\n ')
[ "$KEEP_GETAPPS" = "false" ] && exit 0
[ -d "$MAIN_FOLDER" ] || exit 0

# Tên thư mục -> package. Tên thư mục khác nhau giữa các bản ROM nên liệt kê cả.
store_dirs="MIUISuperMarket MiuiSuperMarket MIUIMiPicks"
store_pkgs="com.xiaomi.market com.xiaomi.mipicks"

# --- 1. bảo đảm kho nằm trong priv-app -------------------------------------
for name in $store_dirs; do
    hit=$(find "$MAIN_FOLDER/system" "$MAIN_FOLDER/product" "$MAIN_FOLDER/system_ext" \
               -maxdepth 3 -type d -name "$name" 2>/dev/null | head -n 1)
    [ -n "$hit" ] || continue

    parent=$(basename "$(dirname "$hit")")
    if [ "$parent" = "app" ]; then
        dest="$(dirname "$(dirname "$hit")")/priv-app"
        mkdir -p "$dest"
        mv "$hit" "$dest/"
        mods "StorePermissions: $name từ app/ -> priv-app/ (cần privileged mới có INSTALL_PACKAGES)"
    else
        mods "StorePermissions: $name đã ở $parent/"
    fi
done

# --- 2. whitelist quyền privileged ----------------------------------------
PERM_DIR="$MAIN_FOLDER/product/etc/permissions"
mkdir -p "$PERM_DIR"

{
    echo '<?xml version="1.0" encoding="utf-8"?>'
    echo '<!-- BugOS: quyền cài đặt cho kho ứng dụng, xem bin/modfile/UpdateFile/Store_Permissions -->'
    echo '<permissions>'
    for pkg in $store_pkgs; do
        cat <<XML
    <privapp-permissions package="$pkg">
        <permission name="android.permission.INSTALL_PACKAGES"/>
        <permission name="android.permission.DELETE_PACKAGES"/>
        <permission name="android.permission.CLEAR_APP_USER_DATA"/>
        <permission name="android.permission.CHANGE_COMPONENT_ENABLED_STATE"/>
    </privapp-permissions>
XML
    done
    echo '</permissions>'
} > "$PERM_DIR/privapp-permissions-bugos-store.xml"

if [ -s "$PERM_DIR/privapp-permissions-bugos-store.xml" ]; then
    mods "StorePermissions: ghi product/etc/permissions/privapp-permissions-bugos-store.xml"
else
    warn "StorePermissions: ghi file whitelist thất bại"
fi
