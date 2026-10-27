#!/bin/bash
# ---------------------------------------------------------------------------
# Google services ON by default (China ROM)
#
# Two independent gates:
#   1. ro.miui.has_gmscore  - the ROM usually already ships "=0" and ro.* props
#      are IMMUTABLE: the first occurrence wins, so appending "=1" at the end of
#      build.prop does nothing.  We rewrite the existing line instead.
#   2. the "谷歌基础服务 / Google basic services" switch itself, which lives in
#      its own tiny system app (com.miui.googlebase, ...ui.GmsCoreSettings) and
#      reads its state from a Settings provider key with an "off" default.
#      We discover that key from the decoded APK and flip the default.
#
# APKEditor (bin/apktool/apke.jar) decoded tree:
#   <out>/resources/<pkg>/res/...   <out>/smali/...   <out>/signatures/
# ---------------------------------------------------------------------------
WORK_DIR=$(pwd)
source "$WORK_DIR/functions.sh"
MAIN_FOLDER="$WORK_DIR/build/baserom/images"
APKEDITOR="java -jar $WORK_DIR/bin/apktool/apke.jar"
SRC_DIR="$WORK_DIR/bin/modfile/UpdateFile/Google_DefaultOn"
PY="python3 $SRC_DIR/gms_default.py"
WORK_ROOT="$WORK_DIR/.gms_patch"

set_prop() {
    local file="$1" key="$2" val="$3"
    [ -f "$file" ] || return 0
    local re
    re=$(printf '%s' "$key" | sed 's/\./\\./g')
    if grep -q "^${re}=" "$file"; then
        local cur
        cur=$(grep -m1 "^${re}=" "$file" | cut -d= -f2-)
        if [ "$cur" = "$val" ]; then
            return 0
        fi
        sed -i "s|^${re}=.*|${key}=${val}|" "$file"
        mods "prop fixed: ${key} ${cur} -> ${val}  ($(basename "$(dirname "$file")")/$(basename "$file"))"
    else
        [ -n "$(tail -c1 "$file")" ] && echo "" >> "$file"
        echo "${key}=${val}" >> "$file"
        mods "prop added: ${key}=${val}  ($(basename "$(dirname "$file")")/$(basename "$file"))"
    fi
}

# ===========================================================================
# 1. build.prop: force has_gmscore, drop a stale "=0"
# ===========================================================================
prop_count=0
while IFS= read -r p; do
    [ -f "$p" ] || continue
    prop_count=$((prop_count + 1))
    set_prop "$p" "ro.miui.has_gmscore" "1"
done < <(find "$MAIN_FOLDER" -maxdepth 4 -type f -name "build.prop" 2>/dev/null)

if [ "$prop_count" -eq 0 ]; then
    warn "Không tìm thấy build.prop nào trong images"
else
    mods "Đã quét ${prop_count} build.prop cho ro.miui.has_gmscore"
fi

# ===========================================================================
# 2. report what the ROM actually ships
# ===========================================================================
gmscore=$(find "$MAIN_FOLDER" -type d -name "GmsCore" 2>/dev/null | head -n 1)
if [ -n "$gmscore" ]; then
    mods "GmsCore có trong ROM: ${gmscore#$MAIN_FOLDER/}"
else
    warn "KHÔNG thấy thư mục GmsCore (com.google.android.gms) trong images"
    find "$MAIN_FOLDER" -type f -name "*.apk" 2>/dev/null \
        | grep -Ei '(gms|google)' | sed 's|.*/images/|  |' | head -n 15
fi

# ===========================================================================
# 3. patch the Google basic services switch
# ===========================================================================
mapfile -t gb_apks < <(find "$MAIN_FOLDER" -type f -name "*.apk" 2>/dev/null \
    | grep -Ei '/(googlebase|google_base|miuigooglebase|GoogleBase)[^/]*/')

if [ ${#gb_apks[@]} -eq 0 ]; then
    warn "Không thấy APK Google basic services (com.miui.googlebase) trong images"
    warn "Có thể HyperOS 3 đặt switch này trong Settings.apk - bỏ qua bước patch switch"
    rm -rf "$WORK_ROOT"
    mods "Google default-on: chỉ áp dụng phần build.prop"
    exit 0
fi

idx=0
for apk in "${gb_apks[@]}"; do
    idx=$((idx + 1))
    work="$WORK_ROOT/apk$idx"
    out="$work/decoded"
    rm -rf "$work"
    mkdir -p "$work"

    mods "Google basic services: ${apk#$MAIN_FOLDER/}"
    if ! $APKEDITOR d -f -i "$apk" -o "$out" > "$work/decode.log" 2>&1; then
        warn "Decode thất bại - bỏ qua. $(tail -n 3 "$work/decode.log" | tr '\n' ' ')"
        continue
    fi

    found=$($PY find "$out" 2>&1)
    printf '%s\n' "$found" | sed 's/^/    /'

    keys=$(printf '%s\n' "$found" | grep -m1 '^KEYS' | sed 's/^KEYS[^:]*: *//')
    if [ -z "$keys" ] || [ "$keys" = "none" ]; then
        warn "Không dò được key của switch -> giữ nguyên APK gốc"
        continue
    fi

    # only flip keys that really look GMS related, cap the blast radius
    keys=$(printf '%s' "$keys" | tr ',' '\n' | grep -Ei 'gms|google' | head -n 4 | paste -sd, -)
    if [ -z "$keys" ]; then
        warn "Key dò được không liên quan GMS -> bỏ qua"
        continue
    fi
    mods "Patch default=1 cho key: $keys"

    if ! $PY patch "$out" "$keys" > "$work/patch.log" 2>&1; then
        warn "Patch không áp được: $(cat "$work/patch.log")"
        continue
    fi
    mods "$(cat "$work/patch.log")"

    mods "Rebuild..."
    if ! $APKEDITOR b -f -i "$out" -o "$work/new.apk" > "$work/build.log" 2>&1 || [ ! -s "$work/new.apk" ]; then
        warn "Rebuild thất bại - giữ APK gốc"
        continue
    fi

    # sanity: the rebuilt apk must still be a readable zip with a resource table
    if ! unzip -l "$work/new.apk" 2>/dev/null | grep -q "resources.arsc"; then
        warn "APK mới không có resources.arsc - giữ APK gốc"
        continue
    fi

    cp -f "$work/new.apk" "$apk"
    mods "DONE: đã bật mặc định trong ${apk#$MAIN_FOLDER/}"
done

rm -rf "$WORK_ROOT"
mods "Google default-on done!"
