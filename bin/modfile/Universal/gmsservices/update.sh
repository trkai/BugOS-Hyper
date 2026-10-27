work_dir=$(pwd)
source $work_dir/functions.sh
rom_os=$(cat $work_dir/bin/ddevice/rom_os.txt)
androidVER=$(cat $work_dir/bin/ddevice/androidver.txt)
regionTYPE=$(cat $work_dir/bin/ddevice/device_type.txt)
MAIN_FOLDER="$work_dir/build/baserom/images"

if [[ $regionTYPE == "China" ]]; then 
  aria2c -q -d "$work_dir/bin/modfile/Universal/gmsservices/product/priv-app/GoogleVelvet_CTS/" -o GoogleVelvet_CTS.apk https://github.com/tiencv2006/nothingsvn_oplus-toolbuild/releases/download/oplus/GoogleVelvet_CTS.apk && info "Get File Successfully"
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
