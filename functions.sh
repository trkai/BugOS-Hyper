#!/bin/bash
# ---------------------------------------------------------------------------
# functions.sh - hàm dùng chung cho mọi script build.
#
# LOG: KHÔNG tự định nghĩa nữa. Toàn bộ mods/info/warn/error/patch/unpack/
# repack/upload/exists nằm ở lib/log.sh - một chỗ duy nhất, có timestamp, màu
# và mức DEBUG. Trước đây file này định nghĩa lại 10 hàm giống hệt, nên log
# build và log của bin/rom/ có hai định dạng khác nhau.
#
# Tên hàm giữ nguyên nên 33 script đang gọi `source functions.sh` không phải sửa.
# ---------------------------------------------------------------------------
WORK_DIR=$(pwd)

# shellcheck source=lib/log.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/log.sh"

# Giữ tên cũ cho script nào còn gọi yellow (2 chỗ trong file này + bên ngoài).
yellow() { printf '%s%s%s\n' "$_C_YEL" "$*" "$_C_RST"; }

abort() {
    yellow "--> Missing $1 ! installing..."
    apt install $1 -y
}

check() {
    for b in "$@"; do
        exists "$b" || abort "$b"
    done
}

# Check for a prop's existence
is_property_exists () {
    if [ $(grep -c "$1" "$2") -ne 0 ] ; then
        return 0
    else
        return 1
    fi
}

disable_avb_verify() {
    fstab_files=$(find "$1" -type f -name "*fstab*")
    info "Disabling avb_verify in files: $fstab_files"
    if [[ -z "$fstab_files" ]]; then
        warn "No fstab files found in $1"
        return
    fi
    for fstab in $fstab_files; do
        if [[ -f $fstab ]]; then
            info "Processing $fstab"
		    sed -i "s/,avb_keys=.*avbpubkey//g" $fstab
            sed -i "s/,avb=vbmeta_system//g" $fstab
		    sed -i "s/,avb=vbmeta_vendor//g" $fstab
            sed -i "s/,avb=vbmeta//g" $fstab
            sed -i "s/,avb//g" $fstab
            sed -i 's/,avb.*system//g' $fstab
            sed -i 's/,avb,/,/g' $fstab
            sed -i 's/,avb=.*a,/,/g' $fstab
            sed -i 's/,avb_keys.*key//g' $fstab
        else
            warn "$fstab not found, please check it manually"
        fi
    done
}

remove_data_encrypt() {
    fstab_files=$(find "$1" -type f -name "*fstab*")
    info "Disabling data enc in files: $fstab_files"
    if [[ -z "$fstab_files" ]]; then
        yellow "No fstab files found in $1"
        return
    fi
    for fstab in $fstab_files; do
        if [[ -f $fstab ]]; then
            sed -i "s/,fileencryption=aes-256-xts:aes-256-cts:v2+inlinecrypt_optimized+wrappedkey_v0//g" $fstab
            sed -i "s/,fileencryption=aes-256-xts:aes-256-cts:v2+emmc_optimized+wrappedkey_v0//g" $fstab
            sed -i "s/,fileencryption=aes-256-xts:aes-256-cts:v2//g" $fstab
            sed -i "s/,metadata_encryption=aes-256-xts:wrappedkey_v0//g" $fstab
            sed -i "s/,fileencryption=aes-256-xts:wrappedkey_v0//g" $fstab
            sed -i "s/,metadata_encryption=aes-256-xts//g" $fstab
            sed -i "s/,fileencryption=aes-256-xts//g" $fstab
            sed -i "s/fileencryption/encryptable/g" $fstab
            sed -i "s/,fileencryption=ice//g" $fstab
        else
            yellow "$fstab not found, please check it manually"
        fi
    done
}

