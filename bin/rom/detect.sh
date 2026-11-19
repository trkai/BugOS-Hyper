#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# bin/rom/detect.sh - nhận diện ROM từ CHÍNH NỘI DUNG đã bung.
#
#   bash bin/rom/detect.sh [--region China|Global|EEAGlobal|...]
#
# Vì sao không đọc tên file: tên zip là thứ duy nhất người dùng có thể đổi, và
# bản cũ hỏng đúng ở đó - đổi tên file là mất OS/device/region dù ROM hoàn toàn
# hợp lệ. Ở đây mọi giá trị lấy từ build.prop; tên file chỉ còn là nguồn đối
# chiếu phụ (codename_from_file) cho bước chốt codename về sau.
#
# Đây cũng là nơi đặt CỔNG OS4: sai OS thì dừng ngay, không để các mod tự bỏ
# qua rồi build ra ROM thiếu mod mà vẫn báo thành công.
# ---------------------------------------------------------------------------

set -uo pipefail

ROOT=$(cd "$(dirname "$0")/../.." && pwd)
source "$ROOT/lib/log.sh"
source "$ROOT/lib/env.sh"
source "$ROOT/bin/rom/state.sh"

REGION_OVERRIDE=""
while [ $# -gt 0 ]; do
    case "$1" in
        --region) REGION_OVERRIDE="${2:-}"; shift 2 ;;
        --region=*) REGION_OVERRIDE="${1#--region=}"; shift ;;
        -h|--help) sed -n '2,16p' "$0"; exit 0 ;;
        *) die "Tham số lạ: $1" ;;
    esac
done

# Thứ tự đọc prop: system là nguồn chính, các partition khác chỉ để bù khi
# system thiếu key (một số ROM đặt prop phiên bản ở product/vendor).
PROP_FILES=(
    "$IMG_DIR/system/system/build.prop"
    "$IMG_DIR/system/build.prop"
    "$IMG_DIR/product/etc/build.prop"
    "$IMG_DIR/system_ext/etc/build.prop"
    "$IMG_DIR/vendor/build.prop"
    "$IMG_DIR/odm/etc/build.prop"
)

prop_get() {
    local key=$1 f v
    for f in "${PROP_FILES[@]}"; do
        [ -f "$f" ] || continue
        v=$(awk -v k="$key" 'index($0, k "=") == 1 { print substr($0, length(k) + 2); exit }' "$f")
        if [ -n "$v" ]; then
            printf '%s\n' "${v%$'\r'}"
            return 0
        fi
    done
    return 1
}

# Giá trị chung chung, không bao giờ là codename thật. Trùng danh sách với
# is_junk_codename() trong build.sh.
is_junk_codename() {
    case "$(printf '%s' "$1" | tr -d '\r\n ' | tr '[:upper:]' '[:lower:]')" in
        ""|yourdevice|missi|miproduct|mivendor|miui|hyperos|bugos|product|generic|unknown|xiaomi|device|phone|vendor|system|android|qssi|qssi64|qssi_64|emulator|goldfish|mainline)
            return 0 ;;
    esac
    return 1
}

norm() { printf '%s' "$1" | tr -d '\r\n ' | tr '[:upper:]' '[:lower:]'; }

# --- OS: chuỗi phiên bản luôn chứa "OS<n>" ---------------------------------
detect_rom_os() {
    local key val
    for key in ro.build.version.incremental ro.miui.os.version ro.miui.internal.version ro.build.version.base_os; do
        val=$(prop_get "$key") || continue
        if [[ $val =~ (OS[0-9]+) ]]; then
            printf '%s\n' "${BASH_REMATCH[1]}"
            return 0
        fi
    done
    # Cuối cùng: metadata OTA (post-build), ví dụ
    #   Xiaomi/songyuan/songyuan:16/BP2A.../OS4.0.1.0.WOCMIXM:user/release-keys
    if [ -f "$OTA_METADATA" ]; then
        val=$(sed -n 's/^post-build=//p' "$OTA_METADATA" | head -n1)
        if [[ $val =~ (OS[0-9]+) ]]; then
            printf '%s\n' "${BASH_REMATCH[1]}"
            return 0
        fi
    fi
    return 1
}

