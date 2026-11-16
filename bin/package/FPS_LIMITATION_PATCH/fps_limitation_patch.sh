#!/bin/bash
# BugOS - FPS Limitations Patcher (port cho build ROM)
# ---------------------------------------------------------------------------
# Nguồn: "FPS Limitations Patcher v4.0" của Kashi (t.me/kashis_cringey_stuffs)
#        - module Magisk/KernelSU patch PowerKeeper + Joyose trên máy đã cài.
#        - LICENSE: Unlicense (public domain) -> được phép nhúng vào ROM.
#        - Phần logic patch giữ nguyên trong fps_patches.sh (không sửa) để sau
#          này đối chiếu được với bản gốc khi Kashi ra v5.
#
# KHÁC BIỆT so với module gốc (quan trọng):
#   1. Module gốc chạy trên ĐIỆN THOẠI nên phải tự dựng ART runtime (dalvikvm,
#      BOOTCLASSPATH, DEX2OATBOOTCLASSPATH, fallback -Xint). Ở đây patch chạy
#      LÚC BUILD trên host, đã có Java sẵn -> dùng thẳng apke.jar, bỏ toàn bộ
#      phần ART. Nhờ vậy không phụ thuộc máy, build reproducible.
#   2. Module gốc sinh file vào /data/adb/modules và mount đè APK. Ở đây ta
#      thay APK ngay trong images -> không cần mount, không cần .replace.
#   3. Module gốc tự kiểm tra "signature verification must be disabled". Repo
#      này đã có COREPATCH làm việc đó (chạy trước mod này), nên không nhắc lại.
#
# Thứ tự gọi: patchpackage.sh gọi SAU COREPATCH (bắt buộc - nếu chạy trước thì
# APK đã patch sẽ bị từ chối nạp vì sai chữ ký).
# ---------------------------------------------------------------------------

work_dir=$(pwd)
[ -f "$work_dir/functions.sh" ] && source "$work_dir/functions.sh"

MOD_DIR="$work_dir/bin/package/FPS_LIMITATION_PATCH"
IMAGES="$work_dir/build/baserom/images"

log_msg() {
    if type mods &>/dev/null; then mods "$1"
    elif type patch &>/dev/null; then patch "$1"
    else echo "[FPS] $1"; fi
}
warn_msg() {
    if type warn &>/dev/null; then warn "$1"; else echo "[FPS][WARN] $1"; fi
}

if [ ! -d "$IMAGES" ]; then
    warn_msg "FPS: chưa có $IMAGES - bỏ qua (mod chạy ở bước đóng gói, sau khi bung ROM)"
    exit 0
fi

JAVA_BIN=java
if [ -n "$JAVA_HOME" ] && [ -x "$JAVA_HOME/bin/java" ]; then
    JAVA_BIN="$JAVA_HOME/bin/java"
fi
if ! "$JAVA_BIN" -version >/dev/null 2>&1; then
    warn_msg "FPS: không chạy được java - bỏ qua (cần JDK để build lại APK)"
    exit 0
fi

APKEDITOR="$work_dir/bin/apktool/apke.jar"
if [ ! -f "$APKEDITOR" ]; then
    warn_msg "FPS: thiếu $APKEDITOR - bỏ qua"
    exit 0
fi

# Kashi patch helpers (POSIX sh, không phụ thuộc bash)
. "$MOD_DIR/fps_patches.sh"
KASHI_PK_LOG=log_msg

WORK="$work_dir/.fps_work"
rm -rf "$WORK"
mkdir -p "$WORK"

# dex_has <apk> <chuỗi>  -> 0 nếu có
dex_has() {
    unzip -p "$1" 'classes*.dex' 2>/dev/null | grep -aqm1 -- "$2"
}

# already_patched <apk> <label> -> 0 nếu APK này đã được mod xử lý trước đó
#   PowerKeeper: mod đổi đường dẫn giả -> còn dấu vết "kashi_limit_buf_off"
#   Joyose:      mod làm rỗng method start -> chuỗi "start FC" biến mất
already_patched() {
    case "$2" in
        PowerKeeper) dex_has "$1" 'kashi_limit_buf_off' ;;
        Joyose)      ! dex_has "$1" 'start FC' ;;
        *)           return 1 ;;
    esac
}

