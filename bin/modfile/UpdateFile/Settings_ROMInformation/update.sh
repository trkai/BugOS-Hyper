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
#
# LOGO - hai chế độ:
#   PNG (mặc định, đang dùng): logo_light.png + logo_dark.png là artwork thật
#     của BugOS. Script ghi .png vào đúng thư mục, ĐÚNG TÊN resource của asset
#     gốc rồi xoá .xml - id drawable không đổi nên code/layout không cần sửa.
#     Biến thể tối (drawable-night*/tên có white|dark) nhận logo_dark.png.
#     Hai file sinh từ "Logo Xiaomi BugOS chính thức nền trắng.png": nền trắng
#     được tách thành alpha, crop sát mực, scale về đúng bề rộng 3094px của
#     asset gốc (giữ nguyên kích thước intrinsic mà layout đang dựa vào).
#     Bản tối = bản sáng đổi các pixel trung tính sang trắng, giữ nguyên cam.
#   VECTOR (dự phòng): nếu thiếu logo_light.png thì dùng ic_hyper_os*.xml như cũ.
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
    "$MAIN_FOLDER/system_ext/etc/build.prop"
    "$MAIN_FOLDER/product/etc/build.prop"
    "$MAIN_FOLDER/vendor/build.prop"
    "$MAIN_FOLDER/odm/etc/build.prop"
)

# Lấy version ROM.
#
# NGUỒN CHÍNH là base_rom_code - chuỗi lấy từ TÊN FILE ROM, ví dụ
#   annibale-ota_full-OS3.0.307.0.WPKCNXM-user-16.0-....zip  ->  OS3.0.307.0.WPKCNXM
# Đây đúng là chuỗi mà trang Giới thiệu điện thoại hiển thị ở dòng "Phiên bản OS".
#
# Trước đây lấy từ build.prop trước, và trên ROM thật nó ra
#   "16OS3.1.260716.235326947.QCPECN"   (sai hoàn toàn)
# vì ro.mi.os.version.incremental của bản build này không cùng định dạng.
# Prop chỉ còn là fallback, và phải qua bước kiểm tra định dạng.
rom_version_name=""
rom_version_src="base_rom_code (tên file ROM)"

case "$base_rom_code" in
    ""|Unknown|unknown|YourDevice) ;;
    *) rom_version_name="$base_rom_code" ;;
esac

# Fallback: build.prop, chỉ nhận giá trị có dạng số phiên bản (3.0.307.0...)
if [ -z "$rom_version_name" ]; then
    for key in ro.mi.os.version.name ro.mi.os.version.incremental ro.build.version.incremental; do
        cand=$(grep -h -m1 "^${key}=" "${my_props[@]}" 2>/dev/null | head -n 1 | cut -d= -f2- | tr -d '\r\n ')
        cand=${cand#OS}
        if printf '%s' "$cand" | grep -qE '^[0-9]+\.[0-9]+'; then
            rom_version_name="$cand"
            rom_version_src="build.prop $key"
            break
        fi
    done
fi

[ -z "$rom_version_name" ] && { rom_version_name="BugOS"; rom_version_src="mặc định"; }

# Bỏ hậu tố build dư (3.0.307.0.WPKCNXM.C09 -> 3.0.307.0.WPKCNXM), giữ tối đa 5 thành phần
rom_version_short=$(printf '%s\n' "$rom_version_name" | awk -F. -v OFS=. '{ if (NF > 5) NF = 5; print }')
rom_version_short=${rom_version_short#OS}
# Nếu build.prop đã được brand từ lần trước thì bỏ hậu tố đi, tránh cộng dồn "| BugOS"
rom_version_short=${rom_version_short% | BugOS}
rom_version_short=${rom_version_short%|BugOS}
rom_version_short=${rom_version_short% }
rom_version_display="${rom_version_short} | BugOS"
mods "OS version hiển thị: ${rom_version_display}  <- ${rom_version_src}"

# ---------------------------------------------------------------------------
# Chuỗi cho dòng "Phiên bản OS" (mục Giới thiệu điện thoại).
#
# Dòng đó do MiuiAboutPhoneUtils.getOsVersionCode() dựng: đọc
# ro.mi.os.version.incremental rồi cắt "OS" ở đầu -> "4.0.5.0.XPKCNXM".
# Đuôi XPKCNXM chỉ là mã vùng+model của Xiaomi, không mang thêm thông tin gì
# cho người dùng, nên thay bằng <region><ddmmyy>:
#
#     OS4.0.5.0.XPKCNXM  ->  OS4.0.5.0.CN041126
#
# Phần đầu (4.0.5.0) lấy từ chính tên ROM, nên bản sau tự đổi theo.
# KHÔNG đụng ro.mi.os.version.incremental / ro.build.version.incremental:
# ro.build.fingerprint được init ghép từ prop sau, sửa vào là hỏng định dạng.
# Giá trị chỉ đi qua prop riêng ro.bugos.osversioncode + patch smali.
# ---------------------------------------------------------------------------
rom_version_core=$(printf '%s\n' "$rom_version_short" | awk -F. -v OFS=. '{ if (NF > 4) NF = 4; print }')
case "$regionTYPE" in
    China)  osver_region=CN ;;
    Global) osver_region=GL ;;
    *)      osver_region=CN ;;
