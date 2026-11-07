work_dir=$(pwd)
source $work_dir/functions.sh
rom_os=$(cat $work_dir/bin/ddevice/rom_os.txt)

if [[ $rom_os == "OS3" ]]; then
mods "Starting Apply OS3 Custom Mods File..."
TARGET_DIR="$work_dir/bin/modfile/OS3"
noexecute=( "insmod" )

# sort: `find` không đảm bảo thứ tự giữa các lần build hay giữa các máy. OS3 hiện
# chỉ có một mod nên chưa lộ, nhưng thêm mod thứ hai là thứ tự thành ngẫu nhiên.
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
fi