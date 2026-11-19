#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# bin/rom/state.sh - trạng thái của ROM đang build. File này được SOURCE, không
# chạy trực tiếp.
#
# Một nguồn sự thật duy nhất là build/rom/state.env (dạng KEY=VALUE). Nhưng 20
# script cũ vẫn đọc bin/ddevice/*.txt bằng `cat`, nên `state_emit_compat` ghi
# kèm bản sao sang đó. Khi các stage sau được làm lại, chỉ cần bỏ hàm này.
# ---------------------------------------------------------------------------

if [ -z "${STATE_FILE:-}" ]; then
    STATE_FILE="${BUGOS_ROOT:-$(pwd)}/build/rom/state.env"
fi
if [ -z "${DEVICE_DIR:-}" ]; then
    DEVICE_DIR="${BUGOS_ROOT:-$(pwd)}/bin/ddevice"
fi

# state_set <key> <value...>
state_set() {
    local key=$1
    shift
    local value="$*"

    mkdir -p "$(dirname "$STATE_FILE")"
    touch "$STATE_FILE"

    if grep -q "^${key}=" "$STATE_FILE" 2>/dev/null; then
        awk -v k="$key" -v v="$value" '
            BEGIN { done = 0 }
            index($0, k "=") == 1 && done == 0 { print k "=" v; done = 1; next }
            { print }
        ' "$STATE_FILE" > "${STATE_FILE}.tmp" || return 1
        mv "${STATE_FILE}.tmp" "$STATE_FILE"
    else
        printf '%s=%s\n' "$key" "$value" >> "$STATE_FILE"
    fi
}

# state_get <key> - in giá trị, không có thì in rỗng và trả 1.
state_get() {
    local v
    [ -f "$STATE_FILE" ] || return 1
    v=$(awk -v k="$1" 'index($0, k "=") == 1 { print substr($0, length(k) + 2); exit }' "$STATE_FILE")
    [ -n "$v" ] || return 1
    printf '%s\n' "$v"
}

# Nạp toàn bộ state vào biến môi trường (dùng khi cần nhìn nhanh).
state_load() {
    [ -f "$STATE_FILE" ] || return 0
    local k v
    while IFS='=' read -r k v; do
        case "$k" in ''|'#'*) continue ;; esac
        export "$k=$v" 2>/dev/null || true
    done < "$STATE_FILE"
}

state_dump() {
    [ -f "$STATE_FILE" ] || { info "State rỗng: $STATE_FILE"; return 0; }
    printf '%s--- %s ---%s\n' "$_C_DIM" "$STATE_FILE" "$_C_RST" >&2
    sed 's/^/    /' "$STATE_FILE" >&2
}

# Ghi bản sao sang bin/ddevice/*.txt cho các script cũ. Chỉ ghi giá trị khác
# rỗng - một biến chưa set không được phép xoá trắng file đang dùng.
state_emit_compat() {
    mkdir -p "$DEVICE_DIR"
    local pair key file value
    for pair in \
        rom_os:rom_os.txt \
        os_code:os_code.txt \
        base_rom_code:base_rom_code.txt \
        device_code:device_code.txt \
        device_f:device_f.txt \
        device_type:device_type.txt \
        romtype:romtype.txt \
        androidver:androidver.txt \
        sdk:sdkLevel.txt \
        fstype:fstype.txt; do
        key=${pair%%:*}
        file=${pair##*:}
        value=$(state_get "$key") || continue
        printf '%s\n' "$value" > "$DEVICE_DIR/$file"
    done
}
