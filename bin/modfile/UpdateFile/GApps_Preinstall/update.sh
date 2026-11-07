#!/bin/bash
# ---------------------------------------------------------------------------
# GApps_Preinstall - đặt sẵn các app Google vào product/priv-app.
#
# VẤN ĐỀ: base ROM chỉ có Play Store (product/priv-app/Phonesky, do
# gmsservices chép vào) và GMS (APEX). Các app người dùng thật sự mở - Google,
# Chrome, Photos, Maps, Gmail, Drive - đều phải tải từng cái từ Play sau khi
# flash. Muốn "hiện sẵn" thì APK phải nằm trong image.
#
# ĐIỀU QUAN TRỌNG NHẤT - SPLIT APK:
#   6 app này đều là split APK (base + split_config.*). Chép mỗi base là hỏng:
#   manifest khai requiredSplitTypes, thiếu split là PackageManager từ chối cả
#   gói. Đã đọc requiredSplitTypes của từng bản:
#     GoogleVelvet  base__density
#     Chrome        chrome__module,on_demand__module
#     Photos        base__abi,base__density
#     Maps          base__abi,base__density
#     Gmail         base__abi,base__density
#     Drive         base__abi,base__density
#   Bộ APK trong apks/ chứa đúng những split đó (cộng split ngôn ngữ vi).
#
# QUY ƯỚC TÊN FILE - lấy từ chính ROM này, không đoán:
#   /system/priv-app/DocumentsUIGoogleMiuiCn/
#     DocumentsUIGoogleMiuiCn.apk             (base, manifest không có split)
#     DocumentsUIGoogleMiuiCn-xxhdpi.apk      (manifest split='config.xxhdpi')
#   /product/app/split-XiaomiServiceFrameworkCN/
#     pay-arm64_v8a.apk                       (manifest split='pay.config.arm64_v8a')
#   => base: <TênThưMục>.apk
#      split: <TênThưMục>-<phần sau dấu chấm cuối của split name>.apk
#   Giữ đúng quy ước này để rơi vào cả hai giả thuyết (PMS đọc split name từ
#   manifest, hoặc suy ra từ tên file) đều đúng.
#
# Bỏ split_lens_ondevice_engine_play_ml_module (67 MB) của Velvet: đó là module
# Play phân phối động, không phải config split, và nếu đặt sẵn thì tên file sẽ
# đụng quy ước split ở trên.
#
# QUYỀN PRIVILEGED: app trong priv-app mà khai quyền privileged nhưng không có
# trong privapp-permissions*.xml thì bị TỪ CHỐI quyền - và nếu
# ro.control_privapp_permissions=enforce thì máy KHÔNG BOOT. Mod
# System_MultiDisableFeature đã đặt prop đó rỗng, nhưng vẫn ghi whitelist để
# không phụ thuộc vào thứ tự mod.
#
# Kiểm tra sau khi flash:
#   adb shell pm list packages -s | grep -E 'gm$|photos|maps|chrome|docs|quicksearch'
#   -> phải thấy đủ 6 gói.
# ---------------------------------------------------------------------------
work_dir=$(pwd)
source "$work_dir/functions.sh"

MAIN_FOLDER="$work_dir/build/baserom/images"
SRC_DIR="$work_dir/bin/modfile/UpdateFile/GApps_Preinstall"
APK_DIR="$SRC_DIR/apks"
FINDER="$work_dir/bin/modfile/UpdateFile/Apps_Replace/find_apk_by_package.py"

