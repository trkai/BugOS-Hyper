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

# CN_MODEL = false: chèn "const/4 vX, 0x0" NGAY TRÊN dòng sput-boolean ...CN_MODEL
# (lấy đúng thanh ghi từ dòng gốc, không cố định v0)
#
# A16 chỉ tìm đúng đường dẫn com/miui/server/greeze/PolicyManager.smali và đúng
# chuỗi "Lcom/miui/server/greeze/PolicyManager;->CN_MODEL:Z". Trên A17 bước này
# báo "không vá được CN_MODEL" trong khi file vẫn tồn tại - nghĩa là chỗ ghi
# CN_MODEL đã đổi (class khác, hoặc tên field nằm trong class khác). Ở đây tìm
# mọi dòng sput-boolean ghi vào field CN_MODEL, bất kể class nào khai báo nó.
patch_cn_model() {
    local hits f total=0 done_files=0
    hits=$(grep -rl --include="*.smali" 'sput-boolean.*CN_MODEL:Z' "$JAR_OUT" 2>/dev/null || true)
    if [[ -z $hits ]]; then
        # Không có chỗ ghi thì chỉ còn đường đọc -> không vá được bằng cách này
        if grep -rql --include="*.smali" 'CN_MODEL:Z' "$JAR_OUT" 2>/dev/null; then
            patch "Cảnh báo: CN_MODEL chỉ được đọc, không thấy chỗ ghi - bỏ qua"
        else
            patch "Cảnh báo: không thấy CN_MODEL trong miui-services"
        fi
        return 0
    fi

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