#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
# ---------------------------------------------------------------------------
# PRECHINAFIX - vá 5 file hệ thống cho OS4/A17 từ bảng patch method.
#
# KHÔNG dùng prebuilt APK/jar (203 MB). Repo lưu bảng patch JSON (1.9 MB) và tự
# vá lúc build, để thấy rõ từng method bị sửa và diff được trong git.
#
# Bảng patch sinh bằng: bin/tools/gen_patches.py <old_tree> <new_tree> <out.json>
# Áp dụng bằng        : bin/tools/apply_patches.py <smali_tree> <patch.json>
# Đóng gói APK        : bin/tools/apk_dex_patch.py unpack/repack
#
# NỘI DUNG VÁ (đối chiếu bằng diff smali giữa bản gốc và bản đã vá trên base
# OS4.0.6.0.XPKCNXM / annibale / SDK 37):
#
#   MiuiSystemUI  classes2 + classes3   15 method
#     NotificationUtil.isEmptySummary              -> luôn false, không gộp summary
#     MiuiBaseNotifUtil.isGlobalInCallNotification -> false
#     MiuiBaseNotifUtil.shouldSuppressFold         -> false
#     NotificationSettingsManager (6 method + ctor + clinit)
#     MiuiNotifCoordinator$notifPromoter$1.shouldPromoteToTopLevel
#     CountLimitCoordinator/AlertCoordinator/FocusCoordinator (lambda)
#     VisualInterruptionDecisionProviderImplInjector.shouldPeek
#     NotificationStatImpl$onAppStateDailyEvent$1.run
#
#   PowerKeeper                          7 method
#     PadSleepModeController.applySleepConfig   -> return-void (tắt sleep mode)
#     PhoneSleepModeController.applySleepConfig -> return-void
#     PadSleepModeController.checkChineseUser   -> stub
#     Utils.isCloudControlAllowed / isDemoBuild /
#     isUserExperienceAndPrivacyAllowed         -> ép false (tắt upload log cloud)
#     CustomerPowerCheck.outputResultPassAndNone
#
#   Settings.apk                         12 method / 10 class mới + 5 class sửa
#     SettingsFeatures.isLocationNeeded / isPrivacyNeeded   -> luôn true
#     MiuiSettings.updateHeaderList                          -> hiện Google Settings
#     IconDisplayCustomizationSettings.setupShowNotificationIconCount
#                                                            -> thêm 3/4/5 icon
#     DeviceBasicInfoPresenter.initData / updateCameraInfo
#     ParseMiShopDataUtils.getItemTitle(Context,...)         -> THÊM MỚI
#     (ColorOS About phone, classes3 + classes12)
#     DeviceBasicInfoPresenter.getLineNum                    -> luôn 1 dòng
#     MiuiDeviceNameCard/MiuiMemoryCard.initView             -> dùng layout kashi
#     MiuiVersionCard.initView / setLogoBlur                 -> nền card mới
#     10 class mới: com.kashi.settings.view.* + com.android.settings.kashi.Utils
#
#   miui-services.jar                    166 method / 37 file
#     Ép IS_INTERNATIONAL_BUILD = true xuyên suốt ->
#       - NTP/DNS sang máy chủ quốc tế (NetworkTimeUpdateServiceImpl, AddressPool)
#       - tắt upload telemetry GNSS (GnssCollectDataImpl, GnssEventTrackingImpl)
#       - nới auto-start / broadcast / clipboard / jobs cho app nền
#       - GreezeManagerService (21 method), ProcessPolicy, ProcessSceneCleaner
#       - shortcut/phím cứng (MiuiShortcutTriggerHelper, MiuiSingleKeyRule...)
#     PackageManagerServiceImpl: verifyIsolationViolation + canBeUpdate -> return-void
#       (chuyển từ NOTIFICATION_FIX sang khi bỏ module đó).
#
#   miui-framework.jar                   14 method + 9 class mới
#     ActivityThreadImpl (7 method), AppOpsManagerInjector, NearbyUtils,
#     MultiLangHelper, SymlinkUtils, + 9 class eu.xiaomi.util.Translator
#     (bộ dịch máy của Xiaomi, thêm mới chứ không sửa).
#
# RÀNG BUỘC THỨ TỰ (xem build.sh):
#   PRECHINAFIX -> insupdate.sh -> patchpackage.sh
#   COREPATCH trong patchpackage.sh GHI ĐÈ 2 jar, nên nó phải vá TRÊN bản đã áp
#   patch này. Settings phải vá trước Settings_ROMInformation để branding chồng
#   lên sau.
#
# CẢNH BÁO: 5 file sau khi vá SAI CHỮ KÝ. Chỉ nạp được nhờ COREPATCH.
# ---------------------------------------------------------------------------