esac
# dd/mm/yy - cùng nguồn ngày với build_date bên dưới, chỉ khác thứ tự
build_ddmmyy=$(TZ=Asia/Ho_Chi_Minh date +"%d%m%y")
rom_version_code="OS${rom_version_core}.${osver_region}${build_ddmmyy}"
mods "OS version (dòng Phiên bản OS): ${rom_version_code}"

# brand_incremental=false (mặc định): KHÔNG gắn " | BugOS" vào
#   ro.build.version.incremental.
#
# Lý do: ROM này không khai báo ro.build.fingerprint, nên init tự ghép nó từ
# ro.build.version.incremental. Gắn brand vào prop đó là fingerprint thành
#   Redmi/annibale/annibale:17/CP2A.../4.0.5.0.XPKCNXM | BugOS:user/release-keys
# -> sai định dạng, Play không nhận. Mà muốn ghi fingerprint đè lên thì phải biết
# brand/product/device thật - ba giá trị này KHÔNG nằm trong build.prop nào của
# ROM (init lấy từ ro.product.<partition>.* theo ro.product.property_source_order),
# nên mọi lần tự ghép đều ra danh tính vendor chung "Xiaomi/mivendor/mivendor".
#
# Tắt brand ở incremental thì init tự ghép fingerprint ĐÚNG, không cần đoán.
# Đổi lại: dòng "Phiên bản OS" mất chữ " | BugOS" nếu nó đọc prop này.
# Đặt brand_incremental=true trong config.env nếu ưu tiên hiển thị hơn.
BRAND_INC=$(grep -m1 '^brand_incremental=' "$WORK_DIR/config.env" 2>/dev/null | cut -d= -f2 | tr -d '\r\n ')
[ -z "$BRAND_INC" ] && BRAND_INC=false

