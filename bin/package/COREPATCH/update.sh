#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
# ---------------------------------------------------------------------------
# COREPATCH dispatcher - bypass verify chữ ký APK trong framework.jar.
#
# Repo chỉ build OS4 trên Android 17. Các patcher A13/A14/A15/A16 đã bị xoá
# cùng branch tương ứng; jar_patcher_a17.sh là bản duy nhất còn lại.
#
# KHÔNG thêm nhánh "khác thì bỏ qua": thiếu bypass chữ ký thì mọi APK đã mod
# (kể cả bộ de-China ở PRECHINAFIX) bị PackageManager từ chối nạp với lý do sai
# chữ ký -> ROM không boot được. Thà dừng sớm và nói rõ.
# ---------------------------------------------------------------------------
work_dir=$(pwd)
source "$work_dir/functions.sh"
AndroidVER=$(cat $work_dir/bin/ddevice/androidver.txt 2>/dev/null | tr -d '\r\n ')

if [[ "${AndroidVER%%.*}" == "17" ]]; then
    # A17 dùng patcher riêng: API 37, fail-fast (xem jar_patcher_a17.sh)
    bash $work_dir/bin/package/COREPATCH/jar_patcher_a17.sh
else
    error "COREPATCH: repo chỉ hỗ trợ Android 17, ROM này là '$AndroidVER' - DỪNG"
    error "Patcher A13-A16 đã bị xoá. Cần build OS4/A17."
    exit 1
fi
