work_dir=$(pwd)
source "$work_dir/functions.sh"

# Mod riêng cho OS4 nằm trong bin/modfile/OS4/. Hiện thư mục RỖNG (Launcher_RustMod
# đã bị xoá) - dispatch_mods tự bỏ qua khi không có mod, nên build không in dòng
# "Starting..." vô nghĩa.
rom_os=$(cat "$work_dir/bin/ddevice/rom_os.txt" 2>/dev/null | tr -d '\r\n ')
if [[ "$rom_os" != "OS4" ]]; then
    exit 0
fi

dispatch_mods "$work_dir/bin/modfile/OS4" "insmod" "Áp mod OS4"
