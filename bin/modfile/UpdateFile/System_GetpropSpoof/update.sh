#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
#
# Giả trạng thái bootloader cho các app gọi `getprop` bằng tiến trình con.
#
# VÌ SAO CẦN, KHI ĐÃ CÓ PATCH SystemProperties:
#   Đã kiểm chứng trên máy (annibale, bản build có boot_state_spoof):
#     - app Java đọc được green / locked
#     - Settings > Trạng thái Mở khóa Mi hiện "Thiết bị này đã khóa"
#     - getprop (native) vẫn orange
#     - VNeID VẪN báo CA-E006
#   Tức là patch Java chạy đúng, nhưng VNeID không đi qua lớp Java. Trong
#   classes.dex của VNeID có chuỗi "/system/bin/getprop", và không .so nào của nó
#   import __system_property_* -> nó đọc prop bằng cách chạy getprop như tiến
#   trình con. Tiến trình con đó đọc kho prop thật, nên hook Java không chạm tới.
#   Đây cũng là lý do `resetprop` (đổi thẳng kho prop) làm VNeID qua được, còn
#   patch framework thì không.
#
# CÁCH LÀM:
#   /system/bin/getprop vốn là symlink -> toolbox. Thay bằng script:
#     - app (uid >= 10000) hỏi 6 prop trạng thái boot -> trả giá trị giả
#     - app gọi getprop không tham số (dump toàn bộ) -> lọc lại 6 dòng đó
#     - mọi trường hợp khác (kể cả shell/root/init) -> chuyển tiếp nguyên vẹn
#       cho /system/bin/toolbox getprop
#   Nhờ vậy chỉ app bị ảnh hưởng; shell, init và script hệ thống vẫn thấy giá
#   trị thật, nên debug và các bước boot không bị lệch.
#
# Bật/tắt bằng getprop_spoof trong config.env (mặc định bật).

work_dir=$(pwd)
source "$work_dir/functions.sh"

ENABLE=$(grep -m1 '^getprop_spoof=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$ENABLE" = "false" ]; then
    mods "GetpropSpoof: bỏ qua (getprop_spoof=false)"
    exit 0
fi

BIN_DIR="$work_dir/build/baserom/images/system/system/bin"
GP="$BIN_DIR/getprop"

if [ ! -e "$GP" ] && [ ! -L "$GP" ]; then
    warn "GetpropSpoof: không thấy $GP - bỏ qua"
    exit 0
fi

# toolbox là bản thật sự có applet getprop trên ROM này.
# toybox KHÔNG có getprop ("Unknown command getprop") - đã kiểm tra trên máy.
if [ ! -x "$BIN_DIR/toolbox" ]; then
    warn "GetpropSpoof: không thấy $BIN_DIR/toolbox - bỏ qua"
    exit 0
fi

# Đã vá rồi thì thôi (script này chạy lại được nhiều lần)
if [ -f "$GP" ] && [ ! -L "$GP" ] && head -n 2 "$GP" 2>/dev/null | grep -q "BugOS getprop wrapper"; then
    mods "GetpropSpoof: đã vá trước đó"
    exit 0
fi

# QUAN TRỌNG: phải rm symlink trước khi ghi. Nếu chỉ `cat > getprop` thì shell đi
# theo symlink và ghi đè thẳng vào toolbox (153 KB nhị phân) -> hỏng cả toolbox.
rm -f "$GP"

cat > "$GP" << 'GPEOF'
#!/system/bin/sh
# BugOS getprop wrapper - xem bin/modfile/UpdateFile/System_GetpropSpoof/update.sh
u=$(/system/bin/id -u 2>/dev/null)
if [ -n "$u" ] && [ "$u" -ge 10000 ]; then
    if [ $# -eq 1 ]; then
        case "$1" in
            ro.boot.verifiedbootstate)       echo green  ; exit 0 ;;
            ro.boot.vbmeta.device_state)     echo locked ; exit 0 ;;
            ro.secureboot.lockstate)         echo locked ; exit 0 ;;
            vendor.boot.verifiedbootstate)   echo green  ; exit 0 ;;
            vendor.boot.vbmeta.device_state) echo locked ; exit 0 ;;
            ro.boot.flash.locked)            echo 1      ; exit 0 ;;
        esac
    elif [ $# -eq 0 ]; then
        /system/bin/toolbox getprop | /system/bin/sed \
            -e 's|^\[ro\.boot\.verifiedbootstate\]:.*|[ro.boot.verifiedbootstate]: [green]|' \
            -e 's|^\[ro\.boot\.vbmeta\.device_state\]:.*|[ro.boot.vbmeta.device_state]: [locked]|' \
            -e 's|^\[ro\.secureboot\.lockstate\]:.*|[ro.secureboot.lockstate]: [locked]|' \
            -e 's|^\[vendor\.boot\.verifiedbootstate\]:.*|[vendor.boot.verifiedbootstate]: [green]|' \
            -e 's|^\[vendor\.boot\.vbmeta\.device_state\]:.*|[vendor.boot.vbmeta.device_state]: [locked]|' \
            -e 's|^\[ro\.boot\.flash\.locked\]:.*|[ro.boot.flash.locked]: [1]|'
        exit 0
    fi
fi
exec /system/bin/toolbox getprop "$@"
GPEOF

chmod 755 "$GP"

if [ -f "$GP" ] && [ ! -L "$GP" ] && grep -q "toolbox getprop" "$GP"; then
    mods "GetpropSpoof: /system/bin/getprop -> wrapper (app thấy green/locked, shell thấy thật)"
else
    warn "GetpropSpoof: ghi $GP không như mong đợi"
fi
