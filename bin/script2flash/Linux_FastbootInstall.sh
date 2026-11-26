#!/usr/bin/env bash
# Classic ROM Installer - Linux
# Giữ nguyên luồng gốc, chỉ gọn lại giao diện và sửa đường dẫn fastboot/zstd.

cd "$(dirname "$0")" || exit 1

BAR="=========================================================================================="
if [ -t 1 ]; then
    C_CYAN=$'\033[96m'; C_GREEN=$'\033[92m'; C_YELLOW=$'\033[93m'; C_RED=$'\033[91m'; C_OFF=$'\033[0m'
else
    C_CYAN=''; C_GREEN=''; C_YELLOW=''; C_RED=''; C_OFF=''
fi

hr()      { printf '%s\n' "$BAR"; }
say()     { printf '  %s\n' "$*"; }
ok()      { printf '  %s[OK]%s %s\n' "$C_GREEN" "$C_OFF" "$*"; }
warn()    { printf '  %s[!]%s %s\n' "$C_YELLOW" "$C_OFF" "$*"; }
err()     { printf '  %s[X]%s %s\n' "$C_RED" "$C_OFF" "$*"; }
section() { printf '\n%s\n  %s%s%s\n%s\n' "$BAR" "$C_CYAN" "$*" "$C_OFF" "$BAR"; }
progress() {
    local cur=$1 tot=$2 pct filled i bar
    [ "$tot" -le 0 ] && tot=1
    pct=$((cur * 100 / tot))
    filled=$((pct / 5))
    bar=""
    i=0
    while [ "$i" -lt "$filled" ]; do bar="${bar}#"; i=$((i + 1)); done
    while [ "$i" -lt 20 ]; do bar="${bar}."; i=$((i + 1)); done
    printf '  [%s] %s%%\n' "$bar" "$pct"
}

FASTBOOT=""
ZSTD=""
DEVICE_ROM=""
DEVICE_REAL=""
SLOTS=""
CHOICE="n"

ensure_fastboot() {
    if command -v fastboot >/dev/null 2>&1; then
        FASTBOOT="fastboot"
        return 0
    fi
    if [ -x "META-INF/fastboot" ]; then
        FASTBOOT="META-INF/fastboot"
        return 0
    fi
    if [ -x "META-INF/bin/fastboot" ]; then
        FASTBOOT="META-INF/bin/fastboot"
        return 0
    fi

    warn "Không tìm thấy fastboot, thử cài qua apt..."
    sudo apt-get update >/dev/null 2>&1
    if sudo apt-get install -y android-tools-fastboot >/dev/null 2>&1 ||
       sudo apt-get install -y fastboot >/dev/null 2>&1; then
        FASTBOOT="fastboot"
        return 0
    fi

    err "Không cài được fastboot. Hãy cài thủ công rồi chạy lại."
    read -r -p "Nhấn Enter để thoát... " _
    exit 1
}

ensure_zstd() {
    if command -v zstd >/dev/null 2>&1; then
        ZSTD="zstd"
        return 0
    fi
    if [ -x "META-INF/bin/zstd" ]; then
        ZSTD="META-INF/bin/zstd"
        return 0
    fi

    warn "Không tìm thấy zstd, thử cài qua apt..."
    sudo apt-get update >/dev/null 2>&1
    if sudo apt-get install -y zstd >/dev/null 2>&1; then
        ZSTD="zstd"
        return 0
    fi

    err "Không cài được zstd. Hãy cài thủ công rồi chạy lại."
    read -r -p "Nhấn Enter để thoát... " _
    exit 1
}

section "CLASSIC ROM INSTALLER  /  LINUX"
hr
say "[i] Đọc kỹ trước khi flash  /  Read before flashing"
say ""
say "  1. Cần bootloader ĐÃ MỞ KHÓA. Nếu chưa, đóng terminal này ngay."
say "  2. Chọn sai sẽ MẤT TOÀN BỘ DỮ LIỆU. Hãy chắc chắn."
say "  3. ROM MIỄN PHÍ. Nếu thấy ai bán / thu tiền cài, liên hệ Admin."
say "  4. Không chịu trách nhiệm nếu máy brick hoặc mất dữ liệu."
say "  5. Kiểm tra kỹ bản ROM phải đúng model thiết bị."
say ""
say "Đã đọc và đồng ý? Nhấn Enter để tiếp tục (đóng terminal nếu chưa)."
read -r -p "" _

section "CHỌN CHẾ ĐỘ FLASH  /  FLASH MODE"
say "  [Y] Xóa sạch dữ liệu  - Clean flash  (format userdata)"
say "  [N] Giữ lại dữ liệu   - Dirty flash  (keep data)"
read -r -p "  Nhập lựa chọn [Y/N]: " CHOICE
case "$CHOICE" in
    [yY]) CHOICE="y" ;;
    *)    CHOICE="n" ;;
esac
say "  -> Chế độ đã chọn: $CHOICE"

section "KIỂM TRA THIẾT BỊ  /  DEVICE CHECK"
say "Đưa thiết bị vào FASTBOOT MODE."
say "Nếu không nhận, cài driver rồi chạy lại."
hr

ensure_fastboot
ensure_zstd

if [ ! -f "META-INF/Data/DeviceCode" ]; then
    err "Thiếu file: META-INF/Data/DeviceCode"
    read -r -p "Nhấn Enter để thoát... " _
    exit 1
fi
DEVICE_ROM=$(tr -d '\r\n' < "META-INF/Data/DeviceCode")
if [ -z "$DEVICE_ROM" ]; then
    err "File DeviceCode rỗng. Hãy kiểm tra package ROM."
    read -r -p "Nhấn Enter để thoát... " _
    exit 1
fi

