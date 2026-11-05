#!/bin/bash
# BugOS - NOTIFICATION_FIX A17 - miui-services.jar
# Fix thông báo cho HyperOS 4.0 Android 17 (dựa trên phân tích mã nhị phân ROM vá thực tế)
#
# Các điểm vá chính:
# 1. BroadcastQueueModernStubImpl.smali:
#    - isInternationalSpecialAction: IS_INTERNATIONAL_BUILD -> IS_MIUI (cho phép special actions)
#    - updateBlockBroadcast: IS_INTERNATIONAL_BUILD -> IS_MIUI (bỏ qua chặn broadcast provision)
#    - checkApplicationAutoStart: IS_INTERNATIONAL_BUILD -> IS_MIUI (cho phép FCM RECEIVE chạy nền)
#    * checkReceiverAppDealBroadcast: GIỮ NGUYÊN IS_INTERNATIONAL_BUILD (bảo toàn PACKAGE_ADDED)
# 2. ProcessManagerService.smali:
#    - isForceStopEnable: IS_INTERNATIONAL_BUILD -> IS_MIUI (ép trả về false, không kill process)
# 3. ProcessSceneCleaner.smali:
#    - handleSwipeKill: IS_INTERNATIONAL_BUILD -> IS_MIUI (bảo vệ foreground services khi vuốt)
#    - killAppForHasOtherTask: IS_INTERNATIONAL_BUILD -> IS_MIUI (bảo vệ foreground services)
# 4. PackageManagerServiceImpl.smali:
#    - verifyIsolationViolation & canBeUpdate -> return-void (bỏ qua giới hạn cài đặt/cập nhật)
#
# KHÔNG vá WindowManagerServiceImpl.notAllowCaptureDisplay nữa.
# Bản trước chèn lời gọi WindowState.isBypassSecureFlag() - method không tồn tại
# trong services.jar của ROM này -> chụp màn hình là system_server chết
# (NoSuchMethodError) -> đơ rồi soft reboot. Đã bỏ hẳn.

work_dir=$(pwd)
source $work_dir/functions.sh
MAIN_FOLDER="$work_dir/build/baserom/images"
JAR_NAME="miui-services.jar"
NF="$work_dir/bin/package/NOTIFICATION_FIX/A17"

find_jar() {
    local name="$1"; shift
    local p
    for p in "$@"; do
        [ -f "$p" ] && { printf '%s' "$p"; return 0; }
    done
    find "$MAIN_FOLDER" -type f -name "$name" 2>/dev/null | head -n 1
}

JAR_SRC=$(find_jar "$JAR_NAME" \
    "$MAIN_FOLDER/system_ext/framework/$JAR_NAME" \
    "$MAIN_FOLDER/system/system_ext/framework/$JAR_NAME" \
    "$MAIN_FOLDER/system/system/framework/$JAR_NAME" \
    "$MAIN_FOLDER/product/framework/$JAR_NAME")

JAR_TMP="$work_dir/jar_temp"
JAR_OUT="$JAR_TMP/$JAR_NAME.out"
bak="java -jar $work_dir/bin/apktool/baksmaliv2.jar d --api 37"
sma="java -jar $work_dir/bin/apktool/smaliv2.jar a --api 37"

