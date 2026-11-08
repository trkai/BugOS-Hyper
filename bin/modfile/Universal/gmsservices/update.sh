work_dir=$(pwd)
source $work_dir/functions.sh
rom_os=$(cat $work_dir/bin/ddevice/rom_os.txt)
androidVER=$(cat $work_dir/bin/ddevice/androidver.txt)
regionTYPE=$(cat $work_dir/bin/ddevice/device_type.txt)
MAIN_FOLDER="$work_dir/build/baserom/images"

if [[ $regionTYPE == "China" ]]; then 
  # Google (Velvet) KHÔNG tải ở đây. Bản tải từ release ngoài là APK đơn, không có
  # config split, nên nếu đặt vào product/priv-app/GoogleVelvet thì manifest khai
  # requiredSplitTypes mà thiếu split -> PackageManager từ chối cả gói.
  # Mod GApps_Preinstall (từng đặt sẵn Velvet kèm split) đã bị bỏ, nên Velvet không
  # còn trong ROM: người dùng cài từ Play. Play Store thì vẫn ở product/priv-app/
  # Phonesky ngay bên dưới, do chính mod này chép vào.
  cp -rf $work_dir/bin/modfile/Universal/gmsservices/product/* $work_dir/build/baserom/images/product/
  cp -rf $work_dir/bin/modfile/Universal/gmsservices/system_ext/* $work_dir/build/baserom/images/system_ext/
  echo "ro.miui.has_gmscore=1" >> $work_dir/build/baserom/images/system/system/build.prop
  # maps chỉ có A13/A14/A15. A16 và A17 dùng A15 (mới nhất đang có) nhưng log rõ
  # để không âm thầm dùng sai map.
  if [[ $androidVER == "13" ]]; then
    cp -rf $work_dir/bin/modfile/Universal/gmsservices/maps/A13/framework $work_dir/build/baserom/images/product/
  elif [[ $androidVER == "14" ]]; then
    cp -rf $work_dir/bin/modfile/Universal/gmsservices/maps/A14/framework $work_dir/build/baserom/images/product/
  elif [[ $androidVER == "15" ]]; then
    cp -rf $work_dir/bin/modfile/Universal/gmsservices/maps/A15/framework $work_dir/build/baserom/images/product/
  else
    if [ -d "$work_dir/bin/modfile/Universal/gmsservices/maps/A$androidVER/framework" ]; then
      cp -rf "$work_dir/bin/modfile/Universal/gmsservices/maps/A$androidVER/framework" $work_dir/build/baserom/images/product/
    else
      warn "GMS maps: chưa có bộ riêng cho Android $androidVER - dùng A15 (có thể thiếu/thừa file)"
      cp -rf $work_dir/bin/modfile/Universal/gmsservices/maps/A15/framework $work_dir/build/baserom/images/product/
    fi
  fi
  mods "Added GMS Done"
else
  mods "Detected Xiaomi Global ROM!Skipped Added GMS."
fi