# --- Android release: release trước, sdk sau ---------------------------------
sdk_to_release() {
    case "$1" in
        33) echo 13 ;; 34) echo 14 ;; 35) echo 15 ;;
        36) echo 16 ;; 37) echo 17 ;; 38) echo 18 ;;
        *) echo "" ;;
    esac
}

# --- Region: CN/Global/EEA/... ----------------------------------------------
detect_region() {
    local region mod name

    region=$(prop_get ro.miui.build.region) || region=""
    case "$(printf '%s' "$region" | tr '[:lower:]' '[:upper:]')" in
        CN|CHINA) printf 'China\n'; return 0 ;;
        GL|GLOBAL|INT) printf 'Global\n'; return 0 ;;
        EEA) printf 'EEAGlobal\n'; return 0 ;;
        IN|INDIA) printf 'INGlobal\n'; return 0 ;;
        ID|INDONESIA) printf 'IDGlobal\n'; return 0 ;;
        RU|RUSSIA) printf 'RUGlobal\n'; return 0 ;;
        TW|TAIWAN) printf 'TWGlobal\n'; return 0 ;;
        TR|TURKEY) printf 'TRGlobal\n'; return 0 ;;
        JP|JAPAN) printf 'JPGlobal\n'; return 0 ;;
    esac

    mod=$(prop_get ro.product.mod_device) || mod=""
    case "$mod" in
        *_eea_global) printf 'EEAGlobal\n'; return 0 ;;
        *_in_global)  printf 'INGlobal\n';  return 0 ;;
        *_id_global)  printf 'IDGlobal\n';  return 0 ;;
        *_ru_global)  printf 'RUGlobal\n';  return 0 ;;
        *_jp_global)  printf 'JPGlobal\n';  return 0 ;;
        *_tw_global)  printf 'TWGlobal\n';  return 0 ;;
        *_tr_global)  printf 'TRGlobal\n';  return 0 ;;
        *_global)     printf 'Global\n';    return 0 ;;
        "" ) : ;;
        * ) printf 'China\n'; return 0 ;;
    esac

    # Không có prop nào: dùng tên file làm gợi ý (không bắt buộc phải có).
    name=$(state_get rom_file_name) || name=""
    case "$name" in
        *EEAGlobal*) printf 'EEAGlobal\n' ;;
        *INGlobal*)  printf 'INGlobal\n' ;;
        *IDGlobal*)  printf 'IDGlobal\n' ;;
        *RUGlobal*)  printf 'RUGlobal\n' ;;
        *JPGlobal*)  printf 'JPGlobal\n' ;;
        *TWGlobal*)  printf 'TWGlobal\n' ;;
        *TRGlobal*)  printf 'TRGlobal\n' ;;
        *Global*)    printf 'Global\n' ;;
        *)           printf 'China\n' ;;
    esac
}