DEVICE_REAL=$($FASTBOOT getvar product 2>&1 | grep -i '^product:' | awk '{print $2}' | tr -d '\r\n')
SLOTS=$($FASTBOOT getvar slot-count 2>&1 | grep -i '^slot-count:' | awk '{print $2}' | tr -d '\r\n')

if [ "$SLOTS" = "2" ]; then
    FLASH_MODE="AB"
else
    FLASH_MODE="A"
fi
if [ "$DEVICE_REAL" = "mars" ]; then
    DEVICE_REAL="star"
fi

case "$DEVICE_REAL" in
    *"$DEVICE_ROM"*) ;;
    *)
        err "SAI MÃ THIẾT BỊ  /  DEVICE CODE MISMATCH"
        say "Thiết bị: $DEVICE_REAL   |   ROM này: $DEVICE_ROM"
        read -r -p "Nhấn Enter để thoát... " _
        exit 1
        ;;
esac

ok "Thiết bị : $DEVICE_REAL"
ok "ROM      : $DEVICE_ROM"
ok "Slot     : $FLASH_MODE"
ok "Chế độ   : $CHOICE"

section "TIẾN TRÌNH  /  PROGRESS"
TOTAL=0
for f in *.img.zst; do
    [ -e "$f" ] && TOTAL=$((TOTAL + 1))
done
if [ -d "images" ]; then
    for f in images/*; do
        [ -e "$f" ] || continue
        filename=$(basename "$f")
        par="${filename%.*}"
        case "$par" in
            cust) TOTAL=$((TOTAL + 1)) ;;
            preloader_raw) TOTAL=$((TOTAL + 4)) ;;
            vbmeta*)
                if [ "$FLASH_MODE" = "AB" ]; then TOTAL=$((TOTAL + 2)); else TOTAL=$((TOTAL + 1)); fi
                ;;
            *)
                if [ "$FLASH_MODE" = "AB" ]; then TOTAL=$((TOTAL + 2)); else TOTAL=$((TOTAL + 1)); fi
                ;;
        esac
    done
fi
[ -f "super.img" ] && TOTAL=$((TOTAL + 1))
[ "$CHOICE" = "y" ] && TOTAL=$((TOTAL + 3))
[ "$FLASH_MODE" = "AB" ] && TOTAL=$((TOTAL + 1))
TOTAL=$((TOTAL + 1))
DONE=0
progress "$DONE" "$TOTAL"

section "GIẢI NÉN IMAGE  /  EXTRACTING"
for f in *.img.zst; do
    [ -e "$f" ] || continue
    par="${f%.img.zst}"
    rm -f "${par}.img" 2>/dev/null
    say "- $par"
    "$ZSTD" -d "$f" -o "${par}.img"
    DONE=$((DONE + 1))
    progress "$DONE" "$TOTAL"
done

section "FLASH ROM"
if [ -d "images" ]; then
    for f in images/*; do
        [ -e "$f" ] || continue
        filename=$(basename "$f")
        par="${filename%.*}"

        if [ "$par" = "cust" ]; then
            $FASTBOOT flash "$par" "$f" >/dev/null 2>&1
            DONE=$((DONE + 1))
            progress "$DONE" "$TOTAL"
        elif [ "$par" = "preloader_raw" ]; then
            $FASTBOOT flash preloader_a "$f" >/dev/null 2>&1
            $FASTBOOT flash preloader_b "$f" >/dev/null 2>&1
            $FASTBOOT flash preloader1 "$f" >/dev/null 2>&1
            $FASTBOOT flash preloader2 "$f" >/dev/null 2>&1
            DONE=$((DONE + 4))
            progress "$DONE" "$TOTAL"
        elif [[ "$par" == vbmeta* ]]; then
            if [ "$FLASH_MODE" = "AB" ]; then
                $FASTBOOT --disable-verity --disable-verification flash "${par}_a" "$f"
                $FASTBOOT --disable-verity --disable-verification flash "${par}_b" "$f"
                DONE=$((DONE + 2))
            else
                $FASTBOOT --disable-verity --disable-verification flash "$par" "$f"
                DONE=$((DONE + 1))
            fi
            progress "$DONE" "$TOTAL"
        elif [ "$FLASH_MODE" = "AB" ]; then
            $FASTBOOT flash "${par}_a" "$f"
            $FASTBOOT flash "${par}_b" "$f"
            DONE=$((DONE + 2))
            progress "$DONE" "$TOTAL"
        else
            $FASTBOOT flash "$par" "$f"
            DONE=$((DONE + 1))
            progress "$DONE" "$TOTAL"
        fi
    done
fi

if [ -f "super.img" ]; then
    say "- super"
    $FASTBOOT flash super super.img
    rm -f super.img 2>/dev/null
    DONE=$((DONE + 1))
    progress "$DONE" "$TOTAL"
fi

if [ "$CHOICE" = "y" ]; then
    section "FORMAT DATA"
    $FASTBOOT erase frp >/dev/null 2>&1
    $FASTBOOT erase userdata >/dev/null 2>&1
    $FASTBOOT erase metadata >/dev/null 2>&1
    say "- frp / userdata / metadata  [ok]"
    DONE=$((DONE + 3))
    progress "$DONE" "$TOTAL"
fi

section "HOÀN TẤT  /  ALL DONE"
say "Thiết bị sẽ tự khởi động lại. Vui lòng đợi 10-15 phút."
if [ "$FLASH_MODE" = "AB" ]; then
    $FASTBOOT set_active a >/dev/null 2>&1
    DONE=$((DONE + 1))
    progress "$DONE" "$TOTAL"
fi
$FASTBOOT reboot
DONE=$((DONE + 1))
progress "$DONE" "$TOTAL"
hr
read -r -p "Nhấn Enter để thoát... " _
exit 0
