# kashi_pk_patches.sh - PowerKeeper performance patches (shared by the module and kashi_apply_tree.sh)
# POSIX sh (Magisk/KernelSU busybox ash, bash, mksh). Needs: find, awk, sed, grep.
# Patches are matched by class file name + exact method signature / exact string,
# never by line numbers, so they keep working on other PowerKeeper versions.
# Usage: . kashi_pk_patches.sh ; kashi_pk_patch_all <decompiled_dir>
# Set KASHI_PK_LOG to a function name to receive log lines (default: echo).

KASHI_PK_OK=0
KASHI_PK_FAIL=0
KASHI_PK_FAILED=""

kashi_pk_log() {
    if [ -n "$KASHI_PK_LOG" ]; then "$KASHI_PK_LOG" "$*"; else echo "$*"; fi
}

kashi_pk_result() { # <ok 0|1> <label>
    if [ "$1" = 0 ]; then
        KASHI_PK_OK=$((KASHI_PK_OK + 1))
        kashi_pk_log "   + $2"
    else
        KASHI_PK_FAIL=$((KASHI_PK_FAIL + 1))
        KASHI_PK_FAILED="$KASHI_PK_FAILED
     $2"
        kashi_pk_log "   ! $2 (not found, skipped)"
    fi
}

# kashi_pk_find <dir> <path under smali/classesN, e.g. com/miui/powerkeeper/x/Y.smali>
kashi_pk_find() {
    for _kd in "$1"/smali/classes*; do
        [ -f "$_kd/$2" ] && { echo "$_kd/$2"; return 0; }
    done
    return 1
}

# kashi_pk_remake <file> <name(sig)ret> <body>  - replace a method body, keep its .method line
kashi_pk_remake() {
    [ -f "$1" ] || return 1
    KASHI_SIG="$2" KASHI_BODY="$3" awk '
        BEGIN { sig = ENVIRON["KASHI_SIG"]; body = ENVIRON["KASHI_BODY"]; n = 0; skip = 0 }
        skip && /^\.end method/ { print; skip = 0; next }
        skip { next }
        /^\.method / && $NF == sig { print; print body; skip = 1; n++; next }
        { print }
        END { exit (n == 0) }
    ' "$1" > "$1.kashi_tmp" && mv -f "$1.kashi_tmp" "$1" && return 0
    rm -f "$1.kashi_tmp"
    return 1
}

# kashi_pk_sub <file> <sed expression> <grep -F text that must exist before>
kashi_pk_sub() {
    [ -f "$1" ] || return 1
    grep -qF -- "$3" "$1" || return 1
    sed -i "$2" "$1"
}

# kashi_pk_remake_str <file> <sig suffix e.g. (Ljava/lang/String;)V> <text inside the method> <body>
# For obfuscated classes: picks the method by signature + a string it contains, keeps its .method line.
kashi_pk_remake_str() {
    [ -f "$1" ] || return 1
    KASHI_SUF="$2" KASHI_TXT="$3" KASHI_BODY="$4" awk '
        BEGIN { suf = ENVIRON["KASHI_SUF"]; txt = ENVIRON["KASHI_TXT"]; body = ENVIRON["KASHI_BODY"]; n = 0; inm = 0 }
        function flush() { for (i = 1; i <= cnt; i++) print buf[i] }
        /^\.method / && !inm {
            s = $NF
            if (length(s) >= length(suf) && substr(s, length(s) - length(suf) + 1) == suf) { inm = 1; cnt = 0; hit = 0 }
        }
        inm {
            buf[++cnt] = $0
            if (index($0, txt)) hit = 1
            if (/^\.end method/) {
                if (hit) { print buf[1]; print body; print buf[cnt]; n++ } else flush()
                inm = 0
            }
            next
        }
        { print }
        END { exit (n == 0) }
    ' "$1" > "$1.kashi_tmp" && mv -f "$1.kashi_tmp" "$1" && return 0
    rm -f "$1.kashi_tmp"
    return 1
}

# kashi_pk_grep_class <dir> <text1> <text2>  - first smali file containing both texts
kashi_pk_grep_class() {
    grep -rlF -- "$2" "$1"/smali 2>/dev/null | while read -r _g; do
        grep -qF -- "$3" "$_g" && { echo "$_g"; break; }
    done
}

KASHI_VOID='    .locals 0

    return-void'
KASHI_ZERO='    .locals 1

    const/4 v0, 0x0

    return v0'

