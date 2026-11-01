#!/bin/bash
# SPDX-License-Identifier: GPL-3.0

work_dir=$(pwd)
source $work_dir/functions.sh
prop="$work_dir/bin/package/KouseiPatcher/prop"
appdir="$work_dir/bin/package/KouseiPatcher/app"
# Chỉ khớp dòng khai báo thật, không khớp dòng comment. Bản cũ dùng
# grep "install_toolbox" nên nếu config.env có comment nhắc tới tên này thì nó
# bắt dòng comment trước và đọc ra rác -> cờ true không bao giờ có tác dụng.
kaoriospatch=$(grep -m1 '^install_toolbox=' $work_dir/config.env 2>/dev/null | cut -d '=' -f 2 | tr -d ' \r\n')

if [[ $kaoriospatch == "true" ]]; then
bash $work_dir/bin/package/KouseiPatcher/fakelock_patch.sh
bash $work_dir/bin/package/KouseiPatcher/patcher.sh
cp -rf $appdir/KaoriosToolbox $work_dir/build/baserom/images/system/system/priv-app
cp -rf $appdir/com.kousei.kaorios.xml $work_dir/build/baserom/images/system/system/etc/permissions
cat $prop/build.prop >> $work_dir/build/baserom/images/system/system/build.prop
fi