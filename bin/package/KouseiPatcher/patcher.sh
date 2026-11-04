#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
# ---------------------------------------------------------------------------
# Kaorios Fake Lock patcher (framework.jar + services.jar)
#
# Sửa so với bản gốc:
#   1. `work_dir` chưa từng được khai báo -> mvsml()/mvdir() tìm trong
#      "/jar_temp/..." nên việc di chuyển 5 class smali KHÔNG BAO GIỜ chạy.
#      Đã gán work_dir="$dir".
#   2. Backup jar gốc trước khi vá, tự khôi phục nếu build lại thất bại.
#   3. Kiểm tra exit code của toolbox.py -> không ghi đè jar khi patch trượt.
#   4. Kiểm tra số dex sau khi assemble -> không ghi đè jar thiếu dex.
#   5. Bỏ chặn log của mvsml() để lỗi hiện ra thay vì im lặng.
# ---------------------------------------------------------------------------

dir=$(pwd)
work_dir="$dir"
source "$dir/functions.sh"
sdkLevel=$(cat $dir/bin/ddevice/sdkLevel.txt 2>/dev/null | tr -d '\r\n ')
patch="python3 $dir/bin/package/KouseiPatcher/toolbox.py"
JARDIR="$dir/jar_temp"
JAR_BACKUP="$JARDIR/backup"

mkdir -p "$JARDIR" "$JAR_BACKUP"

backup_jar() {
    [ -f "$1" ] || return 0
    cp -f "$1" "$JAR_BACKUP/$(basename "$1").orig"
}

restore_jar() {
    local o="$JAR_BACKUP/$(basename "$1").orig"
    if [ -f "$o" ]; then
        cp -f "$o" "$1"
        echo "Đã khôi phục $(basename "$1") từ backup"
    fi
}

get_file_dir() {
	[ -n "$1" ] || return 0
	local p
	# head -n1: tránh trả về nhiều dòng khi có bản trùng trong nhiều partition
	p=$(find "$dir/build/baserom/images/" -name "$1" 2>/dev/null | head -n1)
	# fallback sudo cho trường hợp file thuộc root (CI chạy sudo)
	[ -z "$p" ] && p=$(sudo -n find "$dir/build/baserom/images/" -name "$1" 2>/dev/null | head -n1)
	printf '%s' "$p"
}