work_dir=$(pwd)
[ -f "$work_dir/functions.sh" ] && source "$work_dir/functions.sh"

MAIN_FOLDER="$work_dir/build/baserom/images"
PDIR="$work_dir/bin/package/PRECHINAFIX/patches"
TOOLS="$work_dir/bin/tools"

log_msg() {
    if type patch &>/dev/null; then patch "$1"
    elif type mods &>/dev/null; then mods "$1"
    elif type info &>/dev/null; then info "$1"
    else echo "[PRECHINAFIX] $1"; fi
}
warn_msg() {
    if type warn &>/dev/null; then warn "$1"
    else echo "[PRECHINAFIX][WARN] $1"; fi
}

[ -d "$MAIN_FOLDER" ] || { warn_msg "chưa có images - bỏ qua"; exit 0; }
[ -f "$TOOLS/apply_patches.py" ]  || { warn_msg "thiếu $TOOLS/apply_patches.py"; exit 1; }
[ -f "$TOOLS/apk_dex_patch.py" ]  || { warn_msg "thiếu $TOOLS/apk_dex_patch.py"; exit 1; }

BSMALI_JAR="$work_dir/bin/apktool/baksmaliv2.jar"
SMALI_JAR="$work_dir/bin/apktool/smaliv2.jar"
[ -f "$BSMALI_JAR" ] || { warn_msg "thiếu $BSMALI_JAR"; exit 1; }
[ -f "$SMALI_JAR" ]  || { warn_msg "thiếu $SMALI_JAR"; exit 1; }

command -v java >/dev/null || { warn_msg "không có java - bỏ qua"; exit 0; }
command -v python3 >/dev/null || { warn_msg "không có python3 - bỏ qua"; exit 0; }

