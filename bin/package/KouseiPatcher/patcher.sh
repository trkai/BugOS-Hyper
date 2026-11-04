#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
# ---------------------------------------------------------------------------
# Kaorios Toolbox 2.0.6.1 patcher (framework.jar + services.jar)
#
# Khác bản KouseiPatcher cũ (< 2.0.4) đang nằm trong repo:
#
#   1. Payload là `payload/classes.dex` (171 100 B, sha256 953a25a2…) chứ không
#      còn là 316 file smali chép tay. Payload được baksmali ngay lúc build nên
#      byte khớp đúng bản phát hành; sửa smali bằng tay sẽ làm lệch hash.
#
#   2. Hook còn 5 class, tất cả đều nằm trong dex CHỦ của nó:
#        framework.jar : ActivityThread, Instrumentation, Settings$NameValueCache
#        services.jar  : SystemServer, ComputerEngine
#      Bỏ hook ApplicationPackageManager.hasSystemFeature (payload trả null nên
#      chèn vào chỉ tốn 1 register) và bỏ 2 hook AndroidKeyStoreSpi /
#      AndroidKeyStoreKeyPairGeneratorSpi (2 helper đó là stub trong 2.0.6.1,
#      chèn vào cũng trả đúng giá trị gốc). Attestation giờ do payload xử lý
#      bằng CustomProvider + CustomKeyStoreSpi đăng ký lúc initSystemServer.
#
#   3. Không còn mvsml()/mvdir(). Bản cũ bê class sang một split mới, kéo theo
#      toàn bộ register của class đó phải tính lại; payload + hook giờ ở đúng
#      split gốc, payload vào split mới nguyên khối.
#
#   4. 2.0.6.1 không hook SettingsProvider nên không có nguy cơ bootloop
#      NoSuchMethodError như cảnh báo trong Patch_Guide_2.0.6.1.
#
# Cần java (CI dùng temurin 17) + python3.
# ---------------------------------------------------------------------------

dir=$(pwd)
work_dir="$dir"
source "$dir/functions.sh"

sdkLevel=$(cat "$dir/bin/ddevice/sdkLevel.txt" 2>/dev/null | tr -d '\r\n ')
[ -z "$sdkLevel" ] && sdkLevel=37

# 2.0.6.1 chọn bố cục hook theo thế hệ Android. SDK 37 = Android 17 (annibale).
case "$sdkLevel" in
    33) android_ver=13 ;;
    34) android_ver=14 ;;
    35) android_ver=15 ;;
    36) android_ver=16 ;;
    *)  android_ver=17 ;;
esac

K_DIR="$dir/bin/package/KouseiPatcher"
PAYLOAD_DEX="$K_DIR/payload/classes.dex"
PAYLOAD_SHA=953a25a2f7569eb11b107bda591bcbd0ad0d30e0c6d33def51799478ea1e93a9
PATCHER="$K_DIR/patcher_v2061/script/kaorios_patcher.py"

JARDIR="$dir/jar_temp"
JAR_BACKUP="$JARDIR/backup"
PAYLOAD_SMALI="$JARDIR/kaorios-payload-smali"

mkdir -p "$JARDIR" "$JAR_BACKUP"

# Namespace của payload. Xoá trước khi import để không bao giờ có 2 bản cùng
# descriptor trong jar (java chỉ nạp bản đầu tiên -> hành vi không xác định).
PAYLOAD_NS=(android/security/kaorios com/kousei/framework)

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
    p=$(find "$dir/build/baserom/images/" -name "$1" 2>/dev/null | head -n1)
    [ -z "$p" ] && p=$(sudo -n find "$dir/build/baserom/images/" -name "$1" 2>/dev/null | head -n1)
    printf '%s' "$p"
}

check_payload() {
    if [ ! -f "$PAYLOAD_DEX" ]; then
        patch "Fail: không thấy $PAYLOAD_DEX"
        return 1
    fi
    local got
    got=$(sha256sum "$PAYLOAD_DEX" | cut -d' ' -f1)
    if [ "$got" != "$PAYLOAD_SHA" ]; then
        patch "Fail: payload classes.dex sai hash (got $got)"
        return 1
    fi
    return 0
}

