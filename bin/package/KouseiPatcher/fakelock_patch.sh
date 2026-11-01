#!/bin/bash
# SPDX-License-Identifier: GPL-3.0

work_dir=$(pwd)
magiskboot="$work_dir/bin/magiskboot"
prop="$work_dir/bin/package/KouseiPatcher/prop"
SEARCH_DIR="build/baserom/images"

# fake_lock=false -> KHÔNG giả trạng thái bootloader. Hai phần bị bỏ là (1) nhét
# cờ androidboot vào cmdline vendor_boot và (3) nối prop/build.prop
# (ro.boot.verifiedbootstate=green ...). Phần (4) whitelist cust.prop vẫn giữ:
# nó chỉ khai báo prop nào được đọc, không làm sai giá trị.
# Cờ này tách khỏi install_toolbox để vẫn cài được app KaoriosToolbox.
FAKE_LOCK=$(grep -m1 '^fake_lock=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
[ -z "$FAKE_LOCK" ] && FAKE_LOCK=true
if [ "$FAKE_LOCK" != "true" ]; then
  echo "[IMGPATCH] - fake_lock=false: bỏ qua cmdline vendor_boot và prop fake lock"
fi

# 1. Patch vendor_boot.img (chỉ bổ sung cờ fake lock vào cuối cmdline)
if [ "$FAKE_LOCK" = "true" ] && [ -f "$work_dir/$SEARCH_DIR/vendor_boot.img" ]; then 
  echo "[IMGPATCH] - PATCHING vendor_boot.img"
  mkdir -p "$work_dir/temp_boot"

  echo "[IMGPATCH] - Stage 1 Patching..."
  cp -rf "$work_dir/$SEARCH_DIR/vendor_boot.img" "$work_dir"
  cp -rf "$work_dir/$SEARCH_DIR/vendor_boot.img" "$work_dir/temp_boot"
  
  $magiskboot unpack -h "$work_dir/vendor_boot.img" >/dev/null 2>&1

  # Chỉ nối các cờ androidboot cần thiết vào cuối cmdline hiện có
  sed -i '/^cmdline=/ s/$/ androidboot.verifiedbootstate=green androidboot.flash.locked=1 androidboot.vbmeta.device_state=locked/' "$work_dir/header"

  echo "[IMGPATCH] - Stage 2 Patching..."
  $magiskboot repack "$work_dir/vendor_boot.img" >/dev/null 2>&1
  mv "$work_dir/new-boot.img" "$work_dir/vendor_boot.img"

  echo "[IMGPATCH] - Stage 3 Cleanup..."
  rm -rf "$work_dir/dtb" "$work_dir/header" "$work_dir/ramdisk.cpio"
  rm -rf "$work_dir/$SEARCH_DIR/vendor_boot.img"
  mv "$work_dir/vendor_boot.img" "$work_dir/$SEARCH_DIR"

  if [ -f "$work_dir/$SEARCH_DIR/vendor_boot.img" ]; then
    echo "[IMGPATCH] - Patched vendor_boot.img successfully!"
    rm -rf "$work_dir/temp_boot"
  else
    echo "[IMGPATCH] - Failed to patch vendor_boot.img! Reverting..."
    mv "$work_dir/temp_boot/vendor_boot.img" "$work_dir/$SEARCH_DIR"
    rm -rf "$work_dir/temp_boot"
  fi
fi

# 2. Xử lý XEUToolbox cho API < 33
BUILD_PROP=$(find "$SEARCH_DIR" -type f -name "build.prop" | head -n 1)
if [ -n "$BUILD_PROP" ]; then
  first_api=$(grep "ro.product.first_api_level" "$BUILD_PROP" | awk 'NR==1' | cut -d '=' -f 2 | tr -d ' \r')
  if [ -n "$first_api" ] && [ "$first_api" -lt 33 ]; then
    mods "API lower than 33! Inject XEUToolbox by Xiaomi.eu"
    echo "/system_ext/xbin/xeu_toolbox  u:object_r:toolbox_exec:s0" >> build/baserom/images/config/system_ext_file_contexts
    echo "/system_ext/xbin/xeu_toolbox  u:object_r:toolbox_exec:s0" >> build/baserom/images/system_ext/etc/selinux/system_ext_file_contexts
    echo "(allow init toolbox_exec (file ((execute_no_trans))))" >> build/baserom/images/system_ext/etc/selinux/system_ext_sepolicy.cil
    cp -rf "$work_dir/bin/package/KouseiPatcher/bin/xeu_toolbox/"* "$work_dir/build/baserom/images/system_ext"
    mods "Done!"
  fi
fi

# 3. Nối build.prop (chỉ khi fake_lock=true)
if [ "$FAKE_LOCK" = "true" ] && [ -f "$prop/build.prop" ]; then
  cat "$prop/build.prop" >> "$work_dir/$SEARCH_DIR/system/system/build.prop"
fi

# 4. Quét và inject cust.prop vào tất cả file cust_prop_white_keys_list (bỏ check sdkLevel)
echo "[IMGPATCH] - Scanning for cust_prop_white_keys_list..."
if [ -f "$prop/cust.prop" ]; then
  find "$SEARCH_DIR" -type f -name "cust_prop_white_keys_list" | while read -r target_file; do
    cat "$prop/cust.prop" >> "$target_file"
    echo "[IMGPATCH] - Injected cust.prop into: $target_file"
  done
fi

patch "Done"
