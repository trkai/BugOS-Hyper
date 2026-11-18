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
  # maps: repo chỉ còn bộ A17 (lấy từ ROM OS4/A17 thật - annibale,
  # OS4.0.6.0.XPKCNXM). Bộ A13/A14/A15 đã xoá cùng các nhánh Android cũ, nên
  # KHÔNG còn fallback "dùng A15 cho chắc": thiếu đúng bộ là lỗi, phải biết ngay.
  if [ -d "$work_dir/bin/modfile/Universal/gmsservices/maps/A${androidVER}/framework" ]; then
    cp -rf "$work_dir/bin/modfile/Universal/gmsservices/maps/A${androidVER}/framework" "$work_dir/build/baserom/images/product/"
  else
    warn "GMS maps: không có bộ cho Android $androidVER (chỉ còn A17) - bỏ qua phần maps"
  fi
  mods "Added GMS Done"
else
  mods "Detected Xiaomi Global ROM!Skipped Added GMS."
fi
