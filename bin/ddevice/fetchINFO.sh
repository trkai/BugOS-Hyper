work_dir=$(pwd)
source "$work_dir/functions.sh"

# os_type do build.sh ghi vào bin/ddevice/os_type.txt ("BugOS"). Script này chạy
# như TIẾN TRÌNH RIÊNG nên không thấy biến của build.sh - trước đây nó dùng
# $os_type (rỗng) rồi ghi đè chính file đó thành chuỗi rỗng, khiến packROM đặt
# tên file thành "out/_annibale_OS4...". Đọc lại từ file để giữ giá trị.
os_type=$(cat "$work_dir/bin/ddevice/os_type.txt" 2>/dev/null | tr -d '\r\n')
[ -z "$os_type" ] && os_type=$(cat "$work_dir/bin/ddevice/brand.txt" 2>/dev/null | tr -d '\r\n')
[ -z "$os_type" ] && os_type="BugOS"

regionTYPE=$(cat $work_dir/bin/ddevice/device_type.txt)
AndroidVer=$(< $work_dir/build/baserom/images/system/system/build.prop grep "ro.system.build.version.release" |awk 'NR==1' |cut -d '=' -f 2)
sdkLevel=$(< $work_dir/build/baserom/images/system/system/build.prop grep "ro.system.build.version.sdk" |awk 'NR==1' |cut -d '=' -f 2)
device_code=$(cat $work_dir/bin/ddevice/device_code.txt 2>/dev/null | tr -d '\r\n')
[ -z "$device_code" ] && device_code=$(cat $work_dir/bin/ddevice/device_f.txt 2>/dev/null | tr -d '\r\n')
[ -z "$device_code" ] && device_code="YourDevice"

name=$(cat $work_dir/bin/ddevice/device_name.txt 2>/dev/null | tr -d '\r\n')
[ -z "$name" ] && name=$(cat $work_dir/bin/ddevice/name_devices.txt 2>/dev/null | tr -d '\r\n')
[ -z "$name" ] && name="Xiaomi Device"
base_rom_code=$(cat $work_dir/bin/ddevice/base_rom_code.txt)
rom_os=$(cat $work_dir/bin/ddevice/rom_os.txt)
build_tool=$(cat "$work_dir/Version" 2>/dev/null | tr -d '\r\n')
systemtype=$(cat $work_dir/bin/ddevice/fstype.txt)

if grep -q "ro.build.ab_update=true" build/baserom/images/vendor/build.prop; then
echo "VAB" > $work_dir/bin/script2flash/META-INF/Data/Structure
else
echo "Non-VAB" > $work_dir/bin/script2flash/META-INF/Data/Structure
fi

# Chip: quyết định zip có flash được bằng recovery hay không (update-binary chặn
# MediaTek). Bản cũ chỉ dò init.qcom.rc - thiếu file đó là ghi "Mediatek" và
# update-binary từ chối cài trên máy Snapdragon.
#
# Giờ ưu tiên build.prop, vì ro.board.platform / ro.hardware là thứ ROM luôn có.
# Xiaomi chỉ dùng 2 nền: qcom (Snapdragon) và mtk (MediaTek), nên chỉ cần tìm
# dấu hiệu mtk; không thấy thì là Snapdragon. Kernel MTK luôn để lại "mtk" trong
# ro.board.platform / ro.hardware.
vendor_prop="$work_dir/build/baserom/images/vendor/build.prop"
board=$(grep -m1 -E '^(ro\.board\.platform|ro\.hardware)=' "$vendor_prop" 2>/dev/null | cut -d= -f2 | tr -d '\r\n ')
board_lc=$(printf '%s' "$board" | tr 'A-Z' 'a-z')

if [ -z "$board_lc" ]; then
    # build.prop không đọc được: quay lại cách cũ
    if [ -f $work_dir/build/baserom/images/vendor/etc/init/hw/init.qcom.rc ]; then
        board_lc="qcom"
    else
        board_lc="mtk"
    fi
fi

case "$board_lc" in
    *mtk*|*mediatek*) echo "Mediatek"   > $work_dir/bin/script2flash/META-INF/Data/Chip ;;
    *)                echo "Snapdragon" > $work_dir/bin/script2flash/META-INF/Data/Chip ;;
esac

echo "$os_type" > $work_dir/bin/ddevice/os_type.txt
echo "$AndroidVer" > $work_dir/bin/ddevice/androidver.txt
echo "$sdkLevel" > $work_dir/bin/ddevice/sdkLevel.txt
#Parse Data
echo "$AndroidVer" > $work_dir/bin/script2flash/META-INF/Data/AndroidVer
echo "$base_rom_code" > $work_dir/bin/script2flash/META-INF/Data/RomBased
echo "$build_tool" > $work_dir/bin/script2flash/META-INF/Data/Version
echo "$regionTYPE" > $work_dir/bin/script2flash/META-INF/Data/Region
echo "$name" > $work_dir/bin/script2flash/META-INF/Data/DeviceName
echo "$systemtype" > $work_dir/bin/script2flash/META-INF/Data/Types


# Gọn thành 2 dòng thay vì khung 10 dòng: thông tin này còn xuất hiện trong
# notify.py và tên file ROM, nên không cần chiếm chỗ trong log build.
info "ROM: $name ($device_code) | $rom_os $base_rom_code | Android $AndroidVer | $regionTYPE | $systemtype"
info "Tool: ${build_tool:-BugOS} | OS type: $os_type | Chip: $(cat $work_dir/bin/script2flash/META-INF/Data/Chip)"

# Chi tiết đầy đủ chỉ khi cần gỡ lỗi.
if [ "${DEBUG:-0}" = "1" ]; then
    echo "------------------ BugOS BuildInfo ---------------------"
    echo "- Device Name: $name"
    echo "- Codename: $device_code"
    echo "- Xiaomi Version: $rom_os"
    echo "- BuildRegion: $regionTYPE"
    echo "- Android: $AndroidVer"
    echo "- Base ROM Code: $base_rom_code"
    echo "- BuildTool: $build_tool"
    echo "- OS Type: $systemtype"
    echo "--------------------------------------------------------"
fi
