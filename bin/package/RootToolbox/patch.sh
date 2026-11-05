#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
# ---------------------------------------------------------------------------
# Root Toolbox - app do user tự làm (com.khai.roottoolbox), đóng gói vào ROM.
#
# App tự chứa mọi thứ, ROM chỉ cần đặt đúng chỗ:
#   assets/sukisu_ultra.apk                  -> bản manager dùng cho nút "Cài"
#   assets/ZygiskNext+AlwaysStrongInject.zip -> module dùng cho nút "Flash"
#   FileProvider com.khai.roottoolbox.fileprovider -> cấp module cho SukiSU
#
# Luồng trong app:
#   1. Cài SukiSU: chép asset ra file, rồi chạy
#        su -c "cp <apk> /data/local/tmp/sukisu.apk && pm install -r -d ... && rm -f ..."
#      Có su (đã root) thì cài ngầm; chưa có su thì rơi về installer hệ thống
#      (một lần bấm xác nhận). Đó là giới hạn của app, không phải của ROM.
#   2. Flash module: ACTION_VIEW + application/zip + content:// -> SukiSU mở
#      thẳng màn hình cài module (đúng intent-filter nó khai báo).
#
# Không cần privapp-permissions: app không xin quyền privileged nào, chỉ
# REQUEST_INSTALL_PACKAGES (normal) + quyền storage kiểu cũ.
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

# fspatch.py mặc định 0644 cho file mới / 0755 cho thư mục, đúng ý. Ghi rõ để
# không phụ thuộc hành vi mặc định (đã từng bị ép 0750 với file .sh dưới /bin).
FS_CFG="$IMG/config/product_fs_config"
if [ -f "$FS_CFG" ]; then
    {
        echo "product/app/RootToolbox 0 0 0755"
        echo "product/app/RootToolbox/RootToolbox.apk 0 0 0644"
    } >> "$FS_CFG"
fi

mods "Toolbox: product/app/RootToolbox ($(stat -c%s "$SRC") byte) - com.khai.roottoolbox"
exit 0
