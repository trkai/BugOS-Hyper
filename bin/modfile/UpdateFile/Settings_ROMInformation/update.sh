#!/bin/bash
WORK_DIR=$(pwd)
source $WORK_DIR/functions.sh
MAIN_FOLDER="$WORK_DIR/build/baserom/images"
rom_os=$(cat $WORK_DIR/bin/ddevice/rom_os.txt 2>/dev/null | tr -d '\r\n ')
regionTYPE=$(cat $WORK_DIR/bin/ddevice/device_type.txt 2>/dev/null | tr -d '\r\n ')
base_rom_code=$(cat $WORK_DIR/bin/ddevice/base_rom_code.txt 2>/dev/null | tr -d '\r\n ')
build_date=$(TZ=Asia/Ho_Chi_Minh date +"%y%m%d")

APKEDITOR="java -jar $WORK_DIR/bin/apktool/apke.jar"
repS="python3 $WORK_DIR/bin/strRep.py"

# Ghi đè vào build.prop của hệ thống
my_props=(
    "$MAIN_FOLDER/system/system/build.prop"
    "$MAIN_FOLDER/product/etc/build.prop"
)

# Lấy version ROM thật từ build.prop (HyperOS trước, MIUI/incremental sau)
rom_version_name=$(grep -h -m1 '^ro\.mi\.os\.version\.name=' "${my_props[@]}" 2>/dev/null | head -n 1 | cut -d= -f2- | tr -d '\r\n ')
[ -z "$rom_version_name" ] && rom_version_name=$(grep -h -m1 '^ro\.build\.version\.incremental=' "${my_props[@]}" 2>/dev/null | head -n 1 | cut -d= -f2- | tr -d '\r\n ')
[ -z "$rom_version_name" ] && rom_version_name="$base_rom_code"
[ -z "$rom_version_name" ] && rom_version_name="BugOS"

