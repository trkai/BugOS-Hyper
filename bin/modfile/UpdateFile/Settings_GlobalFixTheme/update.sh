WORK_DIR=$(pwd)
source $WORK_DIR/functions.sh
MAIN_FOLDER="$WORK_DIR/build/baserom/images"
androidVER=$(cat $WORK_DIR/bin/ddevice/androidver.txt)
APKEDITOR="java -jar $WORK_DIR/bin/apktool/apke.jar"
regionTYPE=$(cat $WORK_DIR/bin/ddevice/device_type.txt)

# && và || có cùng độ ưu tiên và kết hợp trái->phải, nên điều kiện cũ thực chất là
#   (A13 || A14 || A15 || A16 || A17) && Global
# Viết lại tường minh cho dễ đọc, hành vi không đổi: chỉ chạy trên ROM Global.
if { [[ "$androidVER" == "13" ]] || [[ "$androidVER" == "14" ]] || [[ "$androidVER" == "15" ]] \
     || [[ "$androidVER" == "16" ]] || [[ "$androidVER" == "17" ]]; } \
   && [[ "$regionTYPE" == *"Global"* ]]; then
    #ready for patch
	mods "Fixing Theme Issues"
    mkdir -p $WORK_DIR/apk_temp
    isSettingsDIR=$(find "$MAIN_FOLDER" -type d -name "Settings")
    isSettings=$(find "$MAIN_FOLDER" -type f -name "Settings.apk")

    $APKEDITOR d -t raw -f -no-dex-debug -i $isSettings -o $WORK_DIR/apk_temp/isSettings.apk.out >/dev/null 2>&1
    isMiuiSettingsSmali=$(find "$WORK_DIR/apk_temp/isSettings.apk.out" -type f -name MiuiSettings.smali)

    #patching
    sed -i '
    /sget v10, Lcom\/android\/settings\/R$id;->personalize_title:I/,/sget-boolean v10, Lmiui\/os\/Build;->IS_INTERNATIONAL_BUILD:Z/ {
        /sget-boolean v10, Lmiui\/os\/Build;->IS_INTERNATIONAL_BUILD:Z/c\    const/4 v10, 0
    }
    ' $isMiuiSettingsSmali

    sed -i '
    /sget v10, Lcom\/android\/settings\/R$id;->theme_settings:I/,/sget-boolean v10, Lmiui\/os\/Build;->IS_INTERNATIONAL_BUILD:Z/ {
        /sget-boolean v10, Lmiui\/os\/Build;->IS_INTERNATIONAL_BUILD:Z/c\    const/4 v10, 0
    }
    ' $isMiuiSettingsSmali

    sed -i '
    /sget v10, Lcom\/android\/settings\/R$id;->wallpaper_settings:I/,/sget-boolean v10, Lmiui\/os\/Build;->IS_INTERNATIONAL_BUILD:Z/ {
        /sget-boolean v10, Lmiui\/os\/Build;->IS_INTERNATIONAL_BUILD:Z/c\    const/4 v10, 0
    }
    ' $isMiuiSettingsSmali


    #Finishing
    Settings=$(basename $isSettings)
    $APKEDITOR b -f -i $WORK_DIR/apk_temp/isSettings.apk.out -o $WORK_DIR/apk_temp/final/$Settings >/dev/null 2>&1

    if [ -f "$WORK_DIR/apk_temp/final/$Settings" ]; then
        rm -rf $isSettingsDIR/*
        cp -rf $WORK_DIR/apk_temp/final/$Settings $isSettingsDIR
    fi

    rm -rf $WORK_DIR/apk_temp
	mods "Done"
else
    # Hai lý do rất khác nhau nhưng trước đây dùng chung một câu "This Android
    # version is not supported", nên log build của ROM China trông như thể bản
    # Android không được hỗ trợ - trong khi thực ra mod này chỉ áp cho ROM Global.
    if [[ "$regionTYPE" != *"Global"* ]]; then
        mods "Fix theme: bỏ qua - ROM không phải Global (region=$regionTYPE), mod này chỉ dành cho ROM Global"
    else
        mods "Fix theme: bỏ qua - Android $androidVER không nằm trong 13-17"
    fi
fi