for p in "${my_props[@]}"; do
    [ -f "$p" ] || continue
    sed_args=(
        -e '/^ro\.bugos\.version=/d'
        -e '/^ro\.bugos\.incremental=/d'
        -e '/^ro\.bugos\.simposcode=/d'
        -e '/^ro\.bugos\.osversion=/d'
        -e '/^ro\.bugos\.osversioncode=/d'
        -e '/^ro\.mi\.os\.version\.incremental=/d'
    )
    if [ "$BRAND_INC" = "true" ]; then
        sed_args+=(
            -e '/^ro\.build\.version\.incremental=/d'
            -e '/^ro\.system\.build\.version\.incremental=/d'
            -e '/^ro\.product\.build\.version\.incremental=/d'
        )
    fi
    sed -i "${sed_args[@]}" "$p"

    [ -n "$(tail -c1 "$p")" ] && echo "" >> "$p"

    # Dòng "Phiên bản OS" (trang Giới thiệu) đọc ro.mi.os.version.name.
    # Giữ nguyên tiền tố gốc (vd "OS3.0.307.0.WPKCNXM") rồi nối thêm brand, để
    # các đoạn code so sánh startsWith("OS") vẫn đúng.
    if grep -q '^ro\.mi\.os\.version\.name=' "$p" 2>/dev/null; then
        cur_name=$(grep -m1 '^ro\.mi\.os\.version\.name=' "$p" | cut -d= -f2- | tr -d '\r\n')
        cur_name=${cur_name% | BugOS}
        cur_name=${cur_name%|BugOS}
        cur_name=${cur_name% }
        sed -i "s@^ro\.mi\.os\.version\.name=.*@ro.mi.os.version.name=${cur_name} | BugOS@" "$p"
    else
        echo "ro.mi.os.version.name=${rom_version_display}" >> "$p"
    fi

    {
        echo "ro.bugos.version=${rom_version_display}"
        echo "ro.bugos.incremental=${rom_version_display}"
        echo "ro.bugos.simposcode=${rom_version_display}"
        echo "ro.bugos.osversion=${build_date}"
        echo "ro.bugos.osversioncode=${rom_version_code}"
        # Các prop gốc mà Settings đọc cho dòng "OS version"
        echo "ro.mi.os.version.incremental=${rom_version_display}"
        if [ "$BRAND_INC" = "true" ]; then
            echo "ro.build.version.incremental=${rom_version_display}"
            echo "ro.system.build.version.incremental=${rom_version_display}"
            echo "ro.product.build.version.incremental=${rom_version_display}"
        fi
    } >> "$p"
done

# ---------------------------------------------------------------------------
# ro.build.fingerprint PHẢI sạch.
#
# Khi ROM không khai báo ro.build.fingerprint tường minh, init tự ghép nó từ
#   brand/product/device:release/id/incremental:type/tags
# nên việc brand ro.build.version.incremental ở trên làm fingerprint thành
#   Redmi/annibale/annibale:17/CP2A.260605.016/4.0.5.0.XPKCNXM | BugOS:user/release-keys
# Sai định dạng -> Google Play không khớp được với build nào trong danh sách
# certified -> Cài đặt Play Store báo "Thiết bị chưa được chứng nhận".
# (Kiểm chứng trên máy: getprop ro.build.fingerprint có đúng chuỗi " | BugOS".)
#
# Nên chốt luôn một fingerprint sạch, ghép từ chính các mảnh gốc của ROM.
# ---------------------------------------------------------------------------
# Danh sách build.prop thực có trong images. my_props ở trên là danh sách đoán
# theo layout, và trên ROM này nó KHÔNG đủ: log build ra
#   thiếu mảnh để ghép fingerprint (brand='' prod='' dev='' ...)
# tức ro.product.brand / ro.product.name / ro.product.device không nằm trong 6
# đường dẫn đó (chúng ở file khác, ví dụ vendor/build.prop hay odm). Nên quét
# thật, thay vì đoán.
if [ "$BRAND_INC" != "true" ]; then
    # Không brand incremental thì fingerprint không thể hỏng: init ghép nó từ
    # chính các prop thật của máy. Không cần đoán brand/product/device nữa.
    mods "OS version: không brand incremental -> ro.build.fingerprint do init tự ghép, luôn đúng định dạng"
else
ALL_PROPS=()
while IFS= read -r -d '' _bp; do
    ALL_PROPS+=("$_bp")
done < <(find "$MAIN_FOLDER" -type f -name "build.prop" -print0 2>/dev/null)

# Thứ tự ưu tiên khi tra các mảnh fingerprint.
#
# KHÔNG dùng thứ tự find: trên ROM này odm/etc/build.prop khai báo danh tính
# vendor chung (ro.product.brand=Xiaomi, ro.product.name/device=mivendor), và
# init nạp nó TRƯỚC system/product nên giá trị thật (Redmi/annibale) thắng.
# Quét theo find nên bản trước ghép ra "Xiaomi/mivendor/mivendor" - sai, và tệ
# hơn là sai một cách âm thầm.
#
# Vì vậy ưu tiên đúng thứ tự init: product và system trước, odm sau cùng.
FP_SEARCH=(
    "$MAIN_FOLDER/product/etc/build.prop"
    "$MAIN_FOLDER/system/build.prop"
    "$MAIN_FOLDER/system/system/build.prop"
    "$MAIN_FOLDER/system_ext/etc/build.prop"
    "$MAIN_FOLDER/vendor/build.prop"
    "$MAIN_FOLDER/odm/etc/build.prop"
)