# ---------------------------------------------------------------------------
# Vá một APK: unpack MỘT lần, vá nhiều dex, repack MỘT lần.
#
# Dùng apk_dex_patch.py thay vì tự zip: nó ghi dex ở dạng STORED + canh lề 4
# byte và giữ resources.arsc STORED. Thiếu canh lề thì PackageManager từ chối
# thẳng APK trong priv-app (targetSdk >= 30):
#     "requires the resources.arsc of installed APKs to be stored uncompressed
#      and aligned on a 4-byte boundary"
# Lỗi này từng làm SystemUI biến mất khỏi danh sách package (mất status bar).
#
# Vì sao gộp: Settings.apk là 116 MB; gọi unpack+repack riêng cho từng dex thì
# cả APK bị đọc và ghi lại 3 lần (đo được ~12 phút cho 3 dex). Gộp lại còn 1 lần.
#
# apply_dex_patch <apk> <ten-base> <dex_name> <dex_name> ...
#   bảng patch tương ứng là <ten-base>-<dex_name>.json
# ---------------------------------------------------------------------------
apply_dex_patch() {
    local apk="$1" base="$2"; shift 2
    local apkname="${apk##*/}"

    local tmp; tmp=$(mktemp -d "$work_dir/.prechina.XXXXXX") || return 1

    if ! python3 "$TOOLS/apk_dex_patch.py" unpack "$apk" "$tmp" >/dev/null 2>&1; then
        warn_msg "$apkname: unpack thất bại - bỏ qua"
        rm -rf "$tmp"; return 1
    fi

    local d dexname pj applied=0
    for d in "$@"; do
        dexname="${d%.dex}"
        pj="$PDIR/${base}-${dexname}.json"
        if [ ! -f "$pj" ]; then
            # Tên bảng phải đúng "<base>-<dex>.json". Từng có bảng đặt tên
            # "PowerKeeper.json" (thiếu "-classes") nên 7 method không bao giờ
            # được áp mà build vẫn xanh - log chỉ WARN rồi đi tiếp.
            warn_msg "$apkname: thiếu bảng patch $pj - bỏ qua $d"
            debug "  bảng có sẵn cho ${base}: $(ls "$PDIR" 2>/dev/null | grep -i "^${base}" | tr '\n' ' ')"
            continue
        fi
        [ -f "$tmp/dex/$d" ] || { warn_msg "$apkname: không có $d - bỏ qua"; continue; }

        java -jar "$BSMALI_JAR" d --api 37 "$tmp/dex/$d" -o "$tmp/sm/$dexname" >/dev/null 2>&1 || {
            warn_msg "$apkname/$d: baksmali lỗi"; rm -rf "$tmp"; return 1; }

        python3 "$TOOLS/apply_patches.py" "$tmp/sm/$dexname" "$pj" || {
            warn_msg "$apkname/$d: patch không áp được đủ - KHÔNG ghi đè APK"
            rm -rf "$tmp"; return 1; }

        java -jar "$SMALI_JAR" a --api 37 "$tmp/sm/$dexname" -o "$tmp/dex/$d" >/dev/null 2>&1 || {
            warn_msg "$apkname/$d: smali lại lỗi"; rm -rf "$tmp"; return 1; }

        applied=$((applied + 1))
    done

    if [ "$applied" -eq 0 ]; then
        warn_msg "$apkname: không vá được dex nào"
        rm -rf "$tmp"; return 0
    fi

    if ! python3 "$TOOLS/apk_dex_patch.py" repack "$apk" "$tmp" "$tmp/out.apk" >/dev/null 2>&1; then
        warn_msg "$apkname: repack thất bại - giữ APK gốc"
        rm -rf "$tmp"; return 1
    fi
    mv -f "$tmp/out.apk" "$apk"
    log_msg "$apkname: vá $applied dex"
    rm -rf "$tmp"
    return 0
}

# ---------------------------------------------------------------------------
# Vá một jar theo TỪNG dex. Mỗi dex có bảng patch riêng:
#   <base>-classes.json   -> classes.dex
#   <base>-classes2.json  -> classes2.dex ...
#
# Không gộp mọi dex vào một cây smali chung: bản trước gộp rồi patch, nhưng lúc
# smali lại thì mỗi dex build từ cây riêng của nó -> patch bị bỏ hoàn toàn mà
# script vẫn báo thành công. Patch theo từng dex thì cây nào được patch cũng
# chính là cây được build.
# ---------------------------------------------------------------------------
apply_jar_patch() {
    local jar="$1" base="$2"
    local name="${jar##*/}"

    local tmp; tmp=$(mktemp -d "$work_dir/.prechina.XXXXXX") || return 1
    if ! python3 "$TOOLS/apk_dex_patch.py" unpack "$jar" "$tmp" >/dev/null 2>&1; then
        warn_msg "$name: unpack thất bại - bỏ qua"
        rm -rf "$tmp"; return 1
    fi

    local d dexname pj applied=0
    for d in "$tmp"/dex/*.dex; do
        [ -f "$d" ] || continue
        dexname="${d##*/}"; dexname="${dexname%.dex}"
        pj="$PDIR/${base}-${dexname}.json"
        [ -f "$pj" ] || continue

        java -jar "$BSMALI_JAR" d --api 37 "$d" -o "$tmp/sm/$dexname" >/dev/null 2>&1 || {
            warn_msg "$name/$dexname: baksmali lỗi"; rm -rf "$tmp"; return 1; }
        python3 "$TOOLS/apply_patches.py" "$tmp/sm/$dexname" "$pj" || {
            warn_msg "$name/$dexname: patch không áp được đủ - KHÔNG ghi đè jar"
            rm -rf "$tmp"; return 1; }
        java -jar "$SMALI_JAR" a --api 37 "$tmp/sm/$dexname" -o "$d" >/dev/null 2>&1 || {
            warn_msg "$name/$dexname: smali lại lỗi"; rm -rf "$tmp"; return 1; }
        applied=$((applied + 1))
    done

    if [ "$applied" -eq 0 ]; then
        warn_msg "$name: không có bảng patch khớp tên dex - bỏ qua"
        rm -rf "$tmp"; return 0
    fi

    if ! python3 "$TOOLS/apk_dex_patch.py" repack "$jar" "$tmp" "$tmp/out.jar" >/dev/null 2>&1; then
        warn_msg "$name: repack thất bại - giữ jar gốc"
        rm -rf "$tmp"; return 1
    fi
    mv -f "$tmp/out.jar" "$jar"
    log_msg "$name: vá $applied dex"
    rm -rf "$tmp"
    return 0
}

