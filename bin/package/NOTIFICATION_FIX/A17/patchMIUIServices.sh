#!/bin/bash
# BugOS - NOTIFICATION_FIX A17 - miui-services.jar
# Credit: hướng dẫn gốc của @MMETMAmods
work_dir=$(pwd)
source $work_dir/functions.sh
MAIN_FOLDER="$work_dir/build/baserom/images"
JAR_NAME="miui-services.jar"
JAR_SRC="$MAIN_FOLDER/system_ext/framework/$JAR_NAME"
JAR_TMP="$work_dir/jar_temp"
JAR_OUT="$JAR_TMP/$JAR_NAME.out"
bak="java -jar $work_dir/bin/apktool/baksmaliv2.jar d --api 37"
sma="java -jar $work_dir/bin/apktool/smaliv2.jar a --api 37"

# Các file smali sẽ đổi IS_INTERNATIONAL_BUILD -> IS_MIUI
# (đã bao gồm 3 class bắt buộc: BroadcastQueueModernStubImpl, ProcessManagerService, ProcessSceneCleaner)
PATCH_FILES=(
    'ActivityManagerServiceImpl.smali'
    'BroadcastQueueModernStubImpl.smali'
    'MiProcessTracker.smali'
    'MutableActivityManagerShellCommandStubImpl.smali'
    'PreStartFeedbackImpl.smali'
    'ProcessManagerService.smali'
    'ProcessPolicy.smali'
    'ProcessSceneCleaner.smali'
    'AudioServiceStubImpl.smali'
    'ClipboardChecker.smali'
    'ClipboardServiceStubImpl.smali'
    'DevicePolicyManagerServiceStubImpl.smali'
    'InputManagerServiceStubImpl.smali'
    'InputMethodManagerServiceImpl.smali'
    'SogouInputMethodSwitcher.smali'
    'JobServiceContextImpl.smali'
    'GnssEventTrackingImpl.smali'
    'PackageManagerServiceImpl.smali'
    'MiuiShortcutTriggerHelper$ShortcutSettingsObserver.smali'
    'ActivityTaskSupervisorImpl.smali'
    'MiuiSplitInputMethodImpl.smali'
    'WindowManagerServiceImpl.smali'
    'DeviceIdleControllerStubImpl.smali'
    'ForceDarkAppListManager.smali'
)

