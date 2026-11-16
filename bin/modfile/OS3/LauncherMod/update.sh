#!/bin/bash
# BugOS - Modded HyperOS Launcher v7.5F (Kashi) - CHỈ OS3
# ---------------------------------------------------------------------------
# Đã kiểm chứng trên APK thật:
#   - MiuiHome.apk: com.miui.home 7.50.06.2593 (rom mod), ký PLATFORM key Xiaomi
#     (C9:00:9D:01:...). sharedUserId trong manifest là tham chiếu resource
#     (string/sharedUserId) và giải ra CHUỖI RỖNG -> launcher KHÔNG nằm trong
#     shared user nào, nên không bị ràng buộc chữ ký với app khác. Vẫn không
#     re-sign: APK đã mod nên apksigner báo DOES NOT VERIFY, chỉ nạp được nhờ
#     COREPATCH tắt kiểm tra chữ ký.
#   - extractNativeLibs=false, 4 file .so đều page-aligned (offset % 4096 == 0).
#   - XiaomiEUExt.apk ký bằng key Xiaomi.eu (CN=ingbrzy) - KHÁC platform key.
#     Đây là app phụ trợ (hide apps + searchbar provider), không share uid với
#     hệ thống nên chữ ký khác chấp nhận được. Chỉ thêm khi ROM chưa có.
#   - Overlay MiuiHomeLauncherResOverlay.apk: bản mod versionCode 34 < bản ROM 37.
#     So sánh nội dung: 3 resource đầu GIỐNG HỆT bản ROM (recents + secondary
#     home), mod thêm 3 resource (defaultAssistant / content suggestions /
#     contextual search). Thay vào không mất gì mà có thêm. Android nạp static
#     overlay theo file, không so versionCode, nên 34 < 37 không phải vấn đề.
#
# VỀ versionCode của launcher:
#   Mod là 750062593 (7.50.06). Nếu máy còn bản cập nhật launcher trong /data
#   (bản mới hơn, ví dụ 8.01 = 801029239), PackageManager sẽ chọn bản /data và
#   mod trong ROM KHÔNG có tác dụng. Vì vậy nâng versionCode lên rất cao rồi
#   realign (bin/realign_apk.py) - bump làm hỏng căn lề .so.
#   Tắt bump: launcher_bump_versioncode=false
# ---------------------------------------------------------------------------

work_dir=$(pwd)
[ -f "$work_dir/functions.sh" ] && source "$work_dir/functions.sh"

SRC="$work_dir/bin/modfile/OS3/LauncherMod"
IMAGES="$work_dir/build/baserom/images"
REALIGN="$work_dir/bin/realign_apk.py"
BUMP="$work_dir/bin/modfile/UpdateFile/Apps_Replace/bump_versioncode.py"

log_msg() {
    if type mods &>/dev/null; then mods "$1"
    elif type patch &>/dev/null; then patch "$1"
    else echo "[LauncherOS3] $1"; fi
}
warn_msg() {
    if type warn &>/dev/null; then warn "$1"; else echo "[LauncherOS3][WARN] $1"; fi
}

[ -d "$IMAGES" ] || { warn_msg "LauncherOS3: chưa có images - bỏ qua"; exit 0; }