log_msg "PRECHINAFIX: bắt đầu vá bản de-China (69 file / 209 method)"

# ==================== APK ====================
SYSAPK=$(find "$MAIN_FOLDER" -type f -name "MiuiSystemUI.apk" 2>/dev/null | head -n1)
if [ -n "$SYSAPK" ]; then
    apply_dex_patch "$SYSAPK" MiuiSystemUI classes2.dex classes3.dex
else
    warn_msg "ROM không có MiuiSystemUI.apk - bỏ qua"
fi

PKAPK=$(find "$MAIN_FOLDER" -type f -name "PowerKeeper.apk" 2>/dev/null | head -n1)
if [ -n "$PKAPK" ]; then
    apply_dex_patch "$PKAPK" PowerKeeper classes.dex
else
    warn_msg "ROM không có PowerKeeper.apk - bỏ qua"
fi

# Settings: vá TRƯỚC Settings_ROMInformation (chạy trong insupdate.sh). Bước đó
# decode lại chính file này rồi rebuild với branding BugOS, nên 7 method vẫn
# còn. Nếu bước branding fail và giữ APK gốc, patch vẫn không mất.
#
# classes12: nơi chứa 10 class mới của bản vá "About phone kiểu ColorOS"
# (com.kashi.settings.view.*, com.android.settings.kashi.Utils). Bản gốc không
# có classes12 patch nào nên phải thêm vào danh sách này.
SETAPK=$(find "$MAIN_FOLDER" -type f -name "Settings.apk" 2>/dev/null | head -n1)
if [ -n "$SETAPK" ]; then
    apply_dex_patch "$SETAPK" Settings classes2.dex classes3.dex classes4.dex classes12.dex
else
    warn_msg "ROM không có Settings.apk - bỏ qua"
fi

# ==================== JAR ====================
FWPATH=$(find "$MAIN_FOLDER" -type f -name "miui-framework.jar" 2>/dev/null | head -n1)
if [ -n "$FWPATH" ]; then
    apply_jar_patch "$FWPATH" miui-framework
else
    warn_msg "ROM không có miui-framework.jar - bỏ qua"
fi

SVCPATH=$(find "$MAIN_FOLDER" -type f -name "miui-services.jar" 2>/dev/null | head -n1)
if [ -n "$SVCPATH" ]; then
    apply_jar_patch "$SVCPATH" miui-services
else
    warn_msg "ROM không có miui-services.jar - bỏ qua"
fi

log_msg "PRECHINAFIX: xong (nhắc: 5 file đã sai chữ ký, COREPATCH phải chạy sau)"