decompile_jar() {
    patch "$JAR_NAME"
    # Ghi nhớ xem jar đã được mod FCM_NotificationFix vá trước đó chưa, để cuối
    # cùng kiểm tra lại xem bước reassemble có làm rơi class FcmWakeFilter không.
    if grep -aqm1 FcmWakeFilter "$JAR_SRC" 2>/dev/null; then
        HAD_FCM=1
    else
        HAD_FCM=0
    fi
    sudo cp "$JAR_SRC" "$JAR_TMP/"
    sudo chown "$(whoami)" "$JAR_TMP/$JAR_NAME"
    rm -rf "$JAR_OUT"
    unzip -o "$JAR_TMP/$JAR_NAME" -d "$JAR_OUT" >/dev/null 2>&1
    [[ -d $JAR_OUT ]] || return 1
    rm -f "$JAR_TMP/$JAR_NAME"
    local dex
    for dex in "$JAR_OUT"/*.dex; do
        [[ -f $dex ]] || continue
        $bak "$dex" -o "$dex.out"
        [[ -d "$dex.out" ]] && rm -f "$dex"
    done
    # phải có ít nhất một thư mục smali
    compgen -G "$JAR_OUT/*.dex.out" >/dev/null
}

find_and_replace() {
    local search=$1 replace=$2 name f count=0
    for name in "${PATCH_FILES[@]}"; do
        while IFS= read -r f; do
            [[ -n $f ]] || continue
            if grep -qF "$search" "$f"; then
                sed -i "s|$search|$replace|g" "$f"
                count=$((count + 1))
            fi
        done < <(find "$JAR_OUT" -type f -name "$name")
    done
    if [[ $count -eq 0 ]]; then
        patch "Cảnh báo: không file nào chứa IS_INTERNATIONAL_BUILD để vá"
    else
        patch "Đã vá IS_INTERNATIONAL_BUILD ở $count file"
    fi

    # Chẩn đoán (không sửa): các class còn đọc IS_INTERNATIONAL_BUILD nhưng không
    # nằm trong PATCH_FILES. Đây là danh sách để cân nhắc bổ sung, không phải lỗi.
    local extra
    extra=$(grep -rl --include="*.smali" 'Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z' "$JAR_OUT" 2>/dev/null \
        | xargs -r -n1 basename 2>/dev/null | sort -u | grep -vxF -f <(printf '%s\n' "${PATCH_FILES[@]}") || true)
    if [[ -n $extra ]]; then
        patch "Chẩn đoán: còn $(printf '%s\n' "$extra" | wc -l) class ngoài danh sách đọc IS_INTERNATIONAL_BUILD"
        printf '%s\n' "$extra" | head -n 10 | sed 's/^/    /'
    fi
}

# CN policy = false (dùng chính sách không-China, ít đóng băng hơn).
#
# A16 ghi đè field PolicyManager.CN_MODEL. Trên Android 17 field đó KHÔNG CÒN.
# Cấu trúc thật của A17 (đọc từ miui-services.jar gốc của OS4):
#
#   PolicyManager.isCnModel()Z
#       -> PolicyManagerConfig.isCnModel()Z
#              -> sget-boolean sCnModel:Z
#   PolicyManagerConfig.<clinit>
#       const-string "CN"
#       Build.getRegion()  -> equals -> sput-boolean sCnModel
#
# Nên "CN model" giờ chỉ là  so sánh region với "CN". ROM này đặt
# ro.miui.region=VN nên sCnModel đã là false sẵn - không cần vá, và log cũ
# ("không vá được CN_MODEL") chỉ là báo động sai.
#
# Ở đây: nếu còn field CN_MODEL thì vá như A16; nếu không, đọc cấu trúc mới và
# chỉ vá khi region thực sự là CN.
patch_cn_model() {
    local hits f total=0 done_files=0

    # Chỉ trong package greeze: các class khác cũng có field tên CN_MODEL nhưng
    # không liên quan (vd TicketSnatchingModeScenario), vá chúng chỉ làm log sai.
    hits=$(grep -rl --include="*.smali" 'sput-boolean.*CN_MODEL:Z' "$JAR_OUT" 2>/dev/null \
        | grep '/com/miui/server/greeze/' || true)
    if [[ -n $hits ]]; then
        while IFS= read -r f; do
            [[ -n $f ]] || continue
            sed -i -E \
                's|^([[:space:]]*)sput-boolean ([vp][0-9]+), ([A-Za-z0-9_/$]+;->CN_MODEL:Z)|\1const/4 \2, 0x0\n\1sput-boolean \2, \3|' \
                "$f"
            if grep -B1 'sput-boolean.*CN_MODEL:Z' "$f" | grep -q 'const/4 .*, 0x0'; then
                done_files=$((done_files + 1))
                total=$((total + $(grep -c 'sput-boolean.*CN_MODEL:Z' "$f")))
            fi
        done <<< "$hits"

        if [[ $done_files -gt 0 ]]; then
            patch "Đã vá CN_MODEL = false ($total chỗ ghi, $done_files file)"
        else
            patch "Cảnh báo: không vá được CN_MODEL"
        fi
        return 0
    fi

    # ---- A17: không còn field CN_MODEL ----
    local cfg region
    cfg=$(find "$JAR_OUT" -type f -name "PolicyManagerConfig.smali" 2>/dev/null | head -n1)
    if [[ -z $cfg ]]; then
        patch "CN policy: không thấy CN_MODEL lẫn PolicyManagerConfig - bỏ qua"
        return 0
    fi
    if ! grep -q 'Lmiui/os/Build;->getRegion' "$cfg"; then
        patch "CN policy: PolicyManagerConfig không dựa vào getRegion - bỏ qua"
        return 0
    fi

    region=$(grep -m1 '^ro\.miui\.region=' "$MAIN_FOLDER/system/system/build.prop" 2>/dev/null \
        | cut -d= -f2 | tr -d '\r\n ')
    if [[ -z $region ]]; then
        region=$(grep -rh -m1 '^ro\.miui\.region=' "$MAIN_FOLDER"/product/etc/build.prop 2>/dev/null \
            | cut -d= -f2 | tr -d '\r\n ')
    fi

    if [[ $region == "CN" ]]; then
        # region là CN -> sCnModel = true -> ép về false
        if python3 "$work_dir/bin/tools/patch_smali_method.py" "$cfg" isCnModel Z 0 >/dev/null 2>&1; then
            patch "CN policy: region=CN -> đã ép isCnModel() = false"
        else
            patch "Cảnh báo: region=CN nhưng không vá được isCnModel()"
        fi
    else
        patch "CN policy: region='${region:-?}' -> sCnModel đã false sẵn (không cần vá)"
    fi
}

recompile_jar() {
    cd "$JAR_OUT" || return 1
    local fld out
    for fld in ./*.out; do
        [[ -d $fld ]] || continue
        out="${fld%.out}"
        $sma "$fld" -o "$out"
        [[ -f $out ]] && rm -rf "$fld"
    done
    # nếu còn thư mục .out nghĩa là smali lỗi, không ghi đè jar gốc
    if compgen -G "$JAR_OUT/*.out" >/dev/null; then
        cd "$work_dir"
        return 1
    fi
    rm -f "$JAR_TMP/${JAR_NAME}_notal" "$JAR_TMP/$JAR_NAME"
    7za a -tzip -mx=0 "$JAR_TMP/${JAR_NAME}_notal" "$JAR_OUT/." >/dev/null 2>&1
    zipalign 4 "$JAR_TMP/${JAR_NAME}_notal" "$JAR_TMP/$JAR_NAME"
    cd "$work_dir"
    [[ -f "$JAR_TMP/$JAR_NAME" ]] || return 1
    sudo cp -rf "$JAR_TMP/$JAR_NAME" "$JAR_SRC"
    rm -rf "$JAR_OUT" "$JAR_TMP/${JAR_NAME}_notal"
}

mkdir -p "$JAR_TMP"

if [[ ! -f $JAR_SRC ]]; then
    patch "Không thấy $JAR_NAME, bỏ qua"
    exit 0
fi

if ! decompile_jar; then
    patch "Fail: không decompile được $JAR_NAME"
    rm -rf "$JAR_OUT"
    exit 1
fi

find_and_replace "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z" "Lmiui/os/Build;->IS_MIUI:Z"
patch_cn_model

if recompile_jar; then
    patch "Success"
    if [[ ${HAD_FCM:-0} -eq 1 ]]; then
        if grep -aqm1 FcmWakeFilter "$JAR_SRC" 2>/dev/null; then
            patch "FcmWakeFilter vẫn còn trong jar (FCM fix an toàn)"
        else
            patch "CẢNH BÁO: bước rebuild đã làm rơi FcmWakeFilter - vector V2/V3 của FCM mất, V1 trong services.jar vẫn còn"
        fi
    fi
else
    patch "Fail: không build lại được $JAR_NAME, giữ nguyên bản gốc"
    exit 1
fi