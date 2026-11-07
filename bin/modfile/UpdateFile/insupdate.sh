work_dir=$(pwd)
source $work_dir/functions.sh

mods "Starting Update File..."
TARGET_DIR="$work_dir/bin/modfile/UpdateFile"
noexecute=( "insupdate" )

# sort: `find` trả thứ tự do filesystem quyết định, không đảm bảo giống nhau
# giữa các lần build hay giữa các máy. Mod nào phụ thuộc thứ tự (ví dụ mod sau
# sửa file mà mod trước vừa chép) sẽ chạy sai lệch một cách ngẫu nhiên. Sắp theo
# đường dẫn đầy đủ để thứ tự tất định: cùng một cây file = cùng một thứ tự.
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