fp_get() {
    local key="$1" f v
    for f in "${FP_SEARCH[@]}" "${ALL_PROPS[@]}"; do
        [ -f "$f" ] || continue
        v=$(grep -m1 "^${key}=" "$f" 2>/dev/null | cut -d= -f2- | tr -d '\r')
        [ -n "$v" ] && { printf '%s' "$v"; return 0; }
    done
    return 1
}

# Bản thân brand/product/device có thể nằm ở biến thể khác (ro.product.vendor.*,
# ro.product.system.*, ro.product.odm.*) tuỳ partition khai báo. Thử lần lượt.
fp_get_any() {
    local k v
    for k in "$@"; do
        v=$(fp_get "$k")
        [ -n "$v" ] && { printf '%s' "$v"; return 0; }
    done
    return 1
}

FP_BRAND=$(fp_get_any ro.product.brand ro.product.vendor.brand ro.product.system.brand ro.product.odm.brand ro.product.product.brand)
FP_PROD=$(fp_get_any ro.product.name ro.product.vendor.name ro.product.system.name ro.product.odm.name ro.product.product.name)
FP_DEV=$(fp_get_any ro.product.device ro.product.vendor.device ro.product.system.device ro.product.odm.device ro.product.product.device)
FP_REL=$(fp_get ro.build.version.release)
FP_ID=$(fp_get ro.build.id)
FP_INC=$(fp_get ro.build.version.incremental)
FP_TYPE=$(fp_get ro.build.type)
FP_TAGS=$(fp_get ro.build.tags)

FP_INC=${FP_INC% | BugOS}
FP_INC=${FP_INC%|BugOS}
FP_INC=${FP_INC% }

# Danh tính vendor chung (Xiaomi/mivendor) không phải danh tính thiết bị. Nếu
# chỉ tra ra được nó thì thà KHÔNG ghi fingerprint mà để init tự ghép (nhánh
# else gỡ brand khỏi incremental), còn hơn ghi một fingerprint sai thiết bị.
FP_GENERIC=0
case "$FP_BRAND/$FP_PROD/$FP_DEV" in
    *mivendor*|*generic*|*unknown*) FP_GENERIC=1 ;;
esac

if [ -n "$FP_BRAND" ] && [ -n "$FP_PROD" ] && [ -n "$FP_DEV" ] && [ -n "$FP_REL" ] \
   && [ -n "$FP_ID" ] && [ -n "$FP_INC" ] && [ -n "$FP_TYPE" ] && [ -n "$FP_TAGS" ] \
   && [ "$FP_GENERIC" -eq 0 ]; then
    CLEAN_FP="${FP_BRAND}/${FP_PROD}/${FP_DEV}:${FP_REL}/${FP_ID}/${FP_INC}:${FP_TYPE}/${FP_TAGS}"

    # Ghi vào ĐÚNG file đang khai báo ro.build.version.incremental - tức file mà
    # init dùng để ghép fingerprint. Không đoán theo layout thư mục: trên ROM
    # này build.prop nằm ở images/system/build.prop (trên máy là /system/
    # build.prop), KHÔNG phải system/system/build.prop. Bản trước hard-code
    # đường dẫn nên ghi vào file không được nạp -> fingerprint vẫn bị ghép từ
    # incremental đã brand -> dính " | BugOS".
    #
    # Đọc bằng -print0: đường dẫn repo có dấu cách ("New folder").
    FP_DONE=0
    while IFS= read -r -d '' f; do
        grep -q '^ro\.build\.version\.incremental=' "$f" 2>/dev/null || continue
        sed -i '/^ro\.build\.fingerprint=/d' "$f"
        echo "ro.build.fingerprint=${CLEAN_FP}" >> "$f"
        mods "OS version: fingerprint sạch -> $(echo "$f" | sed "s|$MAIN_FOLDER/||")"
        FP_DONE=$((FP_DONE + 1))
    done < <(find "$MAIN_FOLDER" -type f -name "build.prop" -print0 2>/dev/null)

    if [ "$FP_DONE" -eq 0 ]; then
        # Không file nào khai báo incremental: ghi vào build.prop của system nếu có
        for f in "$MAIN_FOLDER/system/build.prop" "$MAIN_FOLDER/system/system/build.prop"; do
            [ -f "$f" ] || continue
            sed -i '/^ro\.build\.fingerprint=/d' "$f"
            echo "ro.build.fingerprint=${CLEAN_FP}" >> "$f"
            mods "OS version: fingerprint sạch (fallback) -> $(echo "$f" | sed "s|$MAIN_FOLDER/||")"
            FP_DONE=1
            break
        done
    fi

    if [ "$FP_DONE" -eq 0 ]; then
        warn "OS version: không tìm được build.prop nào để ghi fingerprint"
    else
        mods "OS version: fingerprint = ${CLEAN_FP}"
    fi
