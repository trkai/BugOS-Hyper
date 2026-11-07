work_dir=$(pwd)
source $work_dir/functions.sh

mods "Starting Apply Universal File..."
TARGET_DIR="$work_dir/bin/modfile/Universal"
noexecute=( "insfile" )

# sort: `find` trả thứ tự do filesystem quyết định, không đảm bảo giống nhau
# giữa các lần build hay giữa các máy. Sắp theo đường dẫn đầy đủ để thứ tự tất
# định: cùng một cây file = cùng một thứ tự.
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