# patch_app <tên gói> <nhãn> <hàm patch> <bắt buộc 1|0>
patch_app() {
    local pkg="$1" label="$2" fn="$3" required="$4"
    local apk rel out src

    log_msg "FPS: tìm $label…"
    apk=$(find "$IMAGES" -type f -name "$(basename "$pkg" | sed 's/^com\.//')*.apk" 2>/dev/null | head -n1)

    # Tìm theo đúng tên thư mục app (ổn định hơn đoán tên file)
    apk=$(find "$IMAGES" -type f -ipath "*/app/$label/$label.apk" 2>/dev/null | head -n1)
    if [ -z "$apk" ]; then
        # Một số ROM đặt tên file khác thư mục
        apk=$(find "$IMAGES" -type f -iname "$label.apk" 2>/dev/null | head -n1)
    fi

    if [ -z "$apk" ] || [ ! -f "$apk" ]; then
        if [ "$required" = 1 ]; then
            warn_msg "FPS: ROM không có $label.apk - bỏ qua mod (không phải lỗi build)"
        else
            log_msg "FPS: ROM không có $label.apk - bỏ qua"
        fi
        return 1
    fi
    log_msg "FPS: thấy $apk"

    # APK có thể đã được vá từ trước (build lại từ images đã mod, hoặc người dùng
    # đã flash mod này rồi nhúng vào ROM). Khi đó các anchor không còn khớp và
    # script sẽ báo "chưa hỗ trợ" một cách sai lệch -> nhận diện trước.
    if already_patched "$apk" "$label"; then
        log_msg "FPS: $label đã được vá từ trước - bỏ qua (không build lại)"
        return 0
    fi

    src="$WORK/src_$label"
    rm -rf "$src"
    log_msg "FPS: giải nén $label (chỉ dex)…"
    if ! "$JAVA_BIN" -jar "$APKEDITOR" d -t raw -i "$apk" -o "$src" >"$WORK/dec_$label.log" 2>&1; then
        warn_msg "FPS: giải nén $label thất bại - giữ APK gốc"
        tail -n 8 "$WORK/dec_$label.log" 2>/dev/null | while read -r l; do log_msg "   $l"; done
        return 1
    fi
    if [ ! -d "$src/smali" ]; then
        warn_msg "FPS: $label không có cây smali sau khi giải nén - giữ APK gốc"
        return 1
    fi

    log_msg "FPS: vá $label…"
    if ! "$fn" "$src"; then
        warn_msg "FPS: không khớp mẫu nào trong $label (bản $label này chưa được hỗ trợ) - giữ APK gốc"
        return 1
    fi

    out="$WORK/$label.patched.apk"
    rm -f "$out"
    log_msg "FPS: build lại $label…"
    if ! "$JAVA_BIN" -jar "$APKEDITOR" b -t raw -i "$src" -o "$out" >"$WORK/build_$label.log" 2>&1; then
        warn_msg "FPS: build lại $label thất bại - giữ APK gốc"
        tail -n 8 "$WORK/build_$label.log" 2>/dev/null | while read -r l; do log_msg "   $l"; done
        return 1
    fi
    if [ ! -s "$out" ] || ! unzip -l "$out" 2>/dev/null | grep -q 'classes.*\.dex'; then
        warn_msg "FPS: APK $label ra rỗng/thiếu dex - giữ APK gốc"
        return 1
    fi

    # Xoá odex/vdex cũ nằm cạnh APK: nếu còn, ART sẽ chạy code đã biên dịch của
    # bản gốc và mod coi như không có tác dụng.
    local d
    d=$(dirname "$apk")
    rm -f "$d/oat"/*/"$label".odex "$d/oat"/*/"$label".vdex "$d/oat"/*/"$label".art 2>/dev/null
    rmdir "$d/oat"/* 2>/dev/null
    rmdir "$d/oat" 2>/dev/null

    cp -f "$out" "$apk" && log_msg "FPS: đã thay $label trong images (đã vá)"
    return 0
}

# --- Bổ sung cho bản ROM này ---------------------------------------------
# Mục "PowerSaveModeHandler: no battery-saver CPU cap" của bản gốc tìm chuỗi
# "/sys/powersave/limit_buf". Trên PowerKeeper 4.2.00 (OS4.0.6) chuỗi đó không
# còn — Xiaomi đổi sang node thermal "/sys/class/thermal/power_save/powersave_mode"
# cùng các node ipa_*_limit. Bản gốc vì vậy bỏ qua mục này (không phải lỗi mod).
#
# QUYẾT ĐỊNH: KHÔNG vá bừa các node thermal. Đây là 2 loại node khác nhau:
#   - /sys/powersave/limit_buf  : trần xung do PowerKeeper tự đặt -> chặn được
#   - thermal_message/*_limit   : giới hạn của driver nhiệt -> chặn sẽ bỏ bảo vệ
#     phần cứng, đúng loại rủi ro không nên tự ý làm trên ROM phát hành.
# Nên mod giữ nguyên hành vi gốc: chỉ ghi nhận là "skipped" và để bảo vệ nhiệt
# hoạt động. Nếu sau này cần bỏ cả trần nhiệt thì phải làm thành tuỳ chọn riêng.
bugos_pk_patch_all() {
    local d="$1"
    KASHI_PK_LOG=log_msg kashi_pk_patch_all "$d"
    local rc=$?

    # Anchor thứ hai cũng đổi: bản gốc đợi "Lmiui/os/Build;->IS_DEBUGGABLE:Z",
    # ROM này dùng "Landroid/os/Build;->IS_DEBUGGABLE:Z". Vá được thì mở trang
    # *#*#76937#*#* (thông tin cloud) trên mọi bản build.
    local f
    f=$(kashi_pk_find "$d" 'com/miui/powerkeeper/cloudcontrol/CloudUpdateReceiver.smali')
    if [ -n "$f" ] && grep -q '"76937"' "$f" 2>/dev/null; then
        if grep -q 'Landroid/os/Build;->IS_DEBUGGABLE:Z' "$f" 2>/dev/null; then
            kashi_pk_sub "$f" 's#sget-boolean \([pv][0-9]*\), Landroid/os/Build;->IS_DEBUGGABLE:Z#const/16 \1, 0x1#' 'Landroid/os/Build;->IS_DEBUGGABLE:Z'
            if [ $? -eq 0 ]; then
                log_msg "   + CloudUpdateReceiver: *#*#76937#*#* (anchor android/os/Build)"
                # coi như đã xử lý xong mục này -> không tính là thiếu
                [ "$rc" -eq 0 ] && rc=0
            fi
        fi
    fi
    return $rc
}

FAILED=0
patch_app com.miui.powerkeeper PowerKeeper bugos_pk_patch_all 1 || FAILED=$((FAILED + 1))
patch_app com.xiaomi.joyose      Joyose      kashi_jy_patch_all 0 || FAILED=$((FAILED + 1))
rm -rf "$WORK"

if [ "$FAILED" -ge 2 ]; then
    warn_msg "FPS: không vá được cả PowerKeeper và Joyose - mod không có tác dụng trên bản ROM này"
fi

log_msg "FPS: xong (credit: Kashi - t.me/kashis_cringey_stuffs, Unlicense)"
exit 0