else
    if [ "$FP_GENERIC" -eq 1 ]; then
        warn "OS version: chỉ tra ra danh tính vendor chung ($FP_BRAND/$FP_PROD/$FP_DEV) - không ghi fingerprint sai, để init tự ghép"
    else
        warn "OS version: thiếu mảnh để ghép fingerprint (brand='$FP_BRAND' prod='$FP_PROD' dev='$FP_DEV' rel='$FP_REL' id='$FP_ID' inc='$FP_INC' type='$FP_TYPE' tags='$FP_TAGS')"
    fi

    # Lưới an toàn: không ghép được fingerprint thì ít nhất đừng để nó hỏng.
    # init tự ghép ro.build.fingerprint từ ro.build.version.incremental khi prop
    # này trống, nên gỡ hậu tố brand khỏi incremental là fingerprint tự hợp lệ
    # trở lại. Mất chữ " | BugOS" ở dòng Phiên bản OS, nhưng đúng định dạng.
    while IFS= read -r -d '' _f; do
        grep -q '^ro\.build\.version\.incremental=' "$_f" 2>/dev/null || continue
        sed -i -e 's/^\(ro\.build\.version\.incremental=.*\) | BugOS$/\1/' \
               -e 's/^\(ro\.build\.version\.incremental=.*\)| BugOS$/\1/' "$_f"
        mods "OS version: gỡ brand khỏi incremental -> $(echo "$_f" | sed "s|$MAIN_FOLDER/||")"
    done < <(find "$MAIN_FOLDER" -type f -name "build.prop" -print0 2>/dev/null)
