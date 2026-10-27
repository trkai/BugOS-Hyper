#!/bin/bash
# SPDX-License-Identifier: GPL-3.0

work_dir=$(pwd)
source $work_dir/functions.sh
AndroidVER=$(cat $work_dir/bin/ddevice/androidver.txt)

if [[ $AndroidVER == "13" ]];then
    bash $work_dir/bin/package/COREPATCH/jar_patcher_a13.sh
elif [[ $AndroidVER == "14" ]];then
    bash $work_dir/bin/package/COREPATCH/jar_patcher_a14.sh
elif [[ $AndroidVER == "15" ]];then
    bash $work_dir/bin/package/COREPATCH/jar_patcher_a15.sh
elif [[ $AndroidVER == "16" ]];then
    bash $work_dir/bin/package/COREPATCH/jar_patcher_a16.sh
elif [[ $AndroidVER == "17" ]];then
    # A17 dùng patcher riêng: API 37, smali 3.0.5, fail-fast (xem jar_patcher_a17.sh)
    bash $work_dir/bin/package/COREPATCH/jar_patcher_a17.sh
else
    # Không được im lặng: thiếu nhánh ở đây = framework.jar không được bypass
    # verify chữ ký -> mọi APK mod bị từ chối nạp -> ROM không boot được.
    echo "[ERROR] COREPATCH: chưa có patcher cho Android '$AndroidVER' - DỪNG"
    echo "[ERROR] Thêm bin/package/COREPATCH/jar_patcher_a${AndroidVER%%.*}.sh rồi build lại."
    exit 1
fi