extract_partition() {
    part_img=$1
    part_name=$(basename ${part_img})
    target_dir=$2
    if [[ -f ${part_img} ]]; then 
        if [[ $(${WORK_DIR}/bin/Linux/x86_64/gettype -i ${part_img}) == "ext" ]]; then
            pack_type="EXT"
            echo $pack_type > ${WORK_DIR}/bin/ddevice/fstype.txt
            sudo python3 ${WORK_DIR}/bin/imgextractor/imgextractor.py ${part_img} ${target_dir} >/dev/null 2>&1 || { error "Extracting ${part_name} failed."; exit 1; }
            unpack "File ${part_name} extracted."
            rm -rf ${part_img}      
        elif [[ $(${WORK_DIR}/bin/Linux/x86_64/gettype -i ${part_img}) == "erofs" ]]; then
            pack_type="EROFS"
            echo $pack_type > ${WORK_DIR}/bin/ddevice/fstype.txt
            extract.erofs -x -i ${part_img} -o ${target_dir} > /dev/null 2>&1 || { error "Extracting ${part_name} failed." ; exit 1; }
            unpack "File ${part_name} extracted."
            rm -rf ${part_img}
        else
            error "Unable to handle img, exit."
            exit 1
        fi
    fi    
}

setprop_rc() {
    local target_section="$1"    # e.g., "on boot"
    local insert_value="$2"      # e.g., "setprop com.exx.c true"
    local file="$3"              # e.g., "a.rc"

    if [[ ! -f "$file" ]]; then
        echo "Error: file '$file' not found"
        return 1
    fi

    local temp_file="${file}.tmp"
    local matched=0

    > "$temp_file"

    while IFS= read -r line; do
        echo "$line" >> "$temp_file"

        if [[ "$matched" -eq 0 && "$line" == "$target_section" ]]; then
            matched=1
            while IFS= read -r next_line; do
                if [[ "$next_line" =~ ^[[:space:]] ]]; then
                    echo "$next_line" >> "$temp_file"
                else
                    # Insert your new value and break
                    while IFS= read -r value_line; do
                        [[ -n "$value_line" ]] && echo "    $value_line" >> "$temp_file"
                    done <<< "$insert_value"
                    echo "$next_line" >> "$temp_file"
                    break
                fi
            done
        fi
    done < "$file"

    mv "$temp_file" "$file"
}

change_prop() {
    local key="$1"
    local new_value="$2"
    local base_dir="$work_dir/build/baserom/images"

    if [[ -z "$key" || -z "$new_value" ]]; then
        info "change_prop: cần <property_key> <new_value>"
        return 1
    fi

    if [[ ! -d "$base_dir" ]]; then
        error "change_prop: không thấy thư mục '$base_dir'"
        return 1
    fi

    new_value=$(echo "$new_value" | tr -d '\r\n')
    local escaped_value
    escaped_value=$(printf '%s\n' "$new_value" | sed 's/[\/&#]/\\&/g')

    local found_file=""
    while IFS= read -r -d '' file; do
        if grep -q -E "^$key=" "$file"; then
            sed -i -E "s#^($key)=.*#\1=$escaped_value#" "$file"
            debug "change_prop: đặt $key=$new_value"
            return 0
        fi
    done < <(find "$base_dir" -type f -name "build.prop" -print0)

    # If key not found in any file, append to the first build.prop
    local first_file
    first_file=$(find "$base_dir" -type f -name "build.prop" | head -n1)

    if [[ -n "$first_file" ]]; then
        echo "$key=$new_value" >> "$first_file"
        info "change_prop: thêm mới $key=$new_value vào $(basename "$(dirname "$first_file")")/build.prop"
        return 0
    else
        warn "change_prop: không có build.prop nào để ghi"
        return 1
    fi
}


