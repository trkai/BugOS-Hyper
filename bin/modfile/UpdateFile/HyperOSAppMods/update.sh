#!/bin/bash
# BugOS - HyperOS App Mods (Kashi / Mods Center)
# ---------------------------------------------------------------------------
# Gộp 4 mod của Kashi, áp cho OS3 và OS4:
#   1. Theme Manager v7        com.android.thememanager        11.5.3.1
#   2. App Vault v5            com.miui.personalassistant      25.41.82.00
#   3. Screenshot v1.1         com.miui.screenshot             1.6.3.40
#   4. iOS27 Control Center    miui.systemui.plugin            OS3: 17.1.5.51 / OS4: 18.3.2.57
#
# ĐÃ KIỂM CHỨNG TRÊN APK THẬT:
#   - Cả 5 APK đều được ký bằng PLATFORM key của Xiaomi (SHA256 C9:00:9D:01:...),
#     trùng framework-res. Bắt buộc vì thememanager khai sharedUserId=
#     "android.uid.theme", plugin khai "android.uid.system". KHÔNG re-sign.
#   - apksigner báo "DOES NOT VERIFY" cho cả 5 (v3 digest mismatch) - cố ý, vì
#     đã mod. Chỉ nạp được nhờ COREPATCH tắt kiểm tra chữ ký.
#   - Cả 5 có extractNativeLibs=false và .so đã page-aligned (data offset chia
#     hết 4096) -> đọc trực tiếp từ APK, không cần chép lib ra ngoài.
#
# VẤN ĐỀ PHẢI XỬ LÝ - versionCode thấp hơn bản trong /data:
#   Trên máy đang có bản cập nhật trong /data cao hơn bản mod:
#     thememanager    : /data 11560    vs mod 11531
#     personalassistant: /data 2541870  vs mod 2541820
#     screenshot      : /data 10603042 vs mod 10603040
#   PackageManager luôn chọn bản versionCode cao hơn, nên nếu để nguyên thì mod
#   trong ROM KHÔNG có tác dụng (bản /data vẫn thắng). Vì vậy nâng versionCode
#   lên rất cao: kho không còn chào bản mới, và mọi nỗ lực cài bản thấp hơn bị
#   PackageManager coi là downgrade -> tự chặn.
#   Bump làm hỏng căn lề zip -> phải realign lại (bin/realign_apk.py, viết riêng
#   vì repo không có zipalign). Đã test: zipalign -c -p 4 pass, chứng thư giữ
#   nguyên platform key.
# ---------------------------------------------------------------------------

work_dir=$(pwd)
[ -f "$work_dir/functions.sh" ] && source "$work_dir/functions.sh"

SRC="$work_dir/bin/modfile/UpdateFile/HyperOSAppMods"
IMAGES="$work_dir/build/baserom/images"
REALIGN="$work_dir/bin/realign_apk.py"
BUMP="$work_dir/bin/modfile/UpdateFile/Apps_Replace/bump_versioncode.py"

log_msg() {
    if type mods &>/dev/null; then mods "$1"
    elif type patch &>/dev/null; then patch "$1"
    else echo "[AppMods] $1"; fi
}
warn_msg() {
    if type warn &>/dev/null; then warn "$1"; else echo "[AppMods][WARN] $1"; fi
}

[ -d "$IMAGES" ] || { warn_msg "AppMods: chưa có images - bỏ qua"; exit 0; }

ENABLE=$(grep -m1 '^hyperos_app_mods=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
[ "$ENABLE" = "false" ] && { log_msg "AppMods: tắt bằng config (hyperos_app_mods=false)"; exit 0; }

# Chỉ áp cho OS3 và OS4. Các mod gốc (Theme/Screenshot/iOS27) tự abort nếu
# hos_version không chứa OS3/OS4, nên nếu để chạy trên OS2 build sẽ có log lỗi
# dù không ảnh hưởng - chặn sớm cho sạch.
ROM_OS_CHK=$(cat "$work_dir/bin/ddevice/rom_os.txt" 2>/dev/null | tr -d '\r\n ')
case "$ROM_OS_CHK" in
    OS3|OS4) : ;;
    *) log_msg "AppMods: chỉ dành cho OS3/OS4 (đang là '${ROM_OS_CHK:-?}') - bỏ qua"; exit 0 ;;
esac

