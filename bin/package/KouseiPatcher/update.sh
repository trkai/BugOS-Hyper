#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
#
# Kaorios Toolbox 2.0.6.1 (upstream hzzmonetvn/Kaorios-Toolbox).
#
# Hai cờ trong config.env:
#   install_toolbox=true  -> cài app com.kousei.kaorios + file quyền priv-app
#   fake_lock=true        -> chạy patcher.sh: import payload classes.dex vào
#                            framework.jar và chèn 5 hook (ActivityThread,
#                            Instrumentation, Settings$NameValueCache,
#                            SystemServer, ComputerEngine)
#
# Lưu ý về tên cờ: từ 2.0.6.1, "fake_lock" KHÔNG còn là mấy dòng build.prop /
# cmdline vendor_boot nữa (mấy thứ đó đã chứng minh vô hiệu: bootconfig được áp
# trước cmdline và ro.* ghi một lần). Nó là lớp hook Java + attestation của
# toolbox. Tắt cờ này thì app vẫn cài nhưng không có hook nào, app hiện đúng
# trạng thái thật của máy.

work_dir=$(pwd)
source $work_dir/functions.sh
appdir="$work_dir/bin/package/KouseiPatcher/app"

# Chỉ khớp dòng khai báo thật, không khớp dòng comment. Bản cũ dùng
# grep "install_toolbox" nên nếu config.env có comment nhắc tới tên này thì nó
# bắt dòng comment trước và đọc ra rác -> cờ true không bao giờ có tác dụng.
kaoriospatch=$(grep -m1 '^install_toolbox=' $work_dir/config.env 2>/dev/null | cut -d '=' -f 2 | tr -d ' \r\n')

fakelock=$(grep -m1 '^fake_lock=' $work_dir/config.env 2>/dev/null | cut -d '=' -f 2 | tr -d ' \r\n')
[ -z "$fakelock" ] && fakelock=true

if [[ $kaoriospatch == "true" ]]; then
    # prop/build.prop + cmdline vendor_boot + whitelist cust.prop. Chỉ lớp
    # build.prop/vendor_boot là di sản của bản Kousei; whitelist cust.prop vẫn
    # cần vì nó chỉ khai báo prop nào được đọc.
    bash $work_dir/bin/package/KouseiPatcher/fakelock_patch.sh

    if [[ $fakelock == "true" ]]; then
        bash $work_dir/bin/package/KouseiPatcher/patcher.sh
    else
        mods "Kousei: fake_lock=false - không vá framework/services"
        mods "Kousei: vẫn cài KaoriosToolbox, app sẽ hiện trạng thái THẬT"
    fi

    cp -rf $appdir/KaoriosToolbox $work_dir/build/baserom/images/system/system/priv-app
    cp -rf $appdir/com.kousei.kaorios.xml $work_dir/build/baserom/images/system/system/etc/permissions
    mods "Kousei: KaoriosToolbox 2.0.6.1 đã vào priv-app"
else
    mods "Kousei: install_toolbox=false - không cài KaoriosToolbox"
fi