ENABLE=$(grep -m1 '^launcher_mod_os3=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
[ "$ENABLE" = "false" ] && { log_msg "LauncherOS3: tắt bằng config"; exit 0; }

DO_BUMP=$(grep -m1 '^launcher_bump_versioncode=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
[ -z "$DO_BUMP" ] && DO_BUMP=true
PIN_CODE=$(grep -m1 '^launcher_versioncode=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
[ -z "$PIN_CODE" ] && PIN_CODE=2000000000

# --- 1. Thay launcher ------------------------------------------------------
HOME_DIR=""
for cand in "$IMAGES/product/priv-app/MiuiHome" "$IMAGES/product/app/MiuiHome"; do
    [ -d "$cand" ] && { HOME_DIR="$cand"; break; }
done
if [ -z "$HOME_DIR" ]; then
    hit=$(find "$IMAGES" -maxdepth 4 -type f -name 'MiuiHome.apk' 2>/dev/null | head -n1)
    [ -n "$hit" ] && HOME_DIR=$(dirname "$hit")
fi

if [ -z "$HOME_DIR" ] || [ ! -d "$HOME_DIR" ]; then
    warn_msg "LauncherOS3: không thấy MiuiHome trong ROM - bỏ qua"
else
    if [ "$(basename "$(dirname "$HOME_DIR")")" = "app" ]; then
        warn_msg "LauncherOS3: MiuiHome ở product/app - launcher cần privileged, bỏ qua"
    else
        tmp="$work_dir/.launcher_tmp.apk"
        cp -f "$SRC/files/MiuiHome.apk" "$tmp"
        ok=1

        if [ "$DO_BUMP" = "true" ] && [ -f "$BUMP" ]; then
            before=$(python3 "$BUMP" --show "$tmp" 2>/dev/null | sed 's/.*versionCode=//;s/ .*//')
            if python3 "$BUMP" "$tmp" "$PIN_CODE" >/dev/null 2>&1; then
                log_msg "LauncherOS3: versionCode $before -> $PIN_CODE"
                if [ -f "$REALIGN" ] && python3 "$REALIGN" "$tmp" "$tmp.al" 4 >/dev/null 2>&1; then
                    mv -f "$tmp.al" "$tmp"
                elif [ -f "$REALIGN" ]; then
                    warn_msg "LauncherOS3: realign thất bại - dùng bản chưa bump"
                    cp -f "$SRC/files/MiuiHome.apk" "$tmp"
                fi
            else
                warn_msg "LauncherOS3: bump thất bại - dùng bản gốc"
                cp -f "$SRC/files/MiuiHome.apk" "$tmp"
            fi
        fi

        if ! unzip -t "$tmp" >/dev/null 2>&1; then
            warn_msg "LauncherOS3: APK sau xử lý hỏng - dùng bản gốc"
            cp -f "$SRC/files/MiuiHome.apk" "$tmp"
        fi

        rm -rf "$HOME_DIR/oat"
        find "$HOME_DIR" -maxdepth 1 -type f \( -name '*.odex' -o -name '*.vdex' -o -name '*.art' \) -delete 2>/dev/null

        if cp -f "$tmp" "$HOME_DIR/MiuiHome.apk"; then
            sz=$(( $(wc -c < "$HOME_DIR/MiuiHome.apk") / 1048576 ))
            log_msg "LauncherOS3: MiuiHome.apk -> ${sz}MB"
        else
            warn_msg "LauncherOS3: copy MiuiHome thất bại"
            ok=0
        fi
        rm -f "$tmp" "$tmp.al"
    fi
fi

# --- 2. XiaomiEUExt (chỉ thêm khi ROM chưa có) -----------------------------
# Cần cho "ẩn app" và searchbar provider. Chữ ký khác platform nhưng app không
# share uid hệ thống nên chấp nhận được.
EXT_FOUND=""
for d in "$IMAGES/product/priv-app" "$IMAGES/system/priv-app" "$IMAGES/system_ext/priv-app"; do
    [ -d "$d" ] || continue
    hit=$(find "$d" -maxdepth 2 -type f -name 'XiaomiEu*Ext.apk' 2>/dev/null | head -n1)
    [ -n "$hit" ] && { EXT_FOUND="$hit"; break; }
done

if [ -n "$EXT_FOUND" ]; then
    log_msg "LauncherOS3: ROM đã có XiaomiEuExt ($(basename "$EXT_FOUND")) - giữ nguyên"
elif [ -s "$SRC/files/XiaomiEUExt.apk" ] && [ -d "$IMAGES/product/priv-app" ]; then
    mkdir -p "$IMAGES/product/priv-app/XiaomiEuExt"
    rm -rf "$IMAGES/product/priv-app/XiaomiEuExt/oat"
    if cp -f "$SRC/files/XiaomiEUExt.apk" "$IMAGES/product/priv-app/XiaomiEuExt/XiaomiEUExt.apk"; then
        log_msg "LauncherOS3: thêm XiaomiEUExt vào product/priv-app"
    else
        warn_msg "LauncherOS3: copy XiaomiEUExt thất bại"
    fi
else
    warn_msg "LauncherOS3: bỏ qua XiaomiEUExt"
fi

# --- 3. privapp whitelist --------------------------------------------------
# PHẢI thêm file của mod, không bỏ qua: file gốc của ROM chỉ cấp 17 quyền, mod
# cần thêm 11 quyền (SET_PROCESS_LIMIT, BIND_WALLPAPER, DUMP, READ_PHONE_STATE,
# MOUNT_UNMOUNT_FILESYSTEMS...). Hai file cùng tồn tại, Android hợp nhất quyền.
PERM_DIR="$IMAGES/product/etc/permissions"
if [ -d "$PERM_DIR" ]; then
    for x in "$SRC"/perm/*.xml; do
        [ -f "$x" ] || continue
        base=$(basename "$x")
        if [ -f "$PERM_DIR/$base" ]; then
            log_msg "LauncherOS3: $base đã có trong ROM - không ghi đè"
        else
            cp -f "$x" "$PERM_DIR/$base" && log_msg "LauncherOS3: $base -> product/etc/permissions"
        fi
    done
else
    warn_msg "LauncherOS3: không có product/etc/permissions - bỏ qua whitelist"
fi

# --- 4. Overlay ------------------------------------------------------------
# Chỉ thay khi overlay của ROM KHÔNG chứa 3 resource mà mod bổ sung (assistant /
# content suggestions / contextual search). Nếu ROM đã có đủ thì giữ bản ROM
# (bản của ROM mới hơn: v37 vs v34).
OV_DIR="$IMAGES/product/overlay"
OV_SRC="$SRC/overlay/MiuiHomeLauncherResOverlay.apk"
if [ -d "$OV_DIR" ] && [ -s "$OV_SRC" ]; then
    OV_DEST="$OV_DIR/MiuiHomeLauncherResOverlay.apk"
    if [ -f "$OV_DEST" ]; then
        # Đếm số resource trong overlay hiện tại của ROM (tìm theo chuỗi thô
        # trong resources.arsc để không phụ thuộc aapt2 có mặt trên build host).
        has_extra=0
        for k in config_defaultAssistant config_defaultContentSuggestionsService config_defaultContextualSearchPackageName; do
            grep -aq "$k" "$OV_DEST" 2>/dev/null && has_extra=$((has_extra + 1))
        done
        if [ "$has_extra" -eq 3 ]; then
            log_msg "LauncherOS3: overlay ROM đã có đủ resource - giữ nguyên"
        else
            cp -f "$OV_SRC" "$OV_DEST" && \
                log_msg "LauncherOS3: cập nhật overlay (thêm assistant/search resource)" || \
                warn_msg "LauncherOS3: copy overlay thất bại"
        fi
    else
        cp -f "$OV_SRC" "$OV_DEST" && log_msg "LauncherOS3: thêm overlay miui.home.launcher.res" || \
            warn_msg "LauncherOS3: thêm overlay thất bại"
    fi
else
    warn_msg "LauncherOS3: thiếu overlay nguồn hoặc product/overlay - bỏ qua overlay"
fi

# --- 5. init.miui.ext.rc (chỉ khi brand POCO) ------------------------------
# mod gốc đổi com.mi.android.globallauncher -> com.miui.home trong file này, vì
# ROM POCO set ro.miui.product.home trỏ launcher POCO. ROM Xiaomi/Redmi đã đúng
# sẵn nên không cần đụng. Chỉ sửa khi chắc chắn là build POCO.
BRAND=$(grep -m1 '^ro\.product\.brand=' "$IMAGES/product/build.prop" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
[ -z "$BRAND" ] && BRAND=$(grep -m1 '^ro\.product\.brand=' "$IMAGES/system/build.prop" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
INIT_RC=$(find "$IMAGES" -maxdepth 4 -path '*/system_ext/etc/init/init.miui.ext.rc' 2>/dev/null | head -n1)
if [ "$BRAND" = "POCO" ] && [ -n "$INIT_RC" ]; then
    if grep -q 'com.mi.android.globallauncher' "$INIT_RC" 2>/dev/null; then
        sed -i 's/com\.mi\.android\.globallauncher/com.miui.home/g' "$INIT_RC" && \
            log_msg "LauncherOS3: init.miui.ext.rc -> com.miui.home (build POCO)" || \
            warn_msg "LauncherOS3: sửa init.miui.ext.rc thất bại"
    fi
else
    log_msg "LauncherOS3: brand='${BRAND:-?}' - không cần sửa init.miui.ext.rc"
fi

log_msg "LauncherOS3: xong (credit: Kashi / Mods Center)"
exit 0
