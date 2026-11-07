work_dir=$(pwd)
source $work_dir/functions.sh
rom_os=$(cat $work_dir/bin/ddevice/rom_os.txt)
androidVER=$(cat $work_dir/bin/ddevice/androidver.txt)
regionTYPE=$(cat $work_dir/bin/ddevice/device_type.txt)
MAIN_FOLDER="$work_dir/build/baserom/images"

# Payload dùng chung cho OS3 và OS4: bin/modfile/ThemeManager/.
# Trước đây mỗi OS giữ một bản sao 93 MB mà 14/15 file giống hệt nhau (chỉ update.sh
# khác tên OS). Gộp lại để một APK, một whitelist. Khi OS4 cần bản ThemeManager
# riêng thì tách lại bằng cách trỏ PAYLOAD về thư mục của chính nó.
PAYLOAD="$work_dir/bin/modfile/ThemeManager"

isOriginThemeMng=$(find "$MAIN_FOLDER" -type d \( -name "MIUIThemeManager" -o -name "MIUIThemeManagerT" -o -name "MIUIThemeManagerGlobal" -o -name "ThemeManager" \))

if [[ $rom_os == "OS4" ]] ;then
  if [ ! -d "$PAYLOAD/MIUIThemeManager" ]; then
    warn "ThemeManager: thiếu payload $PAYLOAD/MIUIThemeManager - bỏ qua, giữ APK gốc"
    exit 0
  fi
  rm -rf $isOriginThemeMng
  mkdir -p $work_dir/build/baserom/images/product/priv-app/MIUIThemeManager
  cp -rf $PAYLOAD/MIUIThemeManager/* $work_dir/build/baserom/images/product/priv-app/MIUIThemeManager
  cp -rf $PAYLOAD/permissions/privapp_whitelist_com.android.thememanager.xml $work_dir/build/baserom/images/product/etc/permissions/
  mods "Modify ThemeManager Done"

  # Ghim versionCode để kho không chào cập nhật đè bản mod - cùng cơ chế với
  # Apps_Replace, đọc chung pin_app_versions / pin_app_versioncode trong config.env.
  # Chi 4 byte versionCode trong manifest nhị phân được ghi lại, chữ ký gốc giữ
  # nguyên; COREPATCH đã patch matchSignaturesCompat nên PMS vẫn nhận.
  # Phải bump SAU khi copy, trên file trong images, để APK gốc trong repo sạch.
  PIN_PKGS=$(grep -m1 '^pin_app_versions=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2- | tr -d '"')
  PIN_CODE=$(grep -m1 '^pin_app_versioncode=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
  [ -z "$PIN_CODE" ] && PIN_CODE=2000000000
  case " $PIN_PKGS " in
    *" com.android.thememanager "*)
      TM_APK="$work_dir/build/baserom/images/product/priv-app/MIUIThemeManager/MIUIThemeManager.apk"
      BUMP="$work_dir/bin/modfile/UpdateFile/Apps_Replace/bump_versioncode.py"
      if [ -f "$TM_APK" ] && [ -f "$BUMP" ]; then
        if python3 "$BUMP" "$TM_APK" "$PIN_CODE" >/dev/null 2>&1; then
          mods "ThemeManager: versionCode -> $PIN_CODE ($(python3 "$BUMP" --show "$TM_APK" 2>/dev/null)), kho sẽ không chào cập nhật"
        else
          warn "ThemeManager: bump versionCode thất bại, kho vẫn có thể ghi đè"
        fi
      else
        warn "ThemeManager: thiếu APK hoặc bump_versioncode.py - không ghim được version"
      fi
      ;;
  esac
fi