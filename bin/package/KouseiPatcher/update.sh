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

# fake_lock tách khỏi install_toolbox:
#   install_toolbox=true  -> cài app KaoriosToolbox (công cụ xem trạng thái máy)
#   fake_lock=true        -> vá thêm để máy BÁO bootloader đã khóa
# Muốn dùng app mà không giả trạng thái thì install_toolbox=true + fake_lock=false.
# Khi đó patcher.sh (hook framework/services) bị bỏ, phần cmdline vendor_boot và
# prop fake lock trong fakelock_patch.sh cũng bị bỏ; app chạy như app thường và
# hiển thị đúng trạng thái thật của máy.
fakelock=$(grep -m1 '^fake_lock=' $work_dir/config.env 2>/dev/null | cut -d '=' -f 2 | tr -d ' \r\n')
[ -z "$fakelock" ] && fakelock=true

if [[ $kaoriospatch == "true" ]]; then
    # fakelock_patch.sh tự đọc fake_lock bên trong: bỏ cmdline vendor_boot và
    # prop fake lock, vẫn giữ whitelist cust.prop.
    bash $work_dir/bin/package/KouseiPatcher/fakelock_patch.sh

    if [[ $fakelock == "true" ]]; then
        bash $work_dir/bin/package/KouseiPatcher/patcher.sh
    else
        mods "Kousei: fake_lock=false - không vá framework/services cho fake lock"
        mods "Kousei: vẫn cài KaoriosToolbox, app sẽ hiện trạng thái THẬT"
    fi

    cp -rf $appdir/KaoriosToolbox $work_dir/build/baserom/images/system/system/priv-app
    cp -rf $appdir/com.kousei.kaorios.xml $work_dir/build/baserom/images/system/system/etc/permissions
else
    mods "Kousei: install_toolbox=false - không cài KaoriosToolbox"
fi
