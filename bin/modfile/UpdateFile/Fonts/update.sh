work_dir=$(pwd)
source "$work_dir/functions.sh"

# Define ROM infomation
rom_os=$(cat "$work_dir/bin/ddevice/rom_os.txt" 2>/dev/null | tr -d '\r\n ')
deviceTYPE=$(cat "$work_dir/bin/ddevice/device_type.txt" 2>/dev/null | tr -d '\r\n ')
MAIN_FOLDER="$work_dir/build/baserom/images"

# ---------------------------------------------------------------------------
# Font mod - CHỈ cho OS4 (HyperOS 4 / Android 17).
#
# Trước đây file này có 6 nhánh cho OS1 (A13, A14), OS2 (A14, A15) và
# OS3/OS4 (regex ^OS[3-9]). Các nhánh OS1/OS2/OS3 đã bị xoá cùng target
# android13/14/15/16 tương ứng, nên giữ lại chỉ tạo cảm giác "hỗ trợ" mà
# thực tế không có target để build.
#
# Chỉ áp cho ROM China: bản Global đã có sẵn font Noto/Roboto đầy đủ, chép
# đè MiSans lên sẽ làm sai metric của tiếng bản địa.
# ---------------------------------------------------------------------------

if [[ $deviceTYPE != "China" ]]; then
    debug "Fonts: ROM Global - không chép MiSans (đã có Noto/Roboto)"
    exit 0
fi

if [[ $rom_os != "OS4" ]]; then
    debug "Fonts: chỉ hỗ trợ OS4 (ROM này là '${rom_os:-?}') - bỏ qua"
    exit 0
fi

mods "Fonts: HyperOS 4 - thay bộ MiSans"

FONT_SRC="$work_dir/bin/modfile/UpdateFile/Fonts/HyperOS"
DEST_SYSTEM="$MAIN_FOLDER/system/system/fonts"

# Xoá font MiSans gốc trước khi chép bộ mới: nếu để lại, hệ thống có thể vẫn
# resolve theo tên cũ và bản mod không có tác dụng.
rm -f "$DEST_SYSTEM/MiSansLatinVF.ttf" \
      "$DEST_SYSTEM/MiSansVF.ttf" \
      "$DEST_SYSTEM/MiSansVF_Overlay.ttf"

cp -rf "$FONT_SRC"/*.ttf "$DEST_SYSTEM/"