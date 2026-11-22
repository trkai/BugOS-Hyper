work_dir=$(pwd)
source "$work_dir/functions.sh"

# Mod thay file trong images: bin/modfile/UpdateFile/*/update.sh (Fonts, MultiLang,
# Apps_Replace, Settings_ROMInformation, ...). Thứ tự TẤT ĐỊNH theo đường dẫn -
# mod sau có thể sửa file mà mod trước vừa chép, nên thứ tự không được ngẫu
# nhiên. Xử lý lỗi nằm ở dispatch_mods (functions.sh).
dispatch_mods "$work_dir/bin/modfile/UpdateFile" "insupdate" "Áp mod UpdateFile"
