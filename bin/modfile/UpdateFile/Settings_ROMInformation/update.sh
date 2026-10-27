#!/bin/bash
# ---------------------------------------------------------------------------
# BugOS branding for Settings.apk (+ build.prop OS version)
#
# IMPORTANT - decoded tree layout of APKEditor (bin/apktool/apke.jar):
#
#   <out>/AndroidManifest.xml
#   <out>/resources/package_1/res/...        <-- resources live HERE
#   <out>/resources/package_1/package.json   <-- resource table
#   <out>/smali/...
#   <out>/signatures/                        <-- original signature, restored on build
#
# There is NO <out>/res and NO apktool.yml.  Older versions of this script
# looked for those, so the logo replacement silently never ran.
# ---------------------------------------------------------------------------
WORK_DIR=$(pwd)
source "$WORK_DIR/functions.sh"
MAIN_FOLDER="$WORK_DIR/build/baserom/images"
rom_os=$(cat $WORK_DIR/bin/ddevice/rom_os.txt 2>/dev/null | tr -d '\r\n ')
regionTYPE=$(cat $WORK_DIR/bin/ddevice/device_type.txt 2>/dev/null | tr -d '\r\n ')
base_rom_code=$(cat $WORK_DIR/bin/ddevice/base_rom_code.txt 2>/dev/null | tr -d '\r\n ')
build_date=$(TZ=Asia/Ho_Chi_Minh date +"%y%m%d")

APKEDITOR="java -jar $WORK_DIR/bin/apktool/apke.jar"
repS="python3 $WORK_DIR/bin/strRep.py"
SRC_DIR="$WORK_DIR/bin/modfile/UpdateFile/Settings_ROMInformation"
WORK_ROOT="$WORK_DIR/.settings_patch"

# ===========================================================================
# 1. build.prop branding / OS version
# ===========================================================================
my_props=(
    "$MAIN_FOLDER/system/system/build.prop"
    "$MAIN_FOLDER/system/build.prop"
    "$MAIN_FOLDER/product/etc/build.prop"
    "$MAIN_FOLDER/vendor/build.prop"
    "$MAIN_FOLDER/odm/etc/build.prop"
)

# Lấy version ROM thật từ build.prop (HyperOS trước, MIUI/incremental sau)
rom_version_name=$(grep -h -m1 '^ro\.mi\.os\.version\.name=' "${my_props[@]}" 2>/dev/null | head -n 1 | cut -d= -f2- | tr -d '\r\n ')
[ -z "$rom_version_name" ] && rom_version_name=$(grep -h -m1 '^ro\.mi\.os\.version\.incremental=' "${my_props[@]}" 2>/dev/null | head -n 1 | cut -d= -f2- | tr -d '\r\n ')
[ -z "$rom_version_name" ] && rom_version_name=$(grep -h -m1 '^ro\.build\.version\.incremental=' "${my_props[@]}" 2>/dev/null | head -n 1 | cut -d= -f2- | tr -d '\r\n ')
[ -z "$rom_version_name" ] && rom_version_name="$base_rom_code"
[ -z "$rom_version_name" ] && rom_version_name="BugOS"