fi
fi

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
    local strings_done=0
    local png_used=0
    local -a replaced_rel=()

    local resroot
    for resroot in "${resroots[@]}"; do
        local -a cands=()
        local -a hide_names=()
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
            warn "Settings: không thấy asset logo dạng drawable. Drawable nghi vấn (nếu có):"
            find "$resroot" -type f -path "*/drawable*/*" 2>/dev/null \
                | grep -Ei '/(hyper|bugos|os_logo|logo|wordmark|brand|miui_|rom_)' \
                | sed 's|.*/res/|  res/|' | sort -u | head -n 20
            # Header có thể là TextView -> đổi string (xem patch_strings.py)
            if [ -f "$SRC_DIR/patch_strings.py" ]; then
                if python3 "$SRC_DIR/patch_strings.py" "$resroot"; then
                    strings_done=$((strings_done + 1))
                fi
            fi
            continue
        fi

        # ---- replace -------------------------------------------------------
        # Ưu tiên logo PNG (logo_light.png / logo_dark.png). Có PNG thì thay
        # thẳng asset vector bằng ảnh, giữ nguyên TÊN resource và THƯ MỤC để
        # id drawable không đổi - code/layout đang trỏ tới id đó không cần sửa.
        # Không có PNG thì quay lại đường vector cũ (ic_hyper_os*.xml).
        local png_mode=false
        [ -s "$SRC_DIR/logo_light.png" ] && png_mode=true

        for f in "${cands[@]}"; do
            local base rel kind template
            base=$(basename "$f")
            rel="res/${f#$resroot/}"

            if [ "$png_mode" = true ]; then
                # biến thể tối: thư mục night / tên có white|dark
                local png="$SRC_DIR/logo_light.png"
                case "$f" in
                    *white*|*night*|*dark*) png="$SRC_DIR/logo_dark.png" ;;
                esac

                case "$base" in
                    *.xml)
                        # Ghi .png cùng thư mục rồi xoá .xml. Cùng tên resource
                        # nên id giữ nguyên, chỉ đổi định dạng file.
                        local dest="${f%.xml}.png"
                        # giữ bản .xml để còn đường lùi nếu rebuild thất bại
                        mkdir -p "$work/logo_bak/$(dirname "${f#$resroot/}")"
                        cp -f "$f" "$work/logo_bak/${f#$resroot/}" 2>/dev/null
                        if cp -f "$png" "$dest"; then
                            rm -f "$f"
                            mods "Settings: replaced $rel -> $(basename "$dest") (PNG, $(basename "$png"))"
                            replaced_rel+=("res/${dest#$resroot/}")
                            hide_names+=("${base%.xml}")
                            total=$((total + 1))
                            png_used=$((png_used + 1))
                        else
                            warn "Settings: $rel - ghi PNG thất bại"
                        fi
                        continue
                        ;;
                    *.png)
                        if cp -f "$png" "$f"; then
                            mods "Settings: replaced $rel (PNG in place)"
                            hide_names+=("${base%.png}")
                            total=$((total + 1))
                        else
                            warn "Settings: $rel - ghi PNG thất bại"
                        fi
                        continue
                        ;;
                    *)
                        warn "Settings: $rel là $base - không thay bằng PNG được, giữ nguyên"
                        continue
                        ;;
                esac
            fi

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
            hide_names+=("${base%.xml}")
            total=$((total + 1))
        done

        # ---- ẩn dòng version ngay dưới logo --------------------------------
        # Logo trên HyperOS 3 là DRAWABLE (xiaomi_os_logo...), nên nhánh string
        # không chạy và bước ẩn phải làm ở đây, dựa trên tên drawable vừa thay.
        if [ ${#hide_names[@]} -gt 0 ] && [ -f "$SRC_DIR/patch_strings.py" ]; then
            list=$(printf '%s,' "${hide_names[@]}")
            python3 "$SRC_DIR/patch_strings.py" "$resroot" --hide-drawables "${list%,}" \
                || warn "Settings: không ẩn được dòng version dưới logo (xem log [hide] ở trên)"

            # Chạy luôn nhánh string: trên một số bản header là TextView chứ không
            # phải drawable. Không có string nào khớp thì script không làm gì.
            python3 "$SRC_DIR/patch_strings.py" "$resroot" >/dev/null 2>&1 \
                && strings_done=$((strings_done + 1))
        fi
    done

    # ---- nới ô logo ------------------------------------------------------
    # miui_version_card.xml đặt logo vào ImageView 280dp x 40dp, scaleType
    # FIT_XY. Ô 40dp thì bề rộng 280dp chỉ cao 40dp => artwork 3:1 bị bóp còn
    # 42% chiều cao. Nâng dimen lên đúng tỉ lệ artwork thì logo to gấp 2.35 lần
    # mà không méo (đo trên máy: ô 824x277 px, khít artwork 280:94).
    #
    # Đã kiểm dimen này CÓ tác dụng: 40dp -> 118px, 5dp -> 15px, 94dp -> 277px.
    local logo_h
    logo_h=$(grep -m1 '^settings_logo_height_dp=' "$WORK_DIR/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
    if [ -n "$logo_h" ]; then
        for resroot in "${resroots[@]}"; do
            local dx old found=0
            while IFS= read -r dx; do
                [ -n "$dx" ] || continue
                grep -q 'name="my_device_os_logo_height"' "$dx" 2>/dev/null || continue
                old=$(grep -oE 'name="my_device_os_logo_height">[^<]+' "$dx" | head -1 | sed 's/.*>//')
                sed -i -E "s|(<dimen name=\"my_device_os_logo_height\">)[^<]*(</dimen>)|\1${logo_h}dp\2|" "$dx"
                mods "Settings: my_device_os_logo_height ${old:-?} -> ${logo_h}dp"
                found=$((found + 1))
            done < <(find "$resroot" -type f -name "dimens.xml" -path "*/values*/*" 2>/dev/null)
            if [ "$found" -eq 0 ]; then
                # Tên dimen đọc được trên Settings OS4 (a17); OS3 (a16) chưa kiểm
                # trực tiếp. Nếu bản ROM đang build đặt tên khác thì logo không
                # to lên - in ra các dimen nghi vấn để lần sau sửa đúng chỗ,
                # thay vì chỉ nói "không thấy".
                warn "Settings: không thấy dimen my_device_os_logo_height - logo giữ cỡ cũ"
                local sus
                sus=$(grep -rhoE 'name="[^"]*(os_logo|logo_view)[^"]*_height"[^>]*>[^<]*' \
                          "$resroot" --include=dimens.xml 2>/dev/null | sort -u | head -n 6)
                if [ -n "$sus" ]; then
                    warn "Settings: dimen nghi vấn trong bản ROM này:"
                    printf '%s\n' "$sus" | sed 's/^/    /'
                fi
            fi
        done
    fi

    mods "Settings: drawable=$total  string=$strings_done"

    # ---- Menu: Tích hợp Toolbox vào Cài đặt -> Mod ------------------------
    local mod_ok=0
    if [ -f "$SRC_DIR/patch_settings_mod.py" ]; then
        python3 "$SRC_DIR/patch_settings_mod.py" "$out" && mod_ok=1 || warn "Settings: tích hợp 'Mod' thất bại"
    fi

    if [ "$total" -eq 0 ] && [ "$strings_done" -eq 0 ] && [ "$mod_ok" -eq 0 ]; then
        warn "Settings: không thay đổi được asset, string lẫn mục Mod - giữ APK gốc"
        return 1
    fi

    # ---- smali: OS version ------------------------------------------------
    local p1
    p1=$(find "$out" -type f -name "MiuiAboutPhoneUtils.smali" 2>/dev/null | head -n 1)
    if [ -n "$p1" ] && [ -f "$p1" ]; then
        local ini before after
        for ini in getMiuiVersionInCard getRoXmsVersion getXmsVersion getSimpleOSVersion getOsVersionCode; do
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
        # Đổi đuôi .xml -> .png là thao tác ít gặp; nếu bộ biên dịch resource
        # của APKEditor từ chối thì quay lại logo vector để KHÔNG mất logo.
        if [ "$png_used" -gt 0 ] && [ -d "$work/logo_bak" ]; then
            warn "Settings: rebuild với PNG thất bại - thử lại bằng logo vector"
            tail -n 3 "$work/build.log" 2>/dev/null
            (
                cd "$work/logo_bak" || exit 1
                find . -type f -name "*.xml" | while IFS= read -r r; do
                    mkdir -p "$resroot/$(dirname "$r")"
                    cp -f "$r" "$resroot/$r"
                done
            )
            for rel in "${replaced_rel[@]}"; do
                case "$rel" in *.png) rm -f "$resroot/${rel#res/}" ;; esac
            done
            local fb=0 ff ow2 oh2 size2 tpl
            for ff in "${cands[@]}"; do
                [ -f "$ff" ] || continue
                case "$(basename "$ff")" in *.xml) ;; *) continue ;; esac
                tpl="$SRC_DIR/ic_hyper_os.xml"
                case "$ff" in *white*|*night*|*dark*) tpl="$SRC_DIR/ic_hyper_os_white.xml" ;; esac
                ow2=$(grep -oE 'android:width="[^"]+"' "$ff" 2>/dev/null | head -1 | sed 's/.*="//;s/"$//')
                oh2=$(grep -oE 'android:height="[^"]+"' "$ff" 2>/dev/null | head -1 | sed 's/.*="//;s/"$//')
                size2=$(make_drawable "$tpl" "$ff" "$ow2" "$oh2" "$aspect")
                mods "Settings: (fallback) $ff -> ${size2}dp"
                fb=$((fb + 1))
            done
            png_used=0
            total=$fb
            rm -f "$work/new.apk"
            if ! $APKEDITOR b -f -i "$out" -o "$work/new.apk" > "$work/build.log" 2>&1 || [ ! -s "$work/new.apk" ]; then
                warn "Settings: Rebuild FAILED (cả PNG lẫn vector) - giữ APK gốc"
                tail -n 5 "$work/build.log" 2>/dev/null
                return 1
            fi
            mods "Settings: Rebuild lại bằng vector OK"
        else
            warn "Settings: Rebuild FAILED - giữ APK gốc"
            tail -n 5 "$work/build.log" 2>/dev/null
            return 1
        fi
    fi

    # ---- verify the replacement really landed inside the new APK ----------
    # NOTE: resource file names are often obfuscated inside the APK (res/hu.xml),
    # so we cannot look the entry up by its decoded name.  The pathData string is
    # stored verbatim in the binary XML string pool -> scan every res xml instead.
    local ok=0 ok_str=0 ok_png=0
    # marker 1: pathData của logo (drawable vector - chỉ có khi KHÔNG dùng PNG)
    ok=$(unzip -p "$work/new.apk" 'res/*.xml' 2>/dev/null | grep -ac "M 106.32 72.58 Q 99.29 80.61")
    # marker 2: chữ đã đổi (strings) - "Xiaomi Bug" nằm trong string pool
    ok_str=$(unzip -p "$work/new.apk" 'resources.arsc' 2>/dev/null | grep -ac "Xiaomi Bug")
    # marker 3: PNG logo có mặt trong APK. Tên file trong res/ bị obfuscate nên
    # phải so theo nội dung: đếm entry .png có sha256 trùng logo nguồn.
    if [ -f "$SRC_DIR/logo_light.png" ]; then
        ok_png=$(python3 - "$work/new.apk" "$SRC_DIR/logo_light.png" "$SRC_DIR/logo_dark.png" <<'PY'
import hashlib, sys, zipfile
apk, *logos = sys.argv[1:]
want = {hashlib.sha256(open(p, 'rb').read()).hexdigest() for p in logos if p}
n = 0
with zipfile.ZipFile(apk) as z:
    for i in z.infolist():
        if not i.filename.endswith('.png'):
            continue
        try:
            if hashlib.sha256(z.read(i.filename)).hexdigest() in want:
                n += 1
        except Exception:
            pass
print(n)
PY
)
    fi
    if [ "${ok:-0}" -eq 0 ] && [ "${ok_str:-0}" -eq 0 ] && [ "${ok_png:-0}" -eq 0 ]; then
        warn "Settings: Verify thất bại (không thấy marker drawable/PNG lẫn string) - giữ APK gốc"
        return 1
    fi

    # Chốt thêm cho chế độ PNG: tên resource phải còn trong bảng resource.
    # Nếu bước build làm rơi mất drawable (đổi đuôi .xml -> .png hỏng) thì tên
    # sẽ biến mất khỏi resources.arsc -> giữ APK gốc thay vì để Settings trắng.
    if [ "${ok_png:-0}" -gt 0 ]; then
        local ok_name
        ok_name=$(unzip -p "$work/new.apk" 'resources.arsc' 2>/dev/null | grep -ac "xiaomi_os_logo")
        if [ "${ok_name:-0}" -eq 0 ]; then
            warn "Settings: PNG có trong APK nhưng resource 'xiaomi_os_logo' biến mất - giữ APK gốc"
            return 1
        fi
        mods "Settings: resource name còn trong ARSC (verify $ok_name)"
    fi

    cp -f "$work/new.apk" "$apk"
    mods "Settings: DONE - drawable=$total (verify $ok vector, $ok_png png), string=$strings_done (verify $ok_str) trong ${apk#$MAIN_FOLDER/}"
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
