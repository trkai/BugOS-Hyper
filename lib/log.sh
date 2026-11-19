#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# lib/log.sh - log + tiện ích dùng chung cho mọi script của BugOS.
#
# Mọi script `source` file này thay vì tự định nghĩa mods/info/warn/error, để
# toàn bộ log có cùng định dạng và chỉ có MỘT chỗ để sửa.
#
# File này chỉ định nghĩa hàm. Nó KHÔNG đặt `set -e`, KHÔNG thoát (trừ `die`),
# nên source ở đâu cũng an toàn.
#
# Log đi ra stderr: stdout giữ nguyên cho dữ liệu (script nào cần bắt output
# của lệnh con sẽ không bị lẫn log vào).
# ---------------------------------------------------------------------------

if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
    _C_RST=$'\e[0m'
    _C_BOLD=$'\e[1m'
    _C_DIM=$'\e[2m'
    _C_RED=$'\e[1;31m'
    _C_GRN=$'\e[1;32m'
    _C_YEL=$'\e[1;33m'
    _C_BLU=$'\e[1;34m'
    _C_MAG=$'\e[1;35m'
    _C_CYN=$'\e[1;36m'
else
    _C_RST=; _C_BOLD=; _C_DIM=; _C_RED=; _C_GRN=
    _C_YEL=; _C_BLU=; _C_MAG=; _C_CYN=
fi

_bugos_now() { date +%H:%M:%S; }

# _bugos_log <màu> <tag> <nội dung...>
_bugos_log() {
    local color=$1 tag=$2
    shift 2
    printf '%s[%s] %-7s%s %s\n' "$color" "$(_bugos_now)" "$tag" "$_C_RST" "$*" >&2
}

# Tên hàm giữ đúng như bản cũ để không phải sửa 40 script đang gọi chúng.
mods()   { _bugos_log "$_C_CYN" "MODS"   "$@"; }
info()   { _bugos_log "$_C_BLU" "INFO"   "$@"; }
warn()   { _bugos_log "$_C_YEL" "WARN"   "$@"; }
error()  { _bugos_log "$_C_RED" "ERROR"  "$@"; }
patch()  { _bugos_log "$_C_MAG" "PATCH"  "$@"; }
unpack() { _bugos_log "$_C_GRN" "UNPACK" "$@"; }
repack() { _bugos_log "$_C_GRN" "REPACK" "$@"; }
upload() { _bugos_log "$_C_GRN" "UPLOAD" "$@"; }
# Hai hàm cũ còn dùng trong functions.sh (tách partition theo định dạng).
unpack_erofs() { _bugos_log "$_C_GRN" "EROFS"  "$@"; }
unpack_ext()   { _bugos_log "$_C_GRN" "EXT4"   "$@"; }

# Tiêu đề một bước lớn, để log dài còn đọc được.
section() {
    printf '\n%s==> %s%s\n' "$_C_BOLD" "$*" "$_C_RST" >&2
}

# Đánh số bước tự động: step "Tên bước" -> "==> [3] Tên bước"
# Giúp khi build chết thì biết ngay dừng ở bước nào, không phải đọc cả log.
_BUGOS_STEP=0
step() {
    _BUGOS_STEP=$((_BUGOS_STEP + 1))
    printf '\n%s==> [%d] %s%s\n' "$_C_BOLD" "$_BUGOS_STEP" "$*" "$_C_RST" >&2
}

# Chạy một bước build; nếu thất bại thì báo rõ số bước rồi thoát.
# Dùng: run_step "Vá de-China" bash bin/package/PRECHINAFIX/apply.sh
run_step() {
    local title=$1
    shift
    step "$title"
    local t0 rc
    t0=$(date +%s)
    "$@"
    rc=$?
    local dur=$(( $(date +%s) - t0 ))
    if [ "$rc" -ne 0 ]; then
        error "Bước $_BUGOS_STEP ('$title') thất bại sau ${dur}s (mã $rc)"
        return "$rc"
    fi
    debug "Bước $_BUGOS_STEP xong sau ${dur}s"
    return 0
}

# Log ở mức thấp, chỉ hiện khi DEBUG=1.
debug() {
    [ "${DEBUG:-0}" = "1" ] || return 0
    _bugos_log "$_C_DIM" "DEBUG" "$@"
}

# Dừng build. Dùng cho mọi lỗi không thể tiếp tục.
die() {
    error "$@"
    exit 1
}

exists() { command -v "$1" >/dev/null 2>&1; }

# require_cmds <tên...> - kiểm tra TẤT CẢ rồi báo một lần, thay vì chết ở cái
# đầu tiên (người dùng phải sửa 1 lần thay vì N lần).
# KHÔNG tự cài: việc cài package thuộc setup.sh.
require_cmds() {
    local missing=() t
    for t in "$@"; do
        exists "$t" || missing+=("$t")
    done
    if [ ${#missing[@]} -gt 0 ]; then
        error "Thiếu tool: ${missing[*]}"
        error "Cài bằng: sudo bash setup.sh"
        return 1
    fi
    return 0
}

require_file() {
    [ -s "$1" ] && return 0
    error "Thiếu file: $1${2:+ ($2)}"
    return 1
}

# require_free_gb <gb> [đường dẫn] - đo dung lượng còn trống.
require_free_gb() {
    local min=$1 path=${2:-.} avail
    avail=$(df -BG --output=avail "$path" 2>/dev/null | tail -n1 | tr -dc '0-9')
    if [ -z "$avail" ]; then
        warn "Không đọc được dung lượng trống của $path - bỏ qua kiểm tra"
        return 0
    fi
    if [ "$avail" -lt "$min" ]; then
        error "Chỉ còn ${avail}GB trống tại $path, cần tối thiểu ${min}GB"
        return 1
    fi
    info "Dung lượng trống: ${avail}GB (yêu cầu >= ${min}GB)"
    return 0
}

# Kích thước người đọc được: 1.2G / 340M
size_of() { du -sh "$1" 2>/dev/null | cut -f1; }