jar_util()
{
    cd "$dir" || return 1
    #binary
    if [[ $3 == "fw" ]]; then
        bak="java -jar $dir/bin/apktool/baksmaliv2.jar d --api $sdkLevel"
        sma="java -jar $dir/bin/apktool/smaliv2.jar a --api $sdkLevel"
    fi

    if [[ $1 == "d" ]]; then
        echo -ne "====> Patching $2 : "

        file_path=$(get_file_dir $2)
        if [[ -z "$file_path" ]]; then
            echo "Fail (không tìm thấy $2)"
            return 1
        fi
        backup_jar "$file_path"
        sudo cp "$file_path" $dir/jar_temp
        sudo chown $(whoami) $dir/jar_temp/$2
        unzip $dir/jar_temp/$2 -d $dir/jar_temp/$2.out  >/dev/null 2>&1
        if [[ ! -d $dir/jar_temp/"$2.out" ]]; then
            echo "Fail (không giải nén được $2)"
            return 1
        fi
        rm -rf $dir/jar_temp/$2
        for dex in $(find $dir/jar_temp/"$2.out" -maxdepth 1 -name "*dex" ); do
            if [[ $4 ]]; then
                if [[ ! "$dex" == *"$4"* ]]; then
                    $bak $dex -o "$dex.out" || { echo "Fail (baksmali $dex)"; return 1; }
                    [[ -d "$dex.out" ]] && rm -rf $dex
                fi
            else
                $bak $dex -o "$dex.out" || { echo "Fail (baksmali $dex)"; return 1; }
                [[ -d "$dex.out" ]] && rm -rf $dex
            fi
        done
        return 0
    fi

    if [[ $1 == "a" ]]; then
        if [[ ! -d $dir/jar_temp/$2.out ]]; then
            echo "Fail (không có thư mục $2.out)"
            return 1
        fi
        cd $dir/jar_temp/$2.out || return 1

        # Danh sách dex cần có sau khi assemble (chụp TRƯỚC khi loop xoá .out)
        local expected=""
        for fld in $(find . -maxdepth 1 -type d -name "*.out" ); do
            expected="$expected ${fld%.out}"
        done

        for fld in $(find . -maxdepth 1 -type d -name "*.out" ); do
            if [[ $4 ]]; then
                if [[ ! "$fld" == *"$4"* ]]; then
                    $sma $fld -o $(echo ${fld//.out}) || { cd "$dir"; echo "Fail (smali $fld)"; return 1; }
                    [[ -f $(echo ${fld//.out}) ]] && rm -rf $fld
                fi
            else
                $sma $fld -o $(echo ${fld//.out}) || { cd "$dir"; echo "Fail (smali $fld)"; return 1; }
                [[ -f $(echo ${fld//.out}) ]] && rm -rf $fld
            fi
        done

        # Không được thiếu dex nào
        local miss=""
        for d in $expected; do
            [ -f "$d" ] || miss="$miss $d"
        done
        if [ -n "$miss" ]; then
            cd "$dir"
            echo "Fail (thiếu dex:$miss)"
            return 1
        fi

        cd "$dir" || return 1
        7za a -tzip -mx=0 $dir/jar_temp/$2_notal $dir/jar_temp/$2.out/. >/dev/null 2>&1
        zipalign 4 $dir/jar_temp/$2_notal $dir/jar_temp/$2
        if [[ -f $dir/jar_temp/$2 ]] && unzip -t $dir/jar_temp/$2 >/dev/null 2>&1; then
            sudo cp -rf $dir/jar_temp/$2 $(get_file_dir $2)
            echo "Success"
            rm -rf $dir/jar_temp/$2.out $dir/jar_temp/$2_notal
            return 0
        fi
        echo "Fail (jar tạo ra không hợp lệ)"
        return 1
    fi
}

mvsml() {
    local file_name="$1"
    local target_folder="$2"
    local framework_dir="$work_dir/jar_temp/framework.jar.out"

    # Search for the smali file within the framework directory
    file_path=$(find "$framework_dir" -type f -name "$file_name")

    if [ -z "$file_path" ]; then
        echo "Cảnh báo: không thấy $file_name trong $framework_dir"
        return 1
    fi

    # Extract the parent dex folder and the relative path from it
    parent_dex_folder=$(dirname "$file_path" | sed "s|$framework_dir/||" | cut -d/ -f1)
    relative_path=$(echo "$file_path" | sed "s|$framework_dir/$parent_dex_folder/||")

    # Construct the new target path, preserving subdirectories
    target_path="$target_folder/$relative_path"

    # Ensure the target directory exists
    mkdir -p "$(dirname "$target_path")"

    # Move the file
    mv "$file_path" "$target_path"

    echo "Moved $file_name to $target_path"
}

mvdir() {
    local folder_name="$1"
    local target_folder="$2"
    local framework_dir="$work_dir/jar_temp/framework.jar.out"

    # Search for the folder within the framework directory
    folder_path=$(find "$framework_dir" -type d -name "$folder_name")

    if [ -z "$folder_path" ]; then
        echo "Folder $folder_name not found in any dex folder within $framework_dir."
        return 1
    fi

    # Loop through all .smali files in the found folder
    find "$folder_path" -type f -name "*.smali" | while read -r file_path; do
        # Extract the relative path from the framework_dir
        parent_dex_folder=$(dirname "$file_path" | sed "s|$framework_dir/||" | cut -d/ -f1)
        relative_path=$(echo "$file_path" | sed "s|$framework_dir/$parent_dex_folder/||")

        # Construct the new target path, preserving subdirectories
        target_path="$target_folder/$relative_path"

        # Ensure the target directory exists
        mkdir -p "$(dirname "$target_path")"

        # Move the file
        mv "$file_path" "$target_path"
    done

    echo "Moved all .smali files from $folder_name to $target_folder"
}

Patch_Framework () {

    if ! jar_util d 'framework.jar' fw 0 10; then
        patch "Fail: không decompile được framework.jar - giữ nguyên jar gốc"
        return 1
    fi

    FRAMEWORK_DIR="$dir/jar_temp/framework.jar.out"

    if ! $patch "$FRAMEWORK_DIR"; then
        patch "Fail: toolbox.py không vá được framework.jar (anchor không khớp?) - giữ nguyên jar gốc"
        rm -rf "$FRAMEWORK_DIR"
        return 1
    fi

    max_dex=$(find "$FRAMEWORK_DIR" -maxdepth 1 -name "classes*.dex.out" | sed 's/.*classes\([0-9]*\)\.dex\.out/\1/' | sort -rn | head -1)
    [ -z "$max_dex" ] && max_dex=1
    new_dex=$((max_dex + 1))
    new_dex_folder="$FRAMEWORK_DIR/classes$new_dex.dex.out"
    mkdir -p "$new_dex_folder"
    mvsml "AndroidKeyStoreSpi.smali" "$new_dex_folder"
    mvsml "Instrumentation.smali" "$new_dex_folder"
    mvsml "AndroidKeyStoreKeyPairGeneratorSpi.smali" "$new_dex_folder"
    mvsml "ApplicationPackageManager.smali" "$new_dex_folder"
    mvsml "Settings\$NameValueCache.smali" "$new_dex_folder"
    cp -rf $dir/bin/package/KouseiPatcher/smali/* $new_dex_folder

    if ! jar_util a 'framework.jar' fw 0 10; then
        patch "Fail: không build lại được framework.jar - khôi phục bản gốc"
        return 1
    fi
    return 0
}

Patch_services () {

    if ! jar_util d 'services.jar' fw 0 10; then
        patch "Fail: không decompile được services.jar - giữ nguyên jar gốc"
        return 1
    fi

    if ! $patch $dir/jar_temp/services.jar.out --services; then
        patch "Fail: toolbox.py không vá được services.jar - giữ nguyên jar gốc"
        rm -rf "$dir/jar_temp/services.jar.out"
        return 1
    fi

    if ! jar_util a 'services.jar' fw 0 10; then
        patch "Fail: không build lại được services.jar - khôi phục bản gốc"
        return 1
    fi
    return 0
}

FAILED=0
Patch_Framework || { FAILED=1; restore_jar "$(get_file_dir framework.jar)"; }

# kaorios_services_hook=false: bỏ vá services.jar (hook SystemServer).
#
# VÌ SAO CÓ CỜ NÀY:
#   Bản OS4 từng pass VNeID dùng code KouseiPatcher tháng 4. Ở bản đó toolbox.py
#   có lỗi `patches.append(SERVICES_PATCH)` -> áp cả 5 patch framework lên cây
#   smali của services.jar -> patch đầu tiên không tìm thấy class -> sys.exit(1)
#   -> services.jar LUÔN bị khôi phục từ backup, tức KHÔNG hề được vá.
#   Commit 0a3ae19 (02/11) sửa lỗi đó, nên từ đó services.jar mới thật sự được
#   vá bằng SERVICES_PATCH (KaoriosHook->initSystemServer trong SystemServer.run).
#   Đây là khác biệt chức năng duy nhất trong chuỗi fake lock giữa bản chạy được
#   và bản hiện tại, nên để false sẽ tái lập đúng cấu hình cũ.
SERVICES_HOOK=$(grep -m1 '^kaorios_services_hook=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$SERVICES_HOOK" = "false" ]; then
    patch "Bỏ qua services.jar (kaorios_services_hook=false) - giống bản build cũ"
else
    Patch_services  || { FAILED=1; restore_jar "$(get_file_dir services.jar)"; }
fi

if [ "$FAILED" -ne 0 ]; then
    patch "CẢNH BÁO: Fake Lock KHÔNG được áp đầy đủ. ROM vẫn boot bình thường nhưng"
    patch "           trạng thái lock/integrity sẽ là thật (unlocked). Xem log phía trên."
    exit 0
fi

if [ "$SERVICES_HOOK" = "false" ]; then
    patch "Fake Lock: đã áp framework.jar (services.jar bị bỏ qua theo cờ)"
else
    patch "Fake Lock: đã áp framework.jar + services.jar"
fi
exit 0
