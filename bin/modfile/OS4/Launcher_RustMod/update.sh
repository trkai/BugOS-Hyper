#!/bin/bash
# BugOS - HyperOS 4 Rust/Flutter Launcher Mod (v1.4)
# ---------------------------------------------------------------------------
# Nguồn: "HyperOS 4 Launcher Mod (Rust/Flutter)" v1.4 của Kashi
#        (t.me/kashis_cringey_stuffs) - module Magisk nạp đè launcher trên máy.
#
# Mod gồm:
#   1. MiuiHome.apk  - launcher HyperOS 4 viết lại bằng Rust + Flutter
#      (com.miui.home 8.01.02.9258). hasCode=false, code nằm trong
#      lib/arm64-v8a/*.so; zip đã căn lề 4-byte và extractNativeLibs=false nên
#      phải giữ NGUYÊN từng byte - không được zipalign lại hay re-sign.
#   2. HyperLauncherExt.apk - app cài đặt riêng (com.miui.home.kashi.ext).
#   3. 2 file privapp-permissions.
#
# VÌ SAO KHÔNG RE-SIGN: MiuiHome.apk cố ý KHÔNG verify được chữ ký
# ("APK Signature Scheme v3: CHUNKED_SHA256 digest mismatch") vì đã bị mod.
# Trên Android 13+ bắt buộc phải tắt kiểm tra chữ ký - repo này đã có COREPATCH
# làm đúng việc đó (chạy sau, ở bước patchpackage). Nếu re-sign bằng key khác
# thì Android coi là package khác và mất quyền privileged -> launcher không chạy.
#
# VỊ TRÍ: product/priv-app (launcher gốc của ROM nằm ở đây). Mọi file mới phải
# nằm cùng phân vùng với file privapp-permissions của nó, nếu không quyền
# privileged không được cấp và launcher mất chức năng.
# ---------------------------------------------------------------------------

work_dir=$(pwd)
[ -f "$work_dir/functions.sh" ] && source "$work_dir/functions.sh"

SRC="$work_dir/bin/modfile/OS4/Launcher_RustMod"
IMAGES="$work_dir/build/baserom/images"

log_msg() {
    if type mods &>/dev/null; then mods "$1"
    elif type patch &>/dev/null; then patch "$1"
    else echo "[Launcher] $1"; fi
}
warn_msg() {
    if type warn &>/dev/null; then warn "$1"; else echo "[Launcher][WARN] $1"; fi
}

[ -d "$IMAGES" ] || { warn_msg "Launcher: chưa có images - bỏ qua"; exit 0; }

# --- 0. Công tắc: config.env có launcher_rust_mod=false thì thôi -----------
ENABLE=$(grep -m1 '^launcher_rust_mod=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
[ "$ENABLE" = "false" ] && { log_msg "Launcher: tắt bằng config (launcher_rust_mod=false)"; exit 0; }

# --- 1. Kiểm tra bộ nguồn --------------------------------------------------
for f in "$SRC/files/MiuiHome.apk" "$SRC/files/HyperLauncherExt.apk"; do
    if [ ! -s "$f" ]; then
        warn_msg "Launcher: thiếu $(basename "$f") - bỏ qua"
        exit 0
    fi
done
# APK phải là zip còn nguyên vẹn trước khi đưa vào ROM
for f in "$SRC/files/MiuiHome.apk" "$SRC/files/HyperLauncherExt.apk"; do
    if ! unzip -t "$f" >/dev/null 2>&1; then
        warn_msg "Launcher: $(basename "$f") hỏng (zip test fail) - bỏ qua"
        exit 0
    fi
done

# --- 2. Tìm thư mục launcher gốc ------------------------------------------
# Không đoán theo tên: tìm APK khai đúng package com.miui.home.
PRODDIR="$IMAGES/product"
[ -d "$PRODDIR" ] || { warn_msg "Launcher: ROM không có phân vùng product - bỏ qua"; exit 0; }

HOME_DIR=""
for cand in "$PRODDIR/priv-app/MiuiHome" "$PRODDIR/app/MiuiHome"; do
    [ -d "$cand" ] && { HOME_DIR="$cand"; break; }
done
if [ -z "$HOME_DIR" ]; then
    # dò theo tên file
    hit=$(find "$PRODDIR" -maxdepth 4 -type f -name 'MiuiHome.apk' 2>/dev/null | head -n1)
    [ -n "$hit" ] && HOME_DIR=$(dirname "$hit")
fi
if [ -z "$HOME_DIR" ] || [ ! -d "$HOME_DIR" ]; then
    warn_msg "Launcher: không thấy MiuiHome.apk trong product - bỏ qua (ROM này không dùng launcher chuẩn?)"
    exit 0
fi

if [ -d "$PRODDIR/priv-app" ] && [ "$(basename "$(dirname "$HOME_DIR")")" = "app" ]; then
    warn_msg "Launcher: MiuiHome đang ở product/app (không phải priv-app) - launcher cần quyền privileged, bỏ qua để tránh mất chức năng"
    exit 0
fi

log_msg "Launcher: thay $(basename "$HOME_DIR")/MiuiHome.apk"

# --- 3. Thay launcher ------------------------------------------------------
# Xoá mã biên dịch sẵn của bản cũ: odex không khớp APK mới sẽ làm ART từ chối nạp.
rm -rf "$HOME_DIR/oat"
find "$HOME_DIR" -maxdepth 1 -type f \( -name '*.odex' -o -name '*.vdex' -o -name '*.art' \) -delete 2>/dev/null

if cp -f "$SRC/files/MiuiHome.apk" "$HOME_DIR/MiuiHome.apk"; then
    sz=$(( $(wc -c < "$HOME_DIR/MiuiHome.apk") / 1048576 ))
    log_msg "Launcher: MiuiHome.apk -> ${sz}MB (Rust/Flutter, native libs giữ nguyên)"
else
    warn_msg "Launcher: copy MiuiHome.apk thất bại - giữ launcher gốc"
    exit 0
fi

# --- 4. Cài HyperLauncherExt ----------------------------------------------
EXT_DIR="$PRODDIR/priv-app/HyperLauncherExt"
mkdir -p "$EXT_DIR"
if cp -f "$SRC/files/HyperLauncherExt.apk" "$EXT_DIR/HyperLauncherExt.apk"; then
    log_msg "Launcher: HyperLauncherExt.apk -> product/priv-app/HyperLauncherExt"
else
    warn_msg "Launcher: copy HyperLauncherExt thất bại (không ảnh hưởng launcher)"
fi

# --- 5. privapp-permissions ----------------------------------------------
# Bắt buộc: launcher xin ~38 quyền privileged. Thiếu allowlist thì ROM bật
# chế độ enforce sẽ từ chối cấp quyền, launcher mất chức năng (và có thể không
# boot được nếu ro.control_privapp_permissions=enforce).
PERM_DIR="$PRODDIR/etc/permissions"
mkdir -p "$PERM_DIR"
for x in "$SRC"/perm/*.xml; do
    [ -f "$x" ] || continue
    if cp -f "$x" "$PERM_DIR/$(basename "$x")"; then
        log_msg "Launcher: $(basename "$x") -> product/etc/permissions"
    else
        warn_msg "Launcher: copy $(basename "$x") thất bại"
    fi
done

log_msg "Launcher: xong (credit: Kashi - t.me/kashis_cringey_stuffs)"
exit 0