PIN_CODE=$(grep -m1 '^app_mods_versioncode=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
[ -z "$PIN_CODE" ] && PIN_CODE=2000000000

# Phiên bản OS + Android. QUAN TRỌNG: OS3 tồn tại trên CẢ Android 15 và 16
# (Xiaomi phát hành OS3 cho một số máy nền A15, xem bin/ddevice/targets/android15.env).
# Vì vậy không được suy Android version từ tên OS - phải đọc androidver.txt.
ROM_OS=$(cat "$work_dir/bin/ddevice/rom_os.txt" 2>/dev/null | tr -d '\r\n ')
ANDROID_VER=$(cat "$work_dir/bin/ddevice/androidver.txt" 2>/dev/null | tr -d '\r\n ')
ANDROID_MAJOR="${ANDROID_VER%%.*}"
[ -z "$ANDROID_MAJOR" ] && ANDROID_MAJOR=0
log_msg "AppMods: OS=$ROM_OS Android=$ANDROID_VER"

WORK="$work_dir/.appmods_work"
rm -rf "$WORK"; mkdir -p "$WORK"

# replace_app <file apk nguồn> <thư mục app đích trong images> <tên file đích>
replace_app() {
    local src="$1" destdir="$2" destname="$3" label tmp
    label="$destname"

    if [ ! -s "$src" ]; then
        warn_msg "AppMods: thiếu nguồn $src - bỏ qua"
        return 1
    fi
    if [ ! -d "$destdir" ]; then
        warn_msg "AppMods: không thấy $destdir - bỏ qua $label"
        return 1
    fi

    tmp="$WORK/$destname"
    cp -f "$src" "$tmp"

    # Nâng versionCode để thắng bản cập nhật trong /data, rồi căn lề lại.
    if [ -f "$BUMP" ]; then
        local before after
        before=$(python3 "$BUMP" --show "$tmp" 2>/dev/null | sed 's/.*versionCode=//;s/ .*//')
        if python3 "$BUMP" "$tmp" "$PIN_CODE" >/dev/null 2>&1; then
            after=$(python3 "$BUMP" --show "$tmp" 2>/dev/null | sed 's/.*versionCode=//;s/ .*//')
            if [ "$after" = "$PIN_CODE" ]; then
                log_msg "AppMods: $label versionCode $before -> $PIN_CODE"
            else
                warn_msg "AppMods: $label bump không đọc lại được (=$after)"
            fi
            # bump phá căn lề -> phải realign, nếu không native lib không nạp
            if [ -f "$REALIGN" ]; then
                if python3 "$REALIGN" "$tmp" "$tmp.aligned" 4 >/dev/null 2>&1; then
                    mv -f "$tmp.aligned" "$tmp"
                else
                    warn_msg "AppMods: $label realign thất bại - dùng bản chưa bump"
                    cp -f "$src" "$tmp"
                fi
            else
                warn_msg "AppMods: thiếu realign_apk.py - dùng bản chưa bump"
                cp -f "$src" "$tmp"
            fi
        else
            warn_msg "AppMods: $label - bump versionCode thất bại, dùng bản gốc"
            cp -f "$src" "$tmp"
        fi
    fi

    if ! unzip -t "$tmp" >/dev/null 2>&1; then
        warn_msg "AppMods: $label - APK ra hỏng, bỏ qua"
        return 1
    fi

    # Xoá mã biên dịch cũ: odex không khớp APK mới thì ART từ chối nạp.
    rm -rf "$destdir/oat"
    find "$destdir" -maxdepth 1 -type f \( -name '*.odex' -o -name '*.vdex' -o -name '*.art' \) -delete 2>/dev/null

    if cp -f "$tmp" "$destdir/$destname"; then
        local sz
        sz=$(( $(wc -c < "$destdir/$destname") / 1048576 ))
        log_msg "AppMods: $(basename "$destdir")/$destname -> ${sz}MB"
        return 0
    fi
    warn_msg "AppMods: copy $label thất bại"
    return 1
}

# --- 1. Theme Manager (product/app/MIUIThemeManager) ------------------------
# Dò linh hoạt: tên thư mục đổi giữa các bản ROM.
find_dir() {  # <tên thư mục> -> đường dẫn
    local name="$1" hit
    hit=$(find "$IMAGES" -maxdepth 4 -type d -name "$name" 2>/dev/null | head -n1)
    echo "$hit"
}

TM_DIR=$(find_dir MIUIThemeManager)
if [ -n "$TM_DIR" ]; then
    replace_app "$SRC/files/MIUIThemeManager.apk" "$TM_DIR" "MIUIThemeManager.apk"
else
    warn_msg "AppMods: không thấy MIUIThemeManager trong ROM - bỏ qua Theme Manager"
fi

# --- 2. App Vault (com.miui.personalassistant) -----------------------------
# Tên thư mục thay đổi nhiều: MIUIPersonalAssistantPhoneOS2NoBeta / MIUIAppVault ...
#
# RÀNG BUỘC PHIÊN BẢN: mod gốc của App Vault TỪ CHỐI chạy dưới Android 16
#   android_version=$(getprop ro.build.version.release)
#   if [ "$android_version" -lt 16 ]; then abort "Android version is not supported."
# nên trên OS3-nền-A15 phải bỏ qua app này, không thì mod tự huỷ cả gói.
if [ "$ANDROID_MAJOR" -lt 16 ]; then
    log_msg "AppMods: bỏ qua App Vault - mod yêu cầu Android 16+ (đang là $ANDROID_VER)"
else
AV_DIR=""
for cand in MIUIPersonalAssistantPhoneOS2NoBeta MIUIAppVault MIUIPersonalAssistant AppVault; do
    AV_DIR=$(find_dir "$cand")
    [ -n "$AV_DIR" ] && break
done
if [ -n "$AV_DIR" ]; then
    # Tên file APK lấy theo file đang có trong thư mục (không đoán)
    av_apk=$(find "$AV_DIR" -maxdepth 1 -type f -name '*.apk' | head -n1)
    if [ -n "$av_apk" ]; then
        replace_app "$SRC/files/AppVault.apk" "$AV_DIR" "$(basename "$av_apk")"
    else
        warn_msg "AppMods: $AV_DIR không có APK - bỏ qua App Vault"
    fi
else
    warn_msg "AppMods: không thấy App Vault trong ROM - bỏ qua"
fi
fi

# --- 3. Screenshot (product/app/MIUIScreenshot) ----------------------------
SC_DIR=$(find_dir MIUIScreenshot)
if [ -n "$SC_DIR" ]; then
    replace_app "$SRC/files/MIUIScreenshot.apk" "$SC_DIR" "MIUIScreenshot.apk"
else
    warn_msg "AppMods: không thấy MIUIScreenshot trong ROM - bỏ qua Screenshot"
fi

# --- 4. SystemUI Plugin (theo OS) -----------------------------------------
# Chọn biến thể theo TÊN OS như mod gốc (OS3 -> plugin build cho A15, OS4 ->
# plugin build cho A16). Lưu ý: OS3 có thể chạy trên CẢ Android 15 và 16, nên
# khi OS3 nằm trên A16 thì plugin OS3 (build A15) là bản gần nhất mà mod có.
# Không tự đổi sang biến thể OS4 vì giao diện SystemUI của OS3 khác OS4.
PL_DIR=$(find_dir MIUISystemUIPlugin)
if [ -n "$PL_DIR" ]; then
    case "$ROM_OS" in
        OS3) PL_SRC="$SRC/files/plugin_os3/MIUISystemUIPlugin.apk" ;;
        OS4) PL_SRC="$SRC/files/plugin_os4/MIUISystemUIPlugin.apk" ;;
        *)   PL_SRC="" ;;
    esac
    if [ -n "$PL_SRC" ] && [ -s "$PL_SRC" ]; then
        if [ "$ROM_OS" = "OS3" ] && [ "$ANDROID_MAJOR" -ge 16 ] 2>/dev/null; then
            warn_msg "AppMods: OS3 trên Android $ANDROID_VER - plugin OS3 được build cho Android 15; nếu SystemUI lỗi, đặt hyperos_app_mods_plugin=false"
        fi
        replace_app "$PL_SRC" "$PL_DIR" "MIUISystemUIPlugin.apk"
    else
        warn_msg "AppMods: ROM_OS='$ROM_OS' không có biến thể plugin tương ứng - bỏ qua"
    fi
else
    warn_msg "AppMods: không thấy MIUISystemUIPlugin trong ROM - bỏ qua iOS27 plugin"
fi

rm -rf "$WORK"
log_msg "AppMods: xong (credit: Kashi / Mods Center)"
exit 0
