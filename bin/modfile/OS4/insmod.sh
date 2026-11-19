work_dir=$(pwd)
source $work_dir/functions.sh
rom_os=$(cat $work_dir/bin/ddevice/rom_os.txt 2>/dev/null | tr -d '\r\n ')

if [[ $rom_os != "OS4" ]]; then
    exit 0
fi

TARGET_DIR="$work_dir/bin/modfile/OS4"
noexecute=( "insmod" )

# Đếm mod thật (bỏ chính dispatcher). Hiện thư mục này RỖNG sau khi xoá
# Launcher_RustMod, nên nếu không có guard thì mỗi lần build in ra
# "Starting Apply OS4 Custom Mods File..." mà chẳng làm gì - dễ tưởng nhầm là
# mod vẫn chạy.
MOD_COUNT=$(find "$TARGET_DIR" -type f -name "*.sh" | grep -v "/insmod\.sh$" | wc -l | tr -d ' ')
if [ "$MOD_COUNT" -eq 0 ]; then
    exit 0
fi

mods "Starting Apply OS4 Custom Mods File..."

# sort: `find` không đảm bảo thứ tự giữa các lần build hay giữa các máy. Mod nào
# phụ thuộc thứ tự sẽ chạy sai lệch ngẫu nhiên nếu không sắp.
find "$TARGET_DIR" -type f -name "*.sh" | sort | while read -r script; do
    base="$(basename "$script" .sh)"

    skip=false
    for ex in "${noexecute[@]}"; do
        if [[ "$base" == "$ex" ]]; then
            skip=true
            break
        fi
    done

    if [[ $skip == false ]]; then
        bash "$script"
    fi
done