main() {
    state_load

    section "Nhận diện ROM"

    local n_props=0 f
    for f in "${PROP_FILES[@]}"; do
        [ -f "$f" ] && n_props=$((n_props + 1))
    done
    [ "$n_props" -gt 0 ] || die "Không thấy build.prop nào trong $IMG_DIR - chạy bin/rom/unpack.sh trước"

    # ROM_OS
    local rom_os
    rom_os=$(detect_rom_os) || {
        error "Không tìm được 'OS<n>' trong bất kỳ prop phiên bản nào"
        error "Đã đọc: $(printf '%s ' "${PROP_FILES[@]}")"
        for f in ro.build.version.incremental ro.miui.os.version ro.miui.internal.version; do
            error "  $f = '$(prop_get "$f" || true)'"
        done
        exit 1
    }

    # Android + SDK
    local androidver sdk
    androidver=$(prop_get ro.system.build.version.release) || androidver=""
    [ -z "$androidver" ] && androidver=$(prop_get ro.build.version.release) || true

    sdk=$(prop_get ro.system.build.version.sdk) || sdk=""
    [ -z "$sdk" ] && sdk=$(prop_get ro.build.version.sdk) || true

    if [ -z "$androidver" ] && [ -n "$sdk" ]; then
        androidver=$(sdk_to_release "$sdk")
        [ -n "$androidver" ] && warn "Không có prop release - suy ra Android $androidver từ SDK $sdk"
    fi
    if [ -z "$sdk" ] && [ -n "$androidver" ]; then
        case "$androidver" in
            13) sdk=33 ;; 14) sdk=34 ;; 15) sdk=35 ;;
            16) sdk=36 ;; 17) sdk=37 ;; 18) sdk=38 ;;
        esac
        warn "Không có prop SDK - suy ra SDK=$sdk từ Android $androidver"
    fi
    [ -n "$androidver" ] || die "Không xác định được phiên bản Android (thiếu cả release và sdk trong build.prop)"

    # Region
    local region
    region="${REGION_OVERRIDE:-$(detect_region)}"
    case "$region" in
        China|Global|EEAGlobal|INGlobal|IDGlobal|RUGlobal|TWGlobal|TRGlobal|JPGlobal) ;;
        *) die "Region không hợp lệ: '$region'" ;;
    esac

    # Codename: nội dung thắng, tên file chỉ để đối chiếu
    local device_code="" k v
    for k in ro.product.product.device ro.product.vendor.device ro.product.device ro.product.system.device ro.build.product; do
        v=$(prop_get "$k") || continue
        if ! is_junk_codename "$v"; then
            device_code=$(norm "$v")
            break
        fi
    done

    local codename_from_file=""
    local rom_name
    rom_name=$(state_get rom_file_name) || rom_name=""
    if [ -n "$rom_name" ]; then
        # Cùng quy ước với bản cũ: phần đầu tên file, bỏ hậu tố vùng.
        codename_from_file=$(printf '%s' "${rom_name%%-*}" \
            | sed 's/\(Global\|EEAGlobal\|INGlobal\|IDGlobal\|RUGlobal\|TWGlobal\|TRGlobal\|JPGlobal\)$//' \
            | tr '[:upper:]' '[:lower:]' | tr -d '\r\n ')
        is_junk_codename "$codename_from_file" && codename_from_file=""
    fi

    # base_rom_code: chuỗi OSx.y.z... để đặt tên gói và hiển thị
    local base_rom_code="" val
    for k in ro.build.version.incremental ro.miui.internal.version ro.miui.os.version; do
        val=$(prop_get "$k") || continue
        if [[ $val =~ (OS[0-9]+\.[0-9A-Za-z.]+) ]]; then
            base_rom_code="${BASH_REMATCH[1]}"
            break
        fi
    done
    if [ -z "$base_rom_code" ] && [ -f "$OTA_METADATA" ]; then
        val=$(sed -n 's/^post-build=//p' "$OTA_METADATA" | head -n1)
        if [[ $val =~ (OS[0-9]+\.[0-9A-Za-z.]+) ]]; then
            base_rom_code="${BASH_REMATCH[1]}"
        fi
    fi
    if [ -z "$base_rom_code" ]; then
        base_rom_code="${rom_os}.0"
        warn "Không đọc được chuỗi phiên bản đầy đủ - dùng '$base_rom_code'"
    fi

    # --- Ghi state --------------------------------------------------------
    state_set rom_os "$rom_os"
    state_set androidver "$androidver"
    state_set sdk "$sdk"
    state_set device_type "$region"
    state_set device_code "$device_code"
    state_set device_f "$device_code"
    state_set codename_from_file "$codename_from_file"
    state_set base_rom_code "$base_rom_code"
    state_set os_code "$base_rom_code"
    state_set os_type "BugOS"
    state_set romtype "$(state_get romtype || true)"
    state_emit_compat

    section "ROM"
    printf '    %-16s %s\n' \
        "OS" "$rom_os" \
        "Android" "$androidver (SDK ${sdk:-?})" \
        "Region" "$region" \
        "Codename" "${device_code:-<không đọc được>}" \
        "Base ROM" "$base_rom_code" >&2
    if [ -n "$codename_from_file" ] && [ -n "$device_code" ] && [ "$codename_from_file" != "$device_code" ]; then
        warn "Tên file ghi '$codename_from_file' nhưng ROM ghi '$device_code' (build.sh sẽ kiểm tra lại)"
    fi

    # --- CỔNG OS4 ---------------------------------------------------------
    if [ "$rom_os" != "OS4" ]; then
        error "Repo này chỉ build OS4, nhưng ROM là '$rom_os'."
        error "Base ROM: $base_rom_code (Android $androidver, $region)"
        error "Chặn ở đây vì nếu đi tiếp, mọi mod sẽ tự bỏ qua và tạo ra ROM"
        error "thiếu mod mà vẫn báo build thành công."
        exit 1
    fi

    info "Đạt cổng OS4"
}

main "$@"
