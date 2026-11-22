#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# COREPATCH/logging.sh - log cho bộ COREPATCH.
#
# KHÔNG tự định nghĩa lại warn nữa: trước đây file này ghi `[WARN] ...` trong
# khi phần còn lại của build ghi `[19:14:53] WARN ...`, nên log COREPATCH lẫn
# với log chung thành hai định dạng. Giờ mọi thứ đi qua lib/log.sh.
#
# Giữ tên `log` và `err` vì patching.sh / apk_ops.sh / jar_patcher_a17.sh đang
# gọi hai tên đó ở hàng chục chỗ.
# ---------------------------------------------------------------------------

# Nạp log dùng chung nếu chưa có (helper.sh source file này sau patching.sh).
if ! declare -F _bugos_log >/dev/null 2>&1; then
    _LOG_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)/lib/log.sh"
    # shellcheck source=/dev/null
    [ -f "$_LOG_SH" ] && source "$_LOG_SH"
fi

# Tên cũ ánh xạ sang hàm chung (giữ chữ ký để không phải sửa caller).
log() { info  "$@"; }
err() { error "$@"; }

# Dự phòng: nếu vì lý do nào đó không nạp được lib/log.sh thì vẫn phải có hàm,
# không để script chết vì "command not found".
if ! declare -F info >/dev/null 2>&1; then
    info()  { printf '[INFO] %s\n'  "$*" >&2; }
    warn()  { printf '[WARN] %s\n'  "$*" >&2; }
    error() { printf '[ERROR] %s\n' "$*" >&2; }
    # debug cũng phải có: patching.sh đã chuyển 7 dòng "✓ Patched ..." sang
    # debug. Thiếu hàm này thì mỗi lần vá xong sẽ in "debug: command not found".
    debug() { :; }
fi

# Progress indicator (giữ hành vi cũ: ghi đè một dòng bằng \r).
show_progress() {
  local current="$1"
  local total="$2"
  local description="$3"
  local percent=$((current * 100 / total))
  printf "\r[%3d%%] %s" "$percent" "$description" >&2
}

# Timing.
start_timer() {
  TIMER_START=$(date +%s)
}

end_timer() {
  local TIMER_END duration
  TIMER_END=$(date +%s)
  duration=$((TIMER_END - TIMER_START))
  info "Operation completed in ${duration}s"
}