ENABLED=$(grep -m1 '^preinstall_gapps_apps=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$ENABLED" = "false" ]; then
    mods "GApps: preinstall_gapps_apps=false - bỏ qua"
    exit 0
fi

if [ ! -d "$MAIN_FOLDER" ]; then
    warn "GApps: không thấy $MAIN_FOLDER - bỏ qua"
    exit 0
fi
if [ ! -d "$APK_DIR" ]; then
    warn "GApps: không thấy $APK_DIR - bỏ qua"
    exit 0
fi

PERM_DIR="$MAIN_FOLDER/product/etc/permissions"
PERM_FILE="$PERM_DIR/privapp-permissions-bugos-gapps.xml"

# Quyền privileged mà từng gói KHAI (đọc bằng aapt2 dump permissions). Chỉ khai
# đúng những gì APK xin, không thêm quyền nào khác.
#   GoogleVelvet: MANAGE_ACCOUNTS, INTERACT_ACROSS_USERS, CAPTURE_AUDIO_OUTPUT,
#                 PACKAGE_USAGE_STATS
#   5 app còn lại: MANAGE_ACCOUNTS
velvet_priv_perms="
        android.permission.MANAGE_ACCOUNTS
        android.permission.INTERACT_ACROSS_USERS
        android.permission.CAPTURE_AUDIO_OUTPUT
        android.permission.PACKAGE_USAGE_STATS
"
plain_priv_perms="
        android.permission.MANAGE_ACCOUNTS
"

copied=0
total_kb=0
kept=0

# Base APK lớn hơn 100 MB không đẩy được lên GitHub (giới hạn cứng 100 MB/file),
# nên 2 base lớn nhất nằm trong repo dưới dạng mảnh 90 MB: <Tên>.apk.part-00...
# cùng một SHA256SUMS. Ghép lại rồi kiểm sha trước khi dùng; sai thì bỏ qua thay
# vì cài một APK hỏng.
materialize_base() {
    local dir="$1" name="$2"
    local base="$dir$name.apk"
    [ -f "$base" ] && return 0
    local first="$base.part-00"
    [ -f "$first" ] || return 1

    local sums="$dir/SHA256SUMS"
    local expect=""
    [ -f "$sums" ] && expect=$(awk -v n="$name.apk" '$2==n {print $1}' "$sums")

    cat "$dir$name.apk".part-* > "$base" 2>/dev/null || { rm -f "$base"; return 1; }

    if [ -n "$expect" ]; then
        local got
        got=$(sha256sum "$base" 2>/dev/null | cut -d' ' -f1)
        if [ "$got" != "$expect" ]; then
            warn "GApps: $name.apk ghép mảnh xong nhưng SHA256 không khớp (got ${got:0:12}, want ${expect:0:12})"
            rm -f "$base"
            return 1
        fi
        mods "GApps: ghép $name.apk từ $(ls "$dir$name.apk".part-* | wc -l) mảnh, SHA256 khớp"
    else
        mods "GApps: ghép $name.apk từ mảnh (không có SHA256SUMS để đối chiếu)"
    fi
    return 0
}

for d in "$APK_DIR"/*/; do
    [ -d "$d" ] || continue
    name=$(basename "$d")

    materialize_base "$d" "$name" || {
        warn "GApps: $name thiếu base APK (không có $name.apk lẫn mảnh .part-*) - bỏ qua"
        continue
    }

    apks=("$d"*.apk)
    if [ ! -f "${apks[0]}" ]; then
        warn "GApps: $name không có APK nào - bỏ qua"
        continue
    fi

    # Package của base APK -> dùng để phát hiện trùng với phần còn lại của image.
    base_apk="${d}${name}.apk"
    pkg=""
    if [ -f "$base_apk" ] && [ -f "$FINDER" ]; then
        pkg=$(python3 "$FINDER" -- --pkg-of "$base_apk" 2>/dev/null | tr -d '\r\n ')
    fi

    # Đã có sẵn ở đâu đó trong images (base ROM hoặc mod khác) thì không chép:
    # hai thư mục cùng package sẽ làm PackageManager bỏ một gói và có thể lệch
    # version giữa base với split.
    existing=""
    if [ -n "$pkg" ] && [ -f "$FINDER" ]; then
        existing=$(python3 "$FINDER" "$MAIN_FOLDER" "$pkg" 2>/dev/null | head -n 1 | tr -d '\r')
    fi
    if [ -n "$existing" ]; then
        mods "GApps: $pkg đã có trong image (${existing#$MAIN_FOLDER/}) - giữ nguyên"
        kept=$((kept + 1))
        continue
    fi

    dest="$MAIN_FOLDER/product/priv-app/$name"
    if [ -d "$dest" ]; then
        mods "GApps: $name đã có thư mục - giữ nguyên"
        kept=$((kept + 1))
        continue
    fi

    mkdir -p "$dest"
    cp -f "${apks[@]}" "$dest"/ || { warn "GApps: chép $name thất bại"; continue; }

    size_kb=$(du -sk "$dest" 2>/dev/null | cut -f1)
    total_kb=$((total_kb + ${size_kb:-0}))
    copied=$((copied + 1))
    mods "GApps: $name -> product/priv-app/$name (${#apks[@]} apk, $(( ${size_kb:-0} / 1024 )) MB, $pkg)"
done

if [ "$copied" -eq 0 ]; then
    mods "GApps: không chép gì (đã có sẵn: $kept)"
    exit 0
fi

# --- whitelist quyền privileged -------------------------------------------
mkdir -p "$PERM_DIR"
{
    echo '<?xml version="1.0" encoding="utf-8"?>'
    echo '<!-- BugOS: quyền privileged cho các app Google đặt sẵn. Xem bin/modfile/UpdateFile/GApps_Preinstall -->'
    echo '<!-- Chỉ liệt kê quyền mà APK thật sự khai; thiếu file này + enforce = không boot. -->'
    echo '<permissions>'
    for d in "$APK_DIR"/*/; do
        name=$(basename "$d")
        case "$name" in
            GoogleVelvet) perms="$velvet_priv_perms" ;;
            *)            perms="$plain_priv_perms" ;;
        esac
        case "$name" in
            GoogleVelvet) pkg="com.google.android.googlequicksearchbox" ;;
            Chrome)       pkg="com.android.chrome" ;;
            Photos)       pkg="com.google.android.apps.photos" ;;
            Maps)         pkg="com.google.android.apps.maps" ;;
            Gmail)        pkg="com.google.android.gm" ;;
            Drive)        pkg="com.google.android.apps.docs" ;;
            *)            pkg="" ;;
        esac
        [ -n "$pkg" ] || continue
        [ -d "$MAIN_FOLDER/product/priv-app/$name" ] || continue
        echo "    <privapp-permissions package=\"$pkg\">"
        printf '%s\n' "$perms" | sed '/^[[:space:]]*$/d'
        echo "    </privapp-permissions>"
    done
    echo '</permissions>'
} > "$PERM_FILE"

if [ -s "$PERM_FILE" ]; then
    mods "GApps: ghi product/etc/permissions/$(basename "$PERM_FILE")"
else
    warn "GApps: ghi whitelist thất bại"
fi

mods "GApps: đặt sẵn $copied app ($((total_kb / 1024)) MB), giữ nguyên $kept gói đã có"