# baksmali payload -> $PAYLOAD_SMALI (dùng cho --payload-smali của patcher)
disasm_payload() {
    rm -rf "$PAYLOAD_SMALI"
    mkdir -p "$PAYLOAD_SMALI"
    if ! java -jar "$dir/bin/apktool/baksmaliv2.jar" d --api "$sdkLevel" \
            "$PAYLOAD_DEX" -o "$PAYLOAD_SMALI" >/dev/null 2>&1; then
        patch "Fail: không baksmali được payload classes.dex"
        return 1
    fi
    local n
    n=$(find "$PAYLOAD_SMALI" -name '*.smali' | wc -l)
    if [ "$n" -lt 60 ]; then
        patch "Fail: payload baksmali ra $n class (mong đợi 66)"
        return 1
    fi
    return 0
}

jar_util()
{
    cd "$dir" || return 1
    if [[ $3 == "fw" ]]; then
        bak="java -jar $dir/bin/apktool/baksmaliv2.jar d --api $sdkLevel"
        sma="java -jar $dir/bin/apktool/smaliv2.jar a --api $sdkLevel"
    fi

    if [[ $1 == "d" ]]; then
        echo -ne "====> Patching $2 : "
        file_path=$(get_file_dir "$2")
        if [[ -z "$file_path" ]]; then
            echo "Fail (không tìm thấy $2)"
            return 1
        fi
        backup_jar "$file_path"
        sudo cp "$file_path" "$JARDIR"
        sudo chown "$(whoami)" "$JARDIR/$2"
        rm -rf "$JARDIR/$2.out"
        unzip "$JARDIR/$2" -d "$JARDIR/$2.out" >/dev/null 2>&1
        if [[ ! -d "$JARDIR/$2.out" ]]; then
            echo "Fail (không giải nén được $2)"
            return 1
        fi
        rm -rf "$JARDIR/$2"
        local dex
        for dex in $(find "$JARDIR/$2.out" -maxdepth 1 -name "*dex"); do
            if [[ $4 ]]; then
                if [[ ! "$dex" == *"$4"* ]]; then
                    $bak "$dex" -o "$dex.out" || { echo "Fail (baksmali $dex)"; return 1; }
                    [[ -d "$dex.out" ]] && rm -rf "$dex"
                fi
            else
                $bak "$dex" -o "$dex.out" || { echo "Fail (baksmali $dex)"; return 1; }
                [[ -d "$dex.out" ]] && rm -rf "$dex"
            fi
        done
        return 0
    fi

    if [[ $1 == "a" ]]; then
        if [[ ! -d "$JARDIR/$2.out" ]]; then
            echo "Fail (không có thư mục $2.out)"
            return 1
        fi
        cd "$JARDIR/$2.out" || return 1

        local expected=""
        local fld
        for fld in $(find . -maxdepth 1 -type d -name "*.out"); do
            expected="$expected ${fld%.out}"
        done

        for fld in $(find . -maxdepth 1 -type d -name "*.out"); do
            if [[ $4 ]]; then
                if [[ ! "$fld" == *"$4"* ]]; then
                    $sma "$fld" -o "${fld%.out}" || { cd "$dir"; echo "Fail (smali $fld)"; return 1; }
                    [[ -f "${fld%.out}" ]] && rm -rf "$fld"
                fi
            else
                $sma "$fld" -o "${fld%.out}" || { cd "$dir"; echo "Fail (smali $fld)"; return 1; }
                [[ -f "${fld%.out}" ]] && rm -rf "$fld"
            fi
        done

        local miss=""
        local d
        for d in $expected; do
            [ -f "$d" ] || miss="$miss $d"
        done
        if [ -n "$miss" ]; then
            cd "$dir"
            echo "Fail (thiếu dex:$miss)"
            return 1
        fi

        cd "$dir" || return 1
        7za a -tzip -mx=0 "$JARDIR/$2_notal" "$JARDIR/$2.out/." >/dev/null 2>&1
        zipalign 4 "$JARDIR/$2_notal" "$JARDIR/$2"
        if [[ -f "$JARDIR/$2" ]] && unzip -t "$JARDIR/$2" >/dev/null 2>&1; then
            sudo cp -rf "$JARDIR/$2" "$(get_file_dir "$2")"
            echo "Success"
            rm -rf "$JARDIR/$2.out" "$JARDIR/$2_notal"
            return 0
        fi
        echo "Fail (jar tạo ra không hợp lệ)"
        return 1
    fi
}

