#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# bin/rom/inspect.sh - đọc zip TRƯỚC khi bung, không giải nén gì nặng.
#
# Việc duy nhất: xác định ROM đóng gói theo kiểu nào (payload.bin / new.dat.br /
# super.img) và tách metadata OTA ra file riêng. Metadata phải tách ra NGAY vì
# bước unpack sẽ xoá zip, mà bước đặt codename về sau vẫn cần nó.
# ---------------------------------------------------------------------------

set -uo pipefail

ROOT=$(cd "$(dirname "$0")/../.." && pwd)
source "$ROOT/lib/log.sh"
source "$ROOT/lib/env.sh"
source "$ROOT/bin/rom/state.sh"

ZIP=$(state_get rom_zip) || die "Chưa có ROM trong state - chạy bin/rom/fetch.sh trước"
require_file "$ZIP" "ROM zip" || exit 1

require_cmds unzip || exit 1
mkdir -p "$ROM_DIR"

section "Đọc cấu trúc ROM"

# Danh sách entry lấy từ central directory - nhanh, không đọc toàn bộ 8 GB
# (fetch.sh đã kiểm CRC một lần rồi).
listing=$(unzip -Z -1 "$ZIP" 2>/dev/null) || die "Không đọc được zip: $ZIP"
[ -n "$listing" ] || die "Zip rỗng hoặc không có entry nào: $ZIP"

romtype=""
if printf '%s\n' "$listing" | grep -qx 'payload.bin'; then
    romtype="payload"
elif printf '%s\n' "$listing" | grep -qE '\.new\.dat\.br$'; then
    romtype="br"
elif printf '%s\n' "$listing" | grep -qE '(^|/)super\.img'; then
    romtype="super"
fi

[ -n "$romtype" ] || {
    error "Không nhận ra định dạng ROM trong $ZIP"
    error "Cần một trong: payload.bin | *.new.dat.br | super.img*"
    printf '%s\n' "$listing" | head -n 20 >&2
    exit 1
}

case "$romtype" in
    payload) info "Định dạng: payload.bin (OTA A/B)" ;;
    br)      info "Định dạng: *.new.dat.br (brotli)" ;;
    super)   info "Định dạng: super.img (fastboot/xiaomi.eu)" ;;
esac
state_set romtype "$romtype"

# --- Metadata OTA: nguồn codename chuẩn nhất, do Xiaomi ghi lúc đóng gói ----
meta=""
for path in META-INF/com/android/metadata META-INF/com/android/metadata.pb; do
    if printf '%s\n' "$listing" | grep -qx "$path"; then
        meta=$(unzip -p "$ZIP" "$path" 2>/dev/null) && [ -n "$meta" ] && break
        meta=""
    fi
done

if [ -n "$meta" ]; then
    printf '%s\n' "$meta" > "$OTA_METADATA"
    pre_device=$(printf '%s\n' "$meta" | sed -n 's/^pre-device=//p' | head -n1 | tr -d '\r')
    post_build=$(printf '%s\n' "$meta" | sed -n 's/^post-build=//p' | head -n1 | tr -d '\r')
    state_set ota_pre_device "$pre_device"
    state_set ota_post_build "$post_build"
    info "OTA metadata: pre-device='${pre_device:-?}' post-build='${post_build:-?}'"
else
    warn "ROM không có META-INF/com/android/metadata - bước đặt codename sẽ thiếu 1 nguồn"
fi

state_emit_compat
info "Cấu trúc ROM đã lưu vào state"
