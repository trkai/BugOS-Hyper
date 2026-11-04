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
IMG="$work_dir/build/baserom/images"

# ---------------------------------------------------------------------------
# SELinux cho AdvancedPolicyService.
#
# Payload đăng ký một service Binder tên "kaorios_advanced_policy" từ
# KaoriosHook.initSystemServer() (chạy trong SystemServer.run). App
# com.kousei.kaorios gọi ServiceManager.getService(tên đó) để điều khiển.
#
# Thiếu policy thì ServiceManager.addService() trong system_server bị từ chối
# (không có allow nào cho system_server add vào default_android_service - tên
# chưa khai báo trong service_contexts sẽ rơi vào label đó), service không được
# đăng ký, app không tìm thấy -> mục "Sửa lỗi Integrity" không mở được.
#
# Tên service lấy từ chính payload: giải mã hằng số trong
# ServiceManagerBridge.<clinit> (p.a(J)) -> "kaorios_advanced_policy". Không
# đoán từ tài liệu upstream.
#
# Bốn thứ phải khớp nhau, thiếu một là hỏng:
#   1. type + roletype
#   2. gán type vào attribute service_manager_type
#   3. allow system_server add/find, allow priv_app find
#   4. plat_service_contexts: map TÊN -> type (nếu không, tên vẫn là
#      default_android_service và các allow ở (3) không bao giờ khớp)
# ---------------------------------------------------------------------------
KAORIOS_SVC="kaorios_advanced_policy"
KAORIOS_TYPE="${KAORIOS_SVC}_service"

install_kaorios_policy() {
    local cil="$IMG/system/system/etc/selinux/plat_sepolicy.cil"
    local ctx="$IMG/system/system/etc/selinux/plat_service_contexts"

    if [ ! -f "$cil" ]; then
        warn "Kousei: không thấy plat_sepolicy.cil - bỏ qua policy cho $KAORIOS_SVC"
        return 0
    fi

    if grep -Fq "(type $KAORIOS_TYPE)" "$cil"; then
        mods "Kousei: policy $KAORIOS_TYPE đã có - bỏ qua"
    else
        {
            echo ""
            # CIL dung ';' cho comment, KHONG dung '#'. Ghi '#' thi secilc bao
            # "Symbol not inside parenthesis" va ca policy khong bien dich duoc
            # -> init panic -> fastboot. Da dinh dung loi nay o f871109.
            echo "; BUGOS-KAORIOS-BEGIN"
            echo "; BugOS: service Binder riêng của Kaorios Toolbox"
            echo "(type $KAORIOS_TYPE)"
            echo "(roletype object_r $KAORIOS_TYPE)"
            echo "(typeattributeset service_manager_type ($KAORIOS_TYPE))"
            echo "(allow system_server $KAORIOS_TYPE (service_manager (add find)))"
            echo "(allow priv_app $KAORIOS_TYPE (service_manager (find)))"
            echo "(allow priv_app system_server (binder (call)))"
            echo "; BUGOS-KAORIOS-END"
        } >> "$cil"
        if grep -Fq "(type $KAORIOS_TYPE)" "$cil"; then
            mods "Kousei: đã thêm policy $KAORIOS_TYPE vào plat_sepolicy.cil"
        else
            warn "Kousei: ghi plat_sepolicy.cil thất bại - $KAORIOS_SVC sẽ không đăng ký được"
        fi
    fi

    if [ ! -f "$ctx" ]; then
        warn "Kousei: không thấy plat_service_contexts - service sẽ mang label default_android_service"
        return 0
    fi

    if grep -qE "^${KAORIOS_SVC}[[:space:]]" "$ctx"; then
        mods "Kousei: $KAORIOS_SVC đã có trong plat_service_contexts - bỏ qua"
    else
        echo "${KAORIOS_SVC} u:object_r:${KAORIOS_TYPE}:s0" >> "$ctx"
        if grep -qE "^${KAORIOS_SVC}[[:space:]]" "$ctx"; then
            mods "Kousei: đã map $KAORIOS_SVC -> ${KAORIOS_TYPE} trong plat_service_contexts"
        else
            warn "Kousei: ghi plat_service_contexts thất bại"
        fi
    fi
}

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

        kaoriospolicy=$(grep -m1 '^kaorios_service_policy=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
        if [ "$kaoriospolicy" = "false" ]; then
            mods "Kousei: kaorios_service_policy=false - không thêm policy cho $KAORIOS_SVC"
        else
            install_kaorios_policy
        fi
    else
        mods "Kousei: fake_lock=false - không vá framework/services"
        mods "Kousei: vẫn cài KaoriosToolbox, app sẽ hiện trạng thái THẬT"
    fi

    cp -rf $appdir/KaoriosToolbox "$IMG/system/system/priv-app"
    cp -rf $appdir/com.kousei.kaorios.xml "$IMG/system/system/etc/permissions"
    mods "Kousei: KaoriosToolbox 2.0.6.1 đã vào priv-app"
else
    mods "Kousei: install_toolbox=false - không cài KaoriosToolbox"
fi