mvsml() {
    local file_name="$1"
    local target_folder="$2"
    local framework_dir="$3"

    file_path=$(find "$framework_dir" -type f -name "$file_name")

    if [ -z "$file_path" ]; then
        warn "mvsml: không thấy $file_name trong $framework_dir"
        return 1
    fi

    parent_dex_folder=$(dirname "$file_path" | sed "s|$framework_dir/||" | cut -d/ -f1)
    relative_path=$(echo "$file_path" | sed "s|$framework_dir/$parent_dex_folder/||")

    target_path="$target_folder/$relative_path"

    mkdir -p "$(dirname "$target_path")"

    mv "$file_path" "$target_path"

    debug "mvsml: $file_name -> $target_path"
}

mvdir() {
    local folder_name="$1"
    local target_folder="$2"
    local framework_dir="$3"

    folder_path=$(find "$framework_dir" -type d -name "$folder_name")

    if [ -z "$folder_path" ]; then
        warn "mvdir: không thấy thư mục $folder_name trong $framework_dir"
        return 1
    fi

    find "$folder_path" -type f -name "*.smali" | while read -r file_path; do
        parent_dex_folder=$(dirname "$file_path" | sed "s|$framework_dir/||" | cut -d/ -f1)
        relative_path=$(echo "$file_path" | sed "s|$framework_dir/$parent_dex_folder/||")

        target_path="$target_folder/$relative_path"

        mkdir -p "$(dirname "$target_path")"

        mv "$file_path" "$target_path"
    done

    debug "mvdir: $folder_name -> $target_folder"
}

# ---------------------------------------------------------------------------
# dispatch_mods <dir> <tên-dispatcher> <nhãn-log>
#
# Chạy mọi mod (*.sh) trong <dir> theo thứ tự TẤT ĐỊNH, bỏ qua chính dispatcher.
#
# Trước đây ba dispatcher (OS4/insmod.sh, Universal/insfile.sh,
# UpdateFile/insupdate.sh) chép nguyên một vòng find|sort|skip giống hệt nhau -
# sửa logic phải sửa ba chỗ và dễ lệch. Giờ chỉ còn một chỗ.
#
# Thứ tự: sort theo đường dẫn đầy đủ. `find` một mình trả thứ tự do filesystem
# quyết định, nên cùng một cây file có thể chạy khác thứ tự giữa các lần build -
# mod nào phụ thuộc thứ tự sẽ hỏng ngẫu nhiên, rất khó lần.
#
# Mod lỗi KHÔNG dừng build (giữ hành vi cũ), nhưng có cảnh báo tổng ở cuối để
# không "chết im lặng".
# ---------------------------------------------------------------------------
dispatch_mods() {
    local dir=$1 me=$2 label=$3
    local script base failed=0 ran=0 total

    [ -d "$dir" ] || { warn "không có thư mục $dir - bỏ qua"; return 0; }

    # Đếm trước để in nhãn MỘT lần, trước khi chạy (nhãn in sau khi chạy thì log
    # đọc rất khó hiểu), và để thư mục rỗng không in gì.
    total=$(find "$dir" -type f -name "*.sh" | grep -v "/${me}\.sh$" | wc -l | tr -d ' ')
    if [ "$total" -eq 0 ]; then
        debug "không có mod nào trong $dir"
        return 0
    fi

    mods "$label ($total mod)"

    while IFS= read -r script; do
        [ -n "$script" ] || continue
        base=$(basename "$script" .sh)
        [ "$base" = "$me" ] && continue
        ran=$((ran + 1))
        # Báo đường dẫn TƯƠNG ĐỐI, không phải basename: nhiều mod cùng tên
        # "update.sh" nằm ở các thư mục khác nhau, basename sẽ báo nhập nhằng.
        if ! bash "$script"; then
            warn "mod '${script#"$dir"/}' kết thúc với lỗi (vẫn chạy tiếp)"
            failed=$((failed + 1))
        fi
    done < <(find "$dir" -type f -name "*.sh" | sort)

    [ "$failed" -gt 0 ] && warn "$failed/$ran mod thất bại trong $dir"
    return 0
}
