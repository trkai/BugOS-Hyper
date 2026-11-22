#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
# ---------------------------------------------------------------------------
# FEATURE_UNLOCK - mở khoá giới hạn + bỏ chặn trên OS4/A17.
#
# Tách khỏi PRECHINAFIX vì mục đích khác hẳn:
#   PRECHINAFIX  vá BỘ MÁY HỆ THỐNG (thông báo, telemetry, de-China)
#   FEATURE_UNLOCK vá TÍNH NĂNG NGƯỜI DÙNG (chụp màn hình, FPS, cửa sổ nổi,
#                Android/data, mua hàng theme/vault, SetupWizard)
#
# Cùng cơ chế: bảng patch method JSON (92 KB) sinh bằng gen_patches.py, áp lúc
# build bằng apply_patches.py, đóng gói bằng apk_dex_patch.py.
#
# 38 method / 22 file, đối chiếu từ diff smali giữa "chưa vá" và "đã vá" do
# TREE tool sinh trên base OS4 annibale:
#
#   ExternalStorageProvider.apk        3 method  mở Android/data + obb
#     isRestrictedPath                 -> return false
#     shouldBlockDirectoryFromTree     -> return false
#     shouldHideDocument               -> return false
#
#   PowerKeeper.apk                    5 method  bỏ giới hạn FPS/nhiệt
#     DisplayFrameSetting.setScreenEffect(II)V
#     DisplayFrameSetting.setScreenEffect(Ljava/lang/String;II)V
#     DisplayFrameSetting.setScreenEffectInternal  -> return-void
#     ThermalManager.displayControl    -> return-void
#     ThermalManager.getDisplayCtrlCode-> return 0
#
#   services.jar                       8 method  chụp màn hình + hộp thoại lỗi
#     DevicePolicyCacheImpl.isScreenCaptureAllowed     -> true
#     DevicePolicyManagerService.getScreenCaptureDisabled -> false
#     DevicePolicyManagerService.setScreenCaptureDisabled -> return-void
#     ActivityTaskManagerService.register/unregisterScreenCaptureObserver -> void
#     ActivityTaskManagerService$LocalService.showSystemReadyErrorDialogsIfNeeded -> void
#     WindowState.isSecureLocked       -> false
#     WindowState.setSecureLocked      -> return-void
#
#   miui-services.jar                  7 method
#     MiuiRefreshRatePolicy.shouldDisableAospCameraPolicy  -> true (bỏ 60Hz camera)
#     MiuiFreeFormStackDisplayStrategy.getMaxMiuiFreeFormStackCount -> 4 cửa sổ
#     WindowManagerServiceImpl.notAllowCaptureDisplay + lambda$notAllowCaptureDisplay$14
#     ActivityManagerServiceImpl.ensureDeviceProvisioned  -> ép quốc tế (bỏ SetupWizard)
#
#   miui-framework.jar                 4 method
#     ThemeReceiver.validateTheme      -> return-void (bỏ xác thực theme)
#     MiuiMultiWindowAdapter.getFreeformBlackList(+FromCloud) -> rỗng
#
#   MIUIThemeManager.apk               7 method  mở khoá mua hàng
#     MiuiUtils.t/wvg, OnlineResourceDetailPresenter.ld6/s,
#     WidgetDetailFragment.cp/mq, MamlDrmUtilKt.isLegal
#     (6 method dùng kiểu CHÈN const/4 v0,0x1 -> return v0 lên đầu method)
#
#   MIUISecurityCenter.apk             3 method
#     InterceptPermissionFragment.g0   -> 0 (bỏ chặn 10 giây)
#     DeviceUtil.<clinit>              -> ép IS_INTERNATIONAL_BUILD
#     BatteryData.add
#
#   Provision.apk                      1 method  bật GMS
#     Utils.setGmsAppEnabledStateForCn -> ép IS_INTERNATIONAL_BUILD
#
# THỨ TỰ: chạy NGAY TRƯỚC patchpackage.sh (COREPATCH). COREPATCH ghi đè cả 4
# jar nên patch phải nằm sẵn trong bản nó đọc vào. Cũng phải SAU PRECHINAFIX để
# hai bộ patch cùng tồn tại trong một lần decompile.
#
# CẢNH BÁO CHỮ KÝ: 6 APK sau khi vá bị sai chữ ký. Chỉ nạp được nhờ COREPATCH.
# ---------------------------------------------------------------------------

work_dir=$(pwd)
[ -f "$work_dir/functions.sh" ] && source "$work_dir/functions.sh"

MAIN_FOLDER="$work_dir/build/baserom/images"
PDIR="$work_dir/bin/package/FEATURE_UNLOCK/patches"
TOOLS="$work_dir/bin/tools"

log_msg() {
    if type patch &>/dev/null; then patch "$1"
    elif type mods &>/dev/null; then mods "$1"
    elif type info &>/dev/null; then info "$1"
    else echo "[FEATURE_UNLOCK] $1"; fi
}
warn_msg() {
    if type warn &>/dev/null; then warn "$1"
    else echo "[FEATURE_UNLOCK][WARN] $1"; fi
}

[ -d "$MAIN_FOLDER" ] || { warn_msg "chưa có images - bỏ qua"; exit 0; }
[ -f "$TOOLS/apply_patches.py" ] || { warn_msg "thiếu apply_patches.py"; exit 1; }
[ -f "$TOOLS/apk_dex_patch.py" ] || { warn_msg "thiếu apk_dex_patch.py"; exit 1; }