# Tên split trống kế tiếp. `classes.dex.out` đếm là 1; bản cũ tính ra 0 rồi
# tạo `classes1.dex.out`, tên đó không phải split hợp lệ của ART.
next_split() {
    local base="$1" max=0 d n
    for d in "$base"/classes*.dex.out; do
        [ -d "$d" ] || continue
        n=$(basename "$d" .dex.out)
        n=${n#classes}
        n=${n:-1}
        [[ $n =~ ^[0-9]+$ ]] || continue
        [ "$n" -gt "$max" ] && max="$n"
    done
    [ "$max" -le 1 ] && max=1
    printf '%s/classes%d.dex.out' "$base" "$((max + 1))"
}

drop_payload_namespaces() {
    local base="$1" ns
    for ns in "${PAYLOAD_NS[@]}"; do
        rm -rf "$base"/*/"$ns"
    done
}

import_payload() {
    local framework_dir="$1" split
    split=$(next_split "$framework_dir")
    mkdir -p "$split"
    cp -rf "$PAYLOAD_SMALI/." "$split/"
    echo "  payload -> $(basename "$split")"
}

run_patcher() {
    # Patcher in tiếng Việt ra stdout; CI runner đôi khi để LANG=C nên ép UTF-8.
    PYTHONIOENCODING=utf-8 python3 "$PATCHER" "$1" \
        --android-version "$android_ver" --mode 1 --no-delay \
        --payload-smali "$PAYLOAD_SMALI"
}

Patch_Framework () {
    if ! jar_util d 'framework.jar' fw; then
        patch "Fail: không decompile được framework.jar - giữ nguyên jar gốc"
        return 1
    fi

    FRAMEWORK_DIR="$JARDIR/framework.jar.out"
    drop_payload_namespaces "$FRAMEWORK_DIR"
    if ! import_payload "$FRAMEWORK_DIR"; then
        patch "Fail: không import được payload vào framework.jar"
        return 1
    fi

    if ! run_patcher "$FRAMEWORK_DIR"; then
        patch "Fail: kaorios_patcher.py không vá được framework.jar - giữ nguyên jar gốc"
        rm -rf "$FRAMEWORK_DIR"
        return 1
    fi

    if ! jar_util a 'framework.jar' fw; then
        patch "Fail: không build lại được framework.jar - khôi phục bản gốc"
        return 1
    fi
    return 0
}

Patch_services () {
    if ! jar_util d 'services.jar' fw; then
        patch "Fail: không decompile được services.jar - giữ nguyên jar gốc"
        return 1
    fi

    if ! run_patcher "$JARDIR/services.jar.out"; then
        patch "Fail: kaorios_patcher.py không vá được services.jar - giữ nguyên jar gốc"
        rm -rf "$JARDIR/services.jar.out"
        return 1
    fi

    if ! jar_util a 'services.jar' fw; then
        patch "Fail: không build lại được services.jar - khôi phục bản gốc"
        return 1
    fi
    return 0
}

if ! check_payload; then
    exit 1
fi
if ! disasm_payload; then
    exit 1
fi

FAILED=0
Patch_Framework || { FAILED=1; restore_jar "$(get_file_dir framework.jar)"; }

# kaorios_services_hook=false: bỏ vá services.jar (hook SystemServer +
# ComputerEngine). Payload vẫn nằm trong framework.jar nên app vẫn chạy, chỉ
# mất phần AdvancedPolicyService (SystemServer) và ẩn app list (ComputerEngine).
SERVICES_HOOK=$(grep -m1 '^kaorios_services_hook=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
if [ "$SERVICES_HOOK" = "false" ]; then
    patch "Bỏ qua services.jar (kaorios_services_hook=false)"
else
    Patch_services || { FAILED=1; restore_jar "$(get_file_dir services.jar)"; }
fi

rm -rf "$PAYLOAD_SMALI"

if [ "$FAILED" -ne 0 ]; then
    patch "CẢNH BÁO: Kaorios Toolbox KHÔNG được áp đầy đủ. ROM vẫn boot bình thường"
    patch "           nhưng app sẽ không có hook, trạng thái lock/integrity là thật."
    exit 0
fi

patch "Kaorios Toolbox 2.0.6.1: đã áp payload + hook A$android_ver"
exit 0
