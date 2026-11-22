#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# bin/rom/fetch.sh - lấy ROM về build/rom/base.zip
#
#   bash bin/rom/fetch.sh <https://... | /duong/dan/rom.zip>
#
# Nguyên tắc:
#   1. Tên file CỐ ĐỊNH (build/rom/base.zip). Server trả Content-Disposition
#      tên gì cũng không ảnh hưởng - đây là lỗi cũ: kiểm tra file theo tên suy
#      ra từ URL nên download xong vẫn báo "hỏng".
#   2. Tên gốc của ROM vẫn được lưu vào state (rom_file_name) vì bước đặt
#      codename dùng nó như một nguồn đối chiếu - nhưng không nguồn nào bắt
#      buộc phải có.
#   3. File zip cục bộ do người dùng đưa vào KHÔNG bị copy và KHÔNG bị xoá.
# ---------------------------------------------------------------------------

set -uo pipefail

ROOT=$(cd "$(dirname "$0")/../.." && pwd)
source "$ROOT/lib/log.sh"
source "$ROOT/lib/env.sh"
source "$ROOT/bin/rom/state.sh"

SRC="${1:-}"
if [ -z "$SRC" ]; then
    error "Dùng: bash bin/rom/fetch.sh <url | đường-dẫn-zip>"
    exit 1
fi

# Zip hợp lệ = có file, không rỗng, và unzip đọc được toàn bộ central directory.
# `unzip -t` là thứ duy nhất phát hiện được zip bị cắt ngang; `-f` thì không.
zip_ok() {
    [ -s "$1" ] || return 1
    unzip -tqq "$1" >/dev/null 2>&1
}

state_set rom_file_name "$(basename "${SRC%%\?*}")"

# --- Nguồn là file cục bộ --------------------------------------------------
if [ -f "$SRC" ]; then
    abs="$(cd "$(dirname "$SRC")" && pwd)/$(basename "$SRC")"
    info "Dùng ROM cục bộ: $abs"

    zip_ok "$abs" || die "File không phải zip hợp lệ (hoặc bị cắt ngang): $abs"
    require_file "$abs" "ROM" || exit 1

    state_set rom_zip "$abs"
    state_set rom_zip_origin "local"
    state_set rom_size "$(du -h "$abs" | cut -f1)"
    info "ROM: $(size_of "$abs") - sẽ KHÔNG xoá file này sau khi unpack"
    exit 0
fi

# --- Nguồn là URL ----------------------------------------------------------
case "$SRC" in
    http://*|https://*) ;;
    *)
        error "Tham số không phải file cũng không phải URL http(s): $SRC"
        exit 1
        ;;
esac

require_cmds aria2c unzip || exit 1
require_free_gb 20 "$ROOT" || die "Không đủ dung lượng để tải ROM"

mkdir -p "$ROM_DIR"

# aria2 phải ghi đúng tên ta muốn: --out. Resume dùng file điều khiển .aria2
# nằm cạnh nó, nên lần thử lại không mất phần đã tải (khi file chưa hỏng).
attempt=1
while [ "$attempt" -le 3 ]; do
    if [ "$attempt" -gt 1 ]; then
        warn "Lần tải $attempt/3 - xoá phần đã tải để bắt đầu lại từ đầu"
        rm -f "$ROM_ZIP" "$ROM_ZIP.aria2"
    fi

    info "Đang tải (lần $attempt/3): $SRC"
    aria2c -c --max-tries=5 --retry-wait=5 \
        --timeout=60 --connect-timeout=30 --lowest-speed-limit=10K \
        --summary-interval=15 --console-log-level=warn \
        --file-allocation=none -s10 -x10 -j10 \
        --out="$ROM_ZIP" \
        -U "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
        "$SRC" || true

    if zip_ok "$ROM_ZIP"; then
        break
    fi
    warn "File tải về chưa dùng được (thiếu byte hoặc zip hỏng)"
    attempt=$((attempt + 1))
done

zip_ok "$ROM_ZIP" || die "Tải ROM thất bại sau 3 lần: $SRC"

rm -f "$ROM_ZIP.aria2"
state_set rom_zip "$ROM_ZIP"
state_set rom_zip_origin "download"
state_set rom_size "$(du -h "$ROM_ZIP" | cut -f1)"

info "Tải xong: $(size_of "$ROM_ZIP") -> $ROM_ZIP"