kashi_pk_patch_all() {
    _d="$1"
    _p=com/miui/powerkeeper
    KASHI_PK_OK=0; KASHI_PK_FAIL=0; KASHI_PK_FAILED=""

    kashi_pk_log "- Refresh rate (smoothness)"
    _f=$(kashi_pk_find "$_d" "$_p/statemachine/DisplayFrameSetting.smali")
    # All PowerKeeper refresh-rate requests (60 Hz app lists, video/idle drops, Game Turbo caps,
    # thermal caps) go through these three methods -> the display keeps the user's setting.
    kashi_pk_remake "$_f" 'setScreenEffect(Ljava/lang/String;II)V' "$KASHI_VOID"; kashi_pk_result $? "DisplayFrameSetting.setScreenEffect(String,int,int)"
    kashi_pk_remake "$_f" 'setScreenEffectInternal(IILjava/lang/String;)V' "$KASHI_VOID"; kashi_pk_result $? "DisplayFrameSetting.setScreenEffectInternal"
    kashi_pk_remake "$_f" 'setScreenEffect(II)V' "$KASHI_VOID"; kashi_pk_result $? "DisplayFrameSetting.setScreenEffect(int,int)"
    # Video apps in cloud dfps_group get "platform dfps cust" (panel drops to the video frame rate)
    _f=$(kashi_pk_find "$_d" "$_p/statemachine/DisplayDfpsHandler.smali")
    kashi_pk_remake "$_f" 'onForegroundChanged(Lmiui/process/ForegroundInfo;)V' "$KASHI_VOID"; kashi_pk_result $? "DisplayDfpsHandler: no video dynamic refresh"
    # Thermal display code from thermal_message/temp_state -> 0 (= no refresh-rate cap when hot)
    _f=$(kashi_pk_find "$_d" "$_p/feedbackcontrol/ThermalManager.smali")
    kashi_pk_remake "$_f" 'getDisplayCtrlCode()I' "$KASHI_ZERO"; kashi_pk_result $? "ThermalManager.getDisplayCtrlCode -> 0"

    kashi_pk_log "- Performance"
    # Battery saver writes a CPU frequency cap to /sys/powersave/limit_buf. Pointing the path at a
    # node that does not exist makes prepareCpuInfo() skip the feature (mDefaultSocLimit = null).
    # Other battery-saver savings stay.
    _f=$(kashi_pk_find "$_d" "$_p/statemachine/PowerSaveModeHandler.smali")
    kashi_pk_sub "$_f" 's#"/sys/powersave/limit_buf"#"/sys/powersave/kashi_limit_buf_off"#g' '"/sys/powersave/limit_buf"'
    kashi_pk_result $? "PowerSaveModeHandler: no battery-saver CPU cap"

    kashi_pk_log "- Hidden features"
    # *#*#76937#*#* cloud info page: stock only on debuggable or non-stable builds
    _f=$(kashi_pk_find "$_d" "$_p/cloudcontrol/CloudUpdateReceiver.smali")
    if [ -n "$_f" ] && grep -q '"76937"' "$_f"; then
        kashi_pk_sub "$_f" 's#sget-boolean \([pv][0-9]*\), Lmiui/os/Build;->IS_DEBUGGABLE:Z#const/16 \1, 0x1#' 'Lmiui/os/Build;->IS_DEBUGGABLE:Z'
        kashi_pk_result $? "CloudUpdateReceiver: *#*#76937#*#* on all builds"
    else
        kashi_pk_result 1 "CloudUpdateReceiver: *#*#76937#*#* on all builds"
    fi

    kashi_pk_log "- Security"
    # miui.intent.action.POWERKEEPER_CLOUD_TEST is registered exported with no permission and lets
    # any app replace the cloud policy URLs -> handler disabled
    _f=$(kashi_pk_find "$_d" "$_p/cloudcontrol/CloudUpdateHideMode.smali")
    kashi_pk_remake "$_f" 'setTestFunc(Landroid/content/Context;Landroid/content/Intent;)V' "$KASHI_VOID"; kashi_pk_result $? "CloudUpdateHideMode.setTestFunc disabled"

    kashi_pk_log "- Patched: $KASHI_PK_OK, skipped: $KASHI_PK_FAIL"
    # FPS patches are the core of the mod: fail if none of them applied
    [ "$KASHI_PK_OK" -gt 0 ]
}

# ---------------------------------------------------------------- Joyose (com.xiaomi.joyose)
# Usage: kashi_jy_patch_all <decompiled_dir>
kashi_jy_patch_all() {
    _d="$1"
    KASHI_PK_OK=0; KASHI_PK_FAIL=0; KASHI_PK_FAILED=""

    kashi_pk_log "- Game FPS (Joyose)"
    # FCController: on game start Joyose reads a per-game (layer, value) pair from its cloud game
    # config and caps that game's frames with "service call SurfaceFlinger 31204 s16 <layer> i32 <v>".
    # Start method -> no-op (the stop method stays, it only clears a cap).
    # Joyose's display refresh-rate requests go through PowerKeeper and are already blocked there.
    _f=$(kashi_pk_grep_class "$_d" 'service call SurfaceFlinger 31204 s16 "' '"start FC"')
    kashi_pk_remake_str "$_f" '(Ljava/lang/String;Ljava/lang/Integer;)V' '"start FC"' "$KASHI_VOID"
    kashi_pk_result $? "Joyose FCController: no per-game frame cap"

    kashi_pk_log "- Patched: $KASHI_PK_OK, skipped: $KASHI_PK_FAIL"
    [ "$KASHI_PK_OK" -gt 0 ]
}