BSMALI_JAR="$work_dir/bin/apktool/baksmaliv2.jar"
SMALI_JAR="$work_dir/bin/apktool/smaliv2.jar"
[ -f "$BSMALI_JAR" ] || { warn_msg "thiếu $BSMALI_JAR"; exit 1; }
[ -f "$SMALI_JAR" ]  || { warn_msg "thiếu $SMALI_JAR"; exit 1; }

command -v java >/dev/null || { warn_msg "không có java - bỏ qua"; exit 0; }
command -v python3 >/dev/null || { warn_msg "không có python3 - bỏ qua"; exit 0; }

# ---------------------------------------------------------------------------
# vá một APK/jar: unpack 1 lần, vá nhiều dex, repack 1 lần.
#
# apply_target <file> <ten-base> <dex_name> [...]
#   bảng patch tương ứng: patches/<ten-base>-<dex_name>.json
#
# Bỏ qua an toàn nếu ROM không có file đó (ví dụ bản Global không có Joyose).
# ---------------------------------------------------------------------------
apply_target() {
    local target="$1" base="$2"; shift 2
    local tname="${target##*/}"

    # Kiểm tra có ít nhất một bảng patch tồn tại, tránh unpack vô ích
    local d dexname pj any=0
    for d in "$@"; do
        dexname="${d%.dex}"
        [ -f "$PDIR/${base}-${dexname}.json" ] && any=1
    done
    [ "$any" -eq 1 ] || { warn_msg "$tname: không có bảng patch - bỏ qua"; return 0; }

    local tmp; tmp=$(mktemp -d "$work_dir/.featunlock.XXXXXX") || return 1

    if ! python3 "$TOOLS/apk_dex_patch.py" unpack "$target" "$tmp" >/dev/null 2>&1; then
        warn_msg "$tname: unpack thất bại - bỏ qua"
        rm -rf "$tmp"; return 1
    fi

    local applied=0
    for d in "$@"; do
        dexname="${d%.dex}"
        pj="$PDIR/${base}-${dexname}.json"
        [ -f "$pj" ] || continue
        [ -f "$tmp/dex/$d" ] || { warn_msg "$tname: không có $d"; continue; }

        java -jar "$BSMALI_JAR" d --api 37 "$tmp/dex/$d" -o "$tmp/sm/$dexname" >/dev/null 2>&1 || {
            warn_msg "$tname/$d: baksmali lỗi"; rm -rf "$tmp"; return 1; }

        python3 "$TOOLS/apply_patches.py" "$tmp/sm/$dexname" "$pj" || {
            warn_msg "$tname/$d: patch không áp được đủ - KHÔNG ghi đè"
            rm -rf "$tmp"; return 1; }

        java -jar "$SMALI_JAR" a --api 37 "$tmp/sm/$dexname" -o "$tmp/dex/$d" >/dev/null 2>&1 || {
            warn_msg "$tname/$d: smali lại lỗi"; rm -rf "$tmp"; return 1; }

        applied=$((applied + 1))
    done

    if [ "$applied" -eq 0 ]; then
        warn_msg "$tname: không vá được dex nào"
        rm -rf "$tmp"; return 0
    fi

    # đuôi giữ nguyên để apk_dex_patch ghi đúng tên entry
    local out="$tmp/out.${target##*.}"
    if ! python3 "$TOOLS/apk_dex_patch.py" repack "$target" "$tmp" "$out" >/dev/null 2>&1; then
        warn_msg "$tname: repack thất bại - giữ bản gốc"
        rm -rf "$tmp"; return 1
    fi
    mv -f "$out" "$target"
    log_msg "$tname: vá $applied dex"
    rm -rf "$tmp"
    return 0
}

log_msg "FEATURE_UNLOCK: bắt đầu (38 method / 22 file)"

find_first() { find "$MAIN_FOLDER" -type f -name "$1" 2>/dev/null | head -n1; }

# ==================== APK ====================
T=$(find_first "ExternalStorageProvider.apk")
[ -n "$T" ] && apply_target "$T" ExternalStorageProvider classes.dex \
             || warn_msg "ROM không có ExternalStorageProvider.apk"

T=$(find_first "PowerKeeper.apk")
[ -n "$T" ] && apply_target "$T" PowerKeeper classes.dex \
             || warn_msg "ROM không có PowerKeeper.apk"

T=$(find_first "MIUIThemeManager.apk")
[ -n "$T" ] && apply_target "$T" MIUIThemeManager classes2.dex classes3.dex \
             || warn_msg "ROM không có MIUIThemeManager.apk"

T=$(find_first "MIUISecurityCenter.apk")
[ -n "$T" ] && apply_target "$T" MIUISecurityCenter classes3.dex \
             || warn_msg "ROM không có MIUISecurityCenter.apk"

T=$(find_first "Provision.apk")
[ -n "$T" ] && apply_target "$T" Provision classes.dex \
             || warn_msg "ROM không có Provision.apk"

# ==================== JAR ====================
T=$(find_first "miui-framework.jar")
[ -n "$T" ] && apply_target "$T" miui-framework classes.dex \
             || warn_msg "ROM không có miui-framework.jar"

T=$(find_first "miui-services.jar")
[ -n "$T" ] && apply_target "$T" miui-services classes.dex \
             || warn_msg "ROM không có miui-services.jar"

T=$(find_first "services.jar")
[ -n "$T" ] && apply_target "$T" services classes2.dex classes4.dex \
             || warn_msg "ROM không có services.jar"

log_msg "FEATURE_UNLOCK: xong (nhắc: 6 APK đã sai chữ ký, COREPATCH phải chạy sau)"