# Bỏ hậu tố build dư (3.0.307.0.WPKCNXM.C09 -> 3.0.307.0.WPKCNXM), giữ tối đa 5 thành phần
rom_version_short=$(printf '%s\n' "$rom_version_name" | awk -F. -v OFS=. '{ if (NF > 5) NF = 5; print }')
rom_version_short=${rom_version_short#OS}
# Nếu build.prop đã được brand từ lần trước thì bỏ hậu tố đi, tránh cộng dồn "| BugOS"
rom_version_short=${rom_version_short% | BugOS}
rom_version_short=${rom_version_short%|BugOS}
rom_version_short=${rom_version_short% }
rom_version_display="${rom_version_short} | BugOS"
mods "OS version hiển thị: ${rom_version_display}"

for p in "${my_props[@]}"; do
    [ -f "$p" ] || continue
    sed -i \
        -e '/^ro\.bugos\.version=/d' \
        -e '/^ro\.bugos\.incremental=/d' \
        -e '/^ro\.bugos\.simposcode=/d' \
        -e '/^ro\.bugos\.osversion=/d' \
        -e '/^ro\.mi\.os\.version\.incremental=/d' \
        -e '/^ro\.build\.version\.incremental=/d' \
        -e '/^ro\.system\.build\.version\.incremental=/d' \
        -e '/^ro\.product\.build\.version\.incremental=/d' "$p"

    [ -n "$(tail -c1 "$p")" ] && echo "" >> "$p"

    {
        echo "ro.bugos.version=${rom_version_display}"
        echo "ro.bugos.incremental=${rom_version_display}"
        echo "ro.bugos.simposcode=${rom_version_display}"
        echo "ro.bugos.osversion=${build_date}"
        # Các prop gốc mà Settings đọc cho dòng "OS version"
        echo "ro.mi.os.version.incremental=${rom_version_display}"
        echo "ro.build.version.incremental=${rom_version_display}"
        echo "ro.system.build.version.incremental=${rom_version_display}"
        echo "ro.product.build.version.incremental=${rom_version_display}"
    } >> "$p"
done

# ===========================================================================
# 2. Settings.apk  (logo + OS version)
# ===========================================================================

# Wordmark aspect (viewportWidth / viewportHeight) taken from the asset itself
aspect_of() {
    awk '
        /viewportWidth=/  { gsub(/[^0-9.]/,"",$0); w=$0 }
        /viewportHeight=/ { gsub(/[^0-9.]/,"",$0); h=$0 }
        END { if (h > 0) printf "%.4f", w / h; else print "0" }
    ' "$1"
}

# Build a vector drawable sized to fit inside the box the original asset used.
# Keeps the wordmark aspect ratio (never stretched) and keeps the original width.
make_drawable() {
    local template="$1" out="$2" ow="$3" oh="$4" aspect="$5"
    local nw nh
    ow=${ow//[^0-9.]/}
    oh=${oh//[^0-9.]/}
    read -r nw nh < <(awk -v ow="$ow" -v oh="$oh" -v a="$aspect" 'BEGIN{
        w = (ow + 0 > 0) ? ow : 200
        h = w / a
        if (oh + 0 > 0 && h > oh) { h = oh; w = h * a }
        printf "%.2f %.2f", w, h
    }')
    sed -E \
        -e "s|android:width=\"[^\"]*\"|android:width=\"${nw}dp\"|" \
        -e "s|android:height=\"[^\"]*\"|android:height=\"${nh}dp\"|" \
        "$template" > "$out"
    echo "${nw}x${nh}"
}

patch_settings_apk() {
    local apk="$1" idx="$2"
    local work="$WORK_ROOT/apk$idx"
    local out="$work/decoded"

    rm -rf "$work"
    mkdir -p "$work"

    mods "Settings: Decode: ${apk#$MAIN_FOLDER/}"
    if ! $APKEDITOR d -f -i "$apk" -o "$out" > "$work/decode.log" 2>&1; then
        warn "Settings: Decode FAILED - giữ APK gốc. Log:"
        tail -n 5 "$work/decode.log" 2>/dev/null
        return 1
    fi

    local -a resroots=()
    while IFS= read -r r; do resroots+=("$r"); done < <(find "$out/resources" -maxdepth 2 -type d -name res 2>/dev/null)
    if [ ${#resroots[@]} -eq 0 ]; then
        warn "Settings: Decode ra không có resources/ -> bỏ qua"
        return 1
    fi
    mods "Settings: res roots: ${#resroots[@]}"

    # Chẩn đoán: nếu header là TextView (không phải ảnh) thì chuỗi sẽ nằm ở values
    local hit
    hit=$(grep -rhoE '<string name="[^"]+">[^<]*HyperOS[^<]*</string>' "$out"/resources/*/res/values*/strings.xml 2>/dev/null | head -n 5)
    if [ -n "$hit" ]; then
        warn "Settings: Tìm thấy string HyperOS (header có thể là TextView):"
        printf '%s\n' "$hit" | sed 's/^/    /'
    fi

    local aspect
    aspect=$(aspect_of "$SRC_DIR/ic_hyper_os.xml")
    mods "Settings: Wordmark aspect: $aspect"

    local total=0
    local -a replaced_rel=()

    local resroot
    for resroot in "${resroots[@]}"; do
        local -a cands=()
        local f

        # ---- A. by resource name -------------------------------------------
        while IFS= read -r f; do [ -n "$f" ] && cands+=("$f"); done < <(
            find "$resroot" -type f \( -name "*.xml" -o -name "*.png" -o -name "*.webp" \) 2>/dev/null \
            | grep -Ei '/(drawable|mipmap)[^/]*/[^/]*(hyper_?os|bugos|os_?logo|logo_?os|os_?wordmark|brand_?logo|miui_?logo|mi_?logo|rom_?logo|xiaomi_?logo|device_?info_?logo)[^/]*\.(xml|png|webp)$'
        )

        # ---- B. layout driven: chỉ lấy drawable DẠNG DẢI (wordmark) được
        #         tham chiếu từ layout trang Giới thiệu điện thoại -------------
        if [ ${#cands[@]} -eq 0 ]; then
            local lay name cand w h
            while IFS= read -r lay; do
                while IFS= read -r name; do
                    while IFS= read -r cand; do
                        w=$(grep -oE 'android:width="[0-9.]+dp"' "$cand" 2>/dev/null | head -1 | grep -oE '[0-9.]+')
                        h=$(grep -oE 'android:height="[0-9.]+dp"' "$cand" 2>/dev/null | head -1 | grep -oE '[0-9.]+')
                        [ -n "$w" ] && [ -n "$h" ] || continue
                        awk -v w="$w" -v h="$h" 'BEGIN{exit !(h>0 && w/h >= 2.5)}' || continue
                        cands+=("$cand")
                    done < <(find "$resroot" -type f -name "${name}.xml" -path "*/drawable*/*" 2>/dev/null)
                done < <(grep -oE '@(drawable|mipmap)/[A-Za-z0-9_]+' "$lay" 2>/dev/null | sed 's|.*/||' | sort -u)
            done < <(find "$resroot" -type f -path "*/layout*/*" -name "*.xml" 2>/dev/null \
                     | grep -Ei '(my_device_info|about_phone|device_info|rom_info|os_info|phone_info)')
            if [ ${#cands[@]} -gt 1 ]; then
                mapfile -t cands < <(printf '%s\n' "${cands[@]}" | sort -u)
            fi
            [ ${#cands[@]} -gt 0 ] && mods "Settings: Layout-driven: ${#cands[@]} candidate(s)"
        fi

        # ---- C. content heuristic: wide vector with a huge pathData --------
        if [ ${#cands[@]} -eq 0 ]; then
            warn "Settings: Không khớp theo tên/layout -> dò theo nội dung (vector rộng)"
            while IFS= read -r f; do
                local w h plen
                w=$(grep -oE 'android:width="[0-9.]+dp"' "$f" 2>/dev/null | head -1 | grep -oE '[0-9.]+')
                h=$(grep -oE 'android:height="[0-9.]+dp"' "$f" 2>/dev/null | head -1 | grep -oE '[0-9.]+')
                plen=$(grep -o 'android:pathData="[^"]*"' "$f" 2>/dev/null | wc -c)
                # bỏ qua asset đã được brand từ trước (idempotent)
                grep -aq "106.32 72.58" "$f" 2>/dev/null && continue
                if [ -n "$w" ] && [ -n "$h" ] && [ "$plen" -gt 1500 ] \
                   && awk -v w="$w" -v h="$h" 'BEGIN{exit !(h>0 && w/h >= 3.0 && w >= 60 && w <= 400 && h <= 90)}'; then
                    cands+=("$f")
                fi
            done < <(find "$resroot" -type f -path "*/drawable*/*" -name "*.xml" 2>/dev/null | xargs -r grep -l '<vector' 2>/dev/null)
        fi

        if [ ${#cands[@]} -eq 0 ]; then
            warn "Settings: KHÔNG tìm thấy asset logo. Các drawable xml nghi vấn:"
            find "$resroot" -type f -path "*/drawable*/*" -name "*.xml" 2>/dev/null \
                | grep -Ei '/(hyper|bugos|os_logo|logo|wordmark|brand|miui_|rom_)' \
                | sed 's|.*/res/|  res/|' | sort -u | head -n 30
            continue
        fi

        # ---- replace -------------------------------------------------------
        for f in "${cands[@]}"; do
            local base rel kind template
            base=$(basename "$f")
            rel="res/${f#$resroot/}"

            case "$base" in
                *.xml) kind="vector" ;;
                *)     warn "Settings: $rel là ảnh raster - bỏ qua (cần PNG cùng kích thước)"; continue ;;
            esac

            # dark / night variants get the all-white mark
            template="$SRC_DIR/ic_hyper_os.xml"
            case "$f" in
                *white*|*night*|*dark*|*_w.xml) template="$SRC_DIR/ic_hyper_os_white.xml" ;;
            esac

            local ow oh size
            ow=$(grep -oE 'android:width="[^"]+"' "$f" 2>/dev/null | head -1 | sed 's/.*="//;s/"$//')
            oh=$(grep -oE 'android:height="[^"]+"' "$f" 2>/dev/null | head -1 | sed 's/.*="//;s/"$//')
            size=$(make_drawable "$template" "$f" "$ow" "$oh" "$aspect")
            mods "Settings: replaced $rel  (${ow:-?}x${oh:-?} -> ${size}dp)"
            replaced_rel+=("$rel")
            total=$((total + 1))
        done
    done

    if [ "$total" -eq 0 ]; then
        warn "Settings: Không thay được asset nào - giữ APK gốc"
        return 1
    fi

    # ---- smali: OS version ------------------------------------------------
    local p1
    p1=$(find "$out" -type f -name "MiuiAboutPhoneUtils.smali" 2>/dev/null | head -n 1)
    if [ -n "$p1" ] && [ -f "$p1" ]; then
        local ini before after
        for ini in getMiuiVersionInCard getRoXmsVersion getXmsVersion getSimpleOSVersion; do
            [ -f "$SRC_DIR/$ini.ini" ] || continue
            before=$(md5sum "$p1" | cut -d' ' -f1)
            $repS "$SRC_DIR/$ini.ini" "$p1" >/dev/null 2>&1
            after=$(md5sum "$p1" | cut -d' ' -f1)
            if [ "$before" = "$after" ]; then
                warn "Settings: smali patch '$ini' KHÔNG khớp (method đã đổi?)"
            else
                mods "Settings: smali patch '$ini' OK"
            fi
        done
    else
        warn "Settings: Không thấy MiuiAboutPhoneUtils.smali"
    fi

    # ---- rebuild ----------------------------------------------------------
    mods "Settings: Rebuild..."
    if ! $APKEDITOR b -f -i "$out" -o "$work/new.apk" > "$work/build.log" 2>&1 || [ ! -s "$work/new.apk" ]; then
        warn "Settings: Rebuild FAILED - giữ APK gốc"
        tail -n 5 "$work/build.log" 2>/dev/null
        return 1
    fi

    # ---- verify the replacement really landed inside the new APK ----------
    # NOTE: resource file names are often obfuscated inside the APK (res/hu.xml),
    # so we cannot look the entry up by its decoded name.  The pathData string is
    # stored verbatim in the binary XML string pool -> scan every res xml instead.
    local ok=0
    ok=$(unzip -p "$work/new.apk" 'res/*.xml' 2>/dev/null | grep -ac "M 106.32 72.58 Q 99.29 80.61")
    if [ "${ok:-0}" -eq 0 ]; then
        warn "Settings: Verify thất bại (không thấy marker trong APK mới) - giữ APK gốc"
        return 1
    fi

    cp -f "$work/new.apk" "$apk"
    mods "Settings: DONE - $ok/$total asset(s) verified in ${apk#$MAIN_FOLDER/}"
    rm -rf "$work"
    return 0
}

idx=0
found=0
while IFS= read -r apk; do
    [ -f "$apk" ] || continue
    found=$((found + 1))
    idx=$((idx + 1))
    patch_settings_apk "$apk" "$idx"
done < <(find "$MAIN_FOLDER" -type f -name "Settings.apk" 2>/dev/null)

[ "$found" -eq 0 ] && warn "Không tìm thấy Settings.apk trong images"

rm -rf "$WORK_ROOT"
mods "BugOS ROM Information Integration Done!"