decompile_jar() {
    patch "$JAR_NAME (Android 17 / HyperOS 4.0)"
    
    # Kiểm tra FcmWakeFilter trước khi giải nén
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

    # Chỉ decompile các DEX có chứa các class cần vá (thường là classes.dex).
    # Giữ nguyên classes2.dex ở dạng binary nếu nó không chứa class cần vá -> bảo toàn FcmWakeFilter 100%!
    local dex decompiled_any=0
    for dex in "$JAR_OUT"/*.dex; do
        [[ -f $dex ]] || continue
        if grep -aqm1 -E 'BroadcastQueueModernStubImpl|ProcessManagerService|ProcessSceneCleaner|PackageManagerServiceImpl' "$dex" 2>/dev/null; then
            patch "Decompiling $(basename "$dex") (có chứa class mục tiêu)..."
            $bak "$dex" -o "$dex.out"
            if [[ -d "$dex.out" ]]; then
                rm -f "$dex"
                decompiled_any=1
            fi
        fi
    done

    # Nếu không grep trúng (do dex bị nén), fallback decompile tất cả
    if [[ $decompiled_any -eq 0 ]]; then
        for dex in "$JAR_OUT"/*.dex; do
            [[ -f $dex ]] || continue
            $bak "$dex" -o "$dex.out"
            [[ -d "$dex.out" ]] && rm -f "$dex"
        done
    fi

    compgen -G "$JAR_OUT/*.dex.out" >/dev/null
}

apply_patches() {
    local patcher_py="$NF/patch_miui_services_a17.py"
    if [[ ! -f "$patcher_py" ]]; then
        patch "Cảnh báo: không tìm thấy $patcher_py!"
        return 1
    fi

    python3 "$patcher_py" "$JAR_OUT"
    local rc=$?
    if [[ $rc -ne 0 ]]; then
        patch "Lỗi khi chạy patch_miui_services_a17.py (mã thoát: $rc)"
        return 1
    fi
    return 0
}

# CN policy fallback nếu có PolicyManagerConfig hoặc CN_MODEL
patch_cn_model() {
    local hits f total=0 done_files=0
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
        [[ $done_files -gt 0 ]] && patch "Đã vá CN_MODEL = false ($total chỗ ghi, $done_files file)"
        return 0
    fi

    local cfg
    cfg=$(find "$JAR_OUT" -type f -name "PolicyManagerConfig.smali" 2>/dev/null | head -n1)
    if [[ -n $cfg ]] && grep -q 'Lmiui/os/Build;->getRegion' "$cfg"; then
        if python3 "$work_dir/bin/tools/patch_smali_method.py" "$cfg" isCnModel Z 0 >/dev/null 2>&1; then
            patch "CN policy: đã ép isCnModel() = false trong PolicyManagerConfig"
        fi
    fi
}

recompile_jar() {
    cd "$JAR_OUT" || return 1
    local fld out
    for fld in ./*.out; do
        [[ -d $fld ]] || continue
        out="${fld%.out}"
        patch "Reassembling $(basename "$out")..."
        $sma "$fld" -o "$out"
        [[ -f $out ]] && rm -rf "$fld"
    done

    # nếu còn thư mục .out nghĩa là smali lỗi, không ghi đè jar gốc
    if compgen -G "$JAR_OUT/*.out" >/dev/null; then
        cd "$work_dir"
        return 1
    fi

    rm -f "$JAR_TMP/${JAR_NAME}_notal" "$JAR_TMP/$JAR_NAME"
    if command -v 7za >/dev/null 2>&1; then
        7za a -tzip -mx=0 "$JAR_TMP/${JAR_NAME}_notal" "$JAR_OUT/." >/dev/null 2>&1
    elif command -v zip >/dev/null 2>&1; then
        (cd "$JAR_OUT" && zip -q -0 -r "$JAR_TMP/${JAR_NAME}_notal" .)
    fi

    if command -v zipalign >/dev/null 2>&1; then
        zipalign 4 "$JAR_TMP/${JAR_NAME}_notal" "$JAR_TMP/$JAR_NAME"
    else
        cp -f "$JAR_TMP/${JAR_NAME}_notal" "$JAR_TMP/$JAR_NAME"
    fi

    cd "$work_dir"
    [[ -f "$JAR_TMP/$JAR_NAME" ]] || return 1
    sudo cp -rf "$JAR_TMP/$JAR_NAME" "$JAR_SRC"
    rm -rf "$JAR_OUT" "$JAR_TMP/${JAR_NAME}_notal"
}

mkdir -p "$JAR_TMP"

if [[ -z "$JAR_SRC" || ! -f "$JAR_SRC" ]]; then
    patch "Không thấy $JAR_NAME, bỏ qua"
    exit 0
fi

if ! decompile_jar; then
    patch "Fail: không decompile được $JAR_NAME"
    rm -rf "$JAR_OUT"
    exit 1
fi

apply_patches
patch_cn_model

if recompile_jar; then
    patch "Success: đã vá thành công $JAR_NAME cho Android 17 / HyperOS 4.0!"
    if [[ ${HAD_FCM:-0} -eq 1 ]]; then
        if grep -aqm1 FcmWakeFilter "$JAR_SRC" 2>/dev/null; then
            patch "FcmWakeFilter vẫn còn trong jar (FCM fix an toàn)"
        else
            patch "CẢNH BÁO: bước rebuild đã làm rơi FcmWakeFilter"
        fi
    fi
else
    patch "Fail: không build lại được $JAR_NAME, giữ nguyên bản gốc"
    exit 1
fi
