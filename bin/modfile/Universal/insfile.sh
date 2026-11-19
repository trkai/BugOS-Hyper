work_dir=$(pwd)
source "$work_dir/functions.sh"

# Mod dùng chung cho mọi máy: bin/modfile/Universal/{enhanchedkeyboard,
# gmsservices,packageinstaller}/update.sh. Thứ tự và xử lý lỗi nằm ở
# dispatch_mods (functions.sh).
dispatch_mods "$work_dir/bin/modfile/Universal" "insfile" "Áp mod Universal"