# Bỏ hậu tố build dư (vd: 3.0.307.0.WPKCNXM.C09 -> 3.0.307.0.WPKCNXM), giữ tối đa 5 thành phần
rom_version_short=$(printf '%s\n' "$rom_version_name" | awk -F. -v OFS=. '{ if (NF > 5) NF = 5; print }')
# ROM China ghi version không kèm tiền tố "OS" -> bỏ đi cho khớp hiển thị
rom_version_short=${rom_version_short#OS}
rom_version_display="${rom_version_short} | BugOS"
mods "OS version hiển thị: ${rom_version_display}"

for p in "${my_props[@]}"; do
    if [ -f "$p" ]; then
        sed -i \
            -e '/^ro\.bugos\.version=/d' \
            -e '/^ro\.bugos\.incremental=/d' \
            -e '/^ro\.bugos\.simposcode=/d' \
            -e '/^ro\.bugos\.osversion=/d' \
            -e '/^ro\.mi\.os\.version\.incremental=/d' "$p"

        [ -n "$(tail -c1 "$p")" ] && echo "" >> "$p"

        {
            echo "ro.bugos.version=${rom_version_display}"
            echo "ro.bugos.incremental=${rom_version_display}"
            echo "ro.bugos.simposcode=${rom_version_display}"
            echo "ro.bugos.osversion=${build_date}"
            # Ghi đè luôn prop gốc mà Settings đọc cho dòng "OS version"
            echo "ro.mi.os.version.incremental=${rom_version_display}"
        } >> "$p"
    fi
done

# Patch Settings.apk để hiển thị logo và thông tin bản build
isSettings=$(find "$MAIN_FOLDER" -type f -name "Settings.apk" | head -n 1)

if [ -n "$isSettings" ] && [ -f "$isSettings" ]; then
    isSettingsDIR=$(dirname "$isSettings")
    mods "Patching Settings: Customizing BugOS Branding & Logo..."

    rm -rf "$WORK_DIR/apk_temp"
    mkdir -p "$WORK_DIR/apk_temp/final"
    DECODE_LOG="$WORK_DIR/apk_temp/decode.log"

    if ! $APKEDITOR d -f -i "$isSettings" -o "$WORK_DIR/apk_temp/isSettings.apk.out" >"$DECODE_LOG" 2>&1 \
       || [ ! -f "$WORK_DIR/apk_temp/isSettings.apk.out/apktool.yml" ]; then
        mods "Decode Settings.apk thất bại -> bỏ qua patch Settings (ROM vẫn dùng brand build.prop)."
        tail -n 8 "$DECODE_LOG" 2>/dev/null
    else
        # 1. Thay thế vector/drawable logo HyperOS bằng Logo BugOS
        LOGO_SRC="$WORK_DIR/bin/modfile/UpdateFile/Settings_ROMInformation/ic_hyper_os.xml"
        logo_count=0
        if [ -f "$LOGO_SRC" ] && [ -d "$WORK_DIR/apk_temp/isSettings.apk.out/res" ]; then
            while IFS= read -r logo_target; do
                cp -f "$LOGO_SRC" "$logo_target" && logo_count=$((logo_count + 1))
            done < <(find "$WORK_DIR/apk_temp/isSettings.apk.out/res" -type f \( \
                -name "ic_hyper_os.xml" -o \
                -name "ic_hyper_os_logo.xml" -o \
                -name "ic_os_logo.xml" -o \
                -name "my_device_os_logo.xml" -o \
                -name "hyper_os_logo.xml" \) )
        fi
        if [ "$logo_count" -gt 0 ]; then
            mods "Replaced $logo_count logo asset(s)."
        else
            mods "Không tìm thấy asset logo OS để thay (bỏ qua)."
        fi

        # 2. Patch các phương thức smali trong MiuiAboutPhoneUtils
        p1=$(find "$WORK_DIR/apk_temp/isSettings.apk.out" -type f -name "MiuiAboutPhoneUtils.smali" | head -n 1)
        if [ -n "$p1" ] && [ -f "$p1" ]; then
            tar1="$WORK_DIR/bin/modfile/UpdateFile/Settings_ROMInformation/getMiuiVersionInCard.ini"
            tar2="$WORK_DIR/bin/modfile/UpdateFile/Settings_ROMInformation/getRoXmsVersion.ini"
            tar3="$WORK_DIR/bin/modfile/UpdateFile/Settings_ROMInformation/getXmsVersion.ini"
            tar4="$WORK_DIR/bin/modfile/UpdateFile/Settings_ROMInformation/getSimpleOSVersion.ini"

            [ -f "$tar1" ] && $repS "$tar1" "$p1" >/dev/null 2>&1
            [ -f "$tar2" ] && $repS "$tar2" "$p1" >/dev/null 2>&1
            [ -f "$tar3" ] && $repS "$tar3" "$p1" >/dev/null 2>&1
            [ -f "$tar4" ] && $repS "$tar4" "$p1" >/dev/null 2>&1
            mods "Patched MiuiAboutPhoneUtils smali methods."
        else
            mods "Không thấy MiuiAboutPhoneUtils.smali (bỏ qua smali patch)."
        fi

        # 3. Đóng gói lại Settings.apk
        Settings_name=$(basename "$isSettings")
        $APKEDITOR b -f -i "$WORK_DIR/apk_temp/isSettings.apk.out" -o "$WORK_DIR/apk_temp/final/$Settings_name" >/dev/null 2>&1

        # Chỉ ghi đè khi build lại thành công (tránh bootloop)
        if [ -s "$WORK_DIR/apk_temp/final/$Settings_name" ]; then
            cp -f "$WORK_DIR/apk_temp/final/$Settings_name" "$isSettingsDIR/$Settings_name"
            mods "Successfully applied BugOS branded Settings.apk!"
        else
            mods "Settings rebuild thất bại; giữ APK gốc, chỉ áp brand build.prop."
        fi
    fi

    rm -rf "$WORK_DIR/apk_temp"
fi

mods "BugOS ROM Information Integration Done!"
