#!/bin/bash
# ---------------------------------------------------------------------------
# FCM push notification fix for HyperOS China ROMs
#
# Port of "HyperOS FCM Notification Fix (On-Device Patcher) v1.2" by biplobsd
#   https://github.com/biplobsd/fcm_notification_fix
#
# Upstream is a Magisk module: at install time it patches two system_server
# framework jars on the device and bind-mounts them.  A ROM does not need any
# of that, so we run the same patch engine at build time and ship the jars
# already patched - no root, no module, no bind mounts.
#
# What the four patch vectors do (all verified by the engine itself):
#   V1 services.jar        BroadcastController.broadcastIntentLockedTraced
#                          -> FcmWakeFilter.applyFlags(): keeps FLAG_INCLUDE_
#                             STOPPED_PACKAGES on FCM receives, so push wakes an
#                             app that HyperOS killed.
#   V2 miui-services.jar   GreezeManagerService.isAllowBroadcast
#                          -> thaw C2DM receives while the screen is off.
#   V3 miui-services.jar   GreezeManagerService.triggerGMSLimitAction
#                          -> return-void, i.e. stop quick-freezing GMS.
#   V4 miui-services.jar   BroadcastQueueModernStubImpl.checkApplicationAutoStart
#                          -> Build.IS_INTERNATIONAL_BUILD forced true, so C2DM
#                             is not blocked by the CN autostart policy.
#
# tools/patcher_engine.jar  original engine (dex container).  Used as DATA:
#                           the engine pulls the FcmWakeFilter ClassDef out of it.
# tools/patcher_desktop.jar the same engine converted dex -> class with dex2jar
#                           2.4 so it runs on the build machine's JVM.  It needs
#                           -noverify because dex2jar does not emit stack map
#                           frames and the JVM refuses to load the class without
#                           them.  Engine source of truth is the dex jar above.
#
# Config: the injected filter reads /data/system/fcm_wake.conf and defaults to
# MODE=ALL when the file is absent, so no ROM-side config is required.
# ---------------------------------------------------------------------------
WORK_DIR=$(pwd)
source "$WORK_DIR/functions.sh"
MAIN_FOLDER="$WORK_DIR/build/baserom/images"
SRC_DIR="$WORK_DIR/bin/modfile/UpdateFile/FCM_NotificationFix"
ENGINE="$SRC_DIR/tools/patcher_desktop.jar"
DEXJAR="$SRC_DIR/tools/patcher_engine.jar"

SDK=$(cat "$WORK_DIR/bin/ddevice/sdkLevel.txt" 2>/dev/null | tr -d '\r\n ')
REGION_TYPE=$(cat "$WORK_DIR/bin/ddevice/device_type.txt" 2>/dev/null | tr -d '\r\n ')
[ -z "$SDK" ] && SDK=0

find_jar() {
    local name="$1"; shift
    local p
    for p in "$@"; do
        [ -f "$p" ] && { printf '%s' "$p"; return 0; }
    done
    find "$MAIN_FOLDER" -type f -name "$name" 2>/dev/null | head -n 1
}

SERVICES=$(find_jar services.jar \
    "$MAIN_FOLDER/system/system/framework/services.jar" \
    "$MAIN_FOLDER/system/framework/services.jar")
MIUI_SERVICES=$(find_jar miui-services.jar \
    "$MAIN_FOLDER/system_ext/framework/miui-services.jar" \
    "$MAIN_FOLDER/system/system_ext/framework/miui-services.jar" \
    "$MAIN_FOLDER/system/system/framework/miui-services.jar" \
    "$MAIN_FOLDER/product/framework/miui-services.jar")

# ---- guards -------------------------------------------------------------
if [ ! -f "$ENGINE" ] || [ ! -f "$DEXJAR" ]; then
    warn "FCM: thiếu patch engine trong $SRC_DIR/tools - bỏ qua"
    exit 0
fi

if [ "$SDK" -lt 33 ]; then
    warn "FCM: SDK $SDK < 33, patch chỉ hỗ trợ Android 13+ - bỏ qua"
    exit 0
fi

if [ "$SDK" -ge 37 ]; then
    # Engine chỉ có strategy hyperos/os3/android16/cn. Trên A17 nó sẽ tự reject và
    # ta giữ nguyên jar gốc (an toàn), nhưng log trước để không ai tưởng là đã vá.
    warn "FCM: engine chưa có strategy cho SDK $SDK (chỉ có Android 16) - sẽ bỏ qua an toàn"
fi

if [ "$REGION_TYPE" != "China" ]; then
    warn "FCM: region '$REGION_TYPE' - patch engine chỉ hỗ trợ HyperOS China - bỏ qua"
    exit 0
fi

if [ -z "$SERVICES" ] || [ -z "$MIUI_SERVICES" ]; then
    warn "FCM: không tìm thấy services.jar / miui-services.jar - bỏ qua"
    [ -z "$SERVICES" ] && warn "  thiếu services.jar"
    [ -z "$MIUI_SERVICES" ] && warn "  thiếu miui-services.jar"
    exit 0
fi

mods "FCM: services.jar     -> ${SERVICES#$MAIN_FOLDER/}"
mods "FCM: miui-services.jar -> ${MIUI_SERVICES#$MAIN_FOLDER/}"

# Already patched (framework dex entries are stored uncompressed, so the class
# name is greppable straight out of the jar)
if ! grep -aqm1 FcmWakeFilter "$SERVICES" 2>/dev/null; then
    STOCK=1
else
    STOCK=0
fi

if [ "$STOCK" -eq 0 ]; then
    mods "FCM: jars đã được patch sẵn - bỏ qua"
    exit 0
fi

# ---- run the engine -----------------------------------------------------
OUT="$WORK_DIR/.fcm_patch"
rm -rf "$OUT"
mkdir -p "$OUT"

mods "FCM: đang patch (SDK $SDK, China)..."
java -noverify -cp "$ENGINE" com.hyperos.fcm.patcher.Main \
    --services "$SERVICES" \
    --miui-services "$MIUI_SERVICES" \
    --patcher "$DEXJAR" \
    --out-dir "$OUT" \
    --sdk "$SDK" \
    --os hyperos \
    --region cn > "$OUT/patch.log" 2>&1
rc=$?

# show the engine's checklist in the build log
sed -e 's/^/    /' "$OUT/patch.log" 2>/dev/null | grep -vE '^\s*$'

if [ "$rc" -ne 0 ]; then
    warn "FCM: engine trả về $rc - giữ nguyên jar gốc (ROM vẫn boot bình thường)"
    rm -rf "$OUT"
    exit 0
fi

# ---- verify before touching the images ----------------------------------
fail=""
for f in services.jar miui-services.jar; do
    if [ ! -s "$OUT/$f" ]; then
        fail="thiếu $f"
        break
    fi
    sz=$(wc -c < "$OUT/$f" 2>/dev/null || echo 0)
    if [ "$sz" -lt 1000000 ]; then
        fail="$f quá nhỏ ($sz bytes)"
        break
    fi
    if ! grep -aqm1 FcmWakeFilter "$OUT/$f" 2>/dev/null; then
        fail="$f không chứa FcmWakeFilter"
        break
    fi
done

if [ -n "$fail" ]; then
    warn "FCM: verify thất bại ($fail) - giữ nguyên jar gốc"
    rm -rf "$OUT"
    exit 0
fi

cp -f "$OUT/services.jar" "$SERVICES"
cp -f "$OUT/miui-services.jar" "$MIUI_SERVICES"
rm -rf "$OUT"

mods "FCM: đã patch xong 4/4 vector - ROM sẽ nhận push khi màn hình tắt"
