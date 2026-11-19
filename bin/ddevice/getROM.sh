#!/bin/bash

baserom="$1"
work_dir=$(pwd)
source "$work_dir/functions.sh"
# Check whether it is a local package or a link
if [ ! -f "${baserom}" ] && [ "$(echo $baserom |grep http)" != "" ]; then
    info "Download link detected, starting a download..."

    # Kiem tra file tai ve co dung la mot zip hoan chinh khong.
    # -f chi noi "co file", khong noi file do dung duoc: mot file bi cat ngang
    # van qua duoc -f, va do chinh la cach build 05/11 di tiep voi mot zip
    # 4.2/8.7 GiB roi chet o buoc unzip voi thong bao kho hieu
    # "End-of-central-directory signature not found".
    rom_zip_ok() {
        [ -f "$1" ] || return 1
        unzip -t "$1" >/dev/null 2>&1
    }

    # Ten file tren dia khac URL: --content-disposition lay ten tu header.
    # Phai tinh TRUOC vong lap, vi vong lap can biet dang kiem file nao.
    rom_file=$(basename "${baserom%%\?*}")
    info "ROM: file đích ${rom_file}"

    for attempt in 1 2 3; do
        # Lan 1: -c de resume neu con file do dang. Cac lan sau: file da bi
        # nghiem la hong (khong chi thieu byte) nen phai xoa va tai lai tu dau,
        # vi resume tu mot central directory hong se ket thuc ngay lap tuc.
        if [ "$attempt" -gt 1 ]; then
            rm -f "$rom_file"
        fi

        # -c: resume.
        # --timeout/--connect-timeout/--max-tries: mac dinh aria2 khong co gioi
        #     han tong, gap CDN tra cham la treo im lang khong bao gio ket thuc.
        # --lowest-speed-limit: TRUOC DAY LA 100K va no tu giet download. CDN
        #     Xiaomi co luc tut ve ~55KB/s (log 05/11 01:51:46: "Too slow
        #     Downloading speed: 55650 <= 102400"), aria2 huy CA 10 ket noi va
        #     tra ERR du toc do trung binh van 91MiB/s. 10K chi bat dung truong
        #     hop chet han, con --timeout=60 moi la thu bat stall that su.
        # --summary-interval=10: in tien do moi 10s, de log CI thay no con chay.
        aria2c -c --max-tries=20 --retry-wait=5 \
            --timeout=60 --connect-timeout=30 --lowest-speed-limit=10K \
            --summary-interval=10 --console-log-level=warn \
            --max-download-limit=1024M --file-allocation=none -s10 -x10 -j10 --content-disposition -U "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" "${baserom}" || true

        if rom_zip_ok "$rom_file"; then
            break
        fi
        warn "ROM: lần tải $attempt chưa xong hoặc file hỏng - thử lại"
    done

    baserom="$rom_file"
    if ! rom_zip_ok "${baserom}"; then
        error "Download error! (thiếu hoặc hỏng: ${baserom})"
        exit 1
    fi
elif [ -f "${baserom}" ]; then
    info "BASEROM: ${baserom}"
else
    error "BASEROM: Invalid parameter"
    exit 1
fi


# Get ROM Info
if [ "$(echo $baserom |grep miui_)" != "" ]; then
    device_code=$(basename $baserom |cut -d '_' -f 2)
    base_rom_code=$(echo "$baserom" | awk -F'_' '{print $3}')
elif [ "$(echo $baserom |grep xiaomi.eu_)" != "" ]; then
    device_code=$(basename $baserom |cut -d '_' -f 3)
    base_rom_code=$(echo "$baserom" | awk -F'_' '{print $3}')
elif [ "$(echo $baserom | grep -E '.*-ota_full-.*')" != "" ]; then
    device_code=$(basename $baserom | cut -d '-' -f 1)
    base_rom_code=$(basename $baserom | cut -d '-' -f 3)

    # Transform device_code
    device_code=$(echo $device_code | awk -F '_' '{
        if (NF == 1) {
            # If one part, e.g., shennong
            print toupper($1)
        } else if (NF == 2) {
            # If two parts, e.g., tapas_global
            print toupper($1) toupper(substr($2, 1, 1)) substr($2, 2)
        } else if (NF == 3) {
            # If three parts, e.g., houji_tw_global
            printf toupper($1) toupper($2) toupper(substr($3, 1, 1)) substr($3, 2)
        }
    }')
else
    device_code="YourDevice"
    base_rom_code="Unknown"
fi

# Determine Device Type
info "Get Device Type"
if echo "$device_code" | grep -q 'EEAGlobal'; then
    DEVICE_TYPE="EEAGlobal"
elif echo "$device_code" | grep -q 'INGlobal'; then
    DEVICE_TYPE="INGlobal"
elif echo "$device_code" | grep -q 'IDGlobal'; then
    DEVICE_TYPE="IDGlobal"
elif echo "$device_code" | grep -q 'RUGlobal'; then
    DEVICE_TYPE="RUGlobal"
elif echo "$device_code" | grep -q 'JPGlobal'; then
    DEVICE_TYPE="JPGlobal"
elif echo "$device_code" | grep -q 'TWGlobal'; then
    DEVICE_TYPE="TWGlobal"
elif echo "$device_code" | grep -q 'TRGlobal'; then
    DEVICE_TYPE="TRGlobal"
elif echo "$device_code" | grep -q 'Global'; then
    DEVICE_TYPE="Global"
else
    DEVICE_TYPE="China"
fi

# ---------------------------------------------------------------------------
# CHỈ NHẬN ROM CHINA.
#
# Mã vùng Xiaomi nằm ở ĐUÔI base_rom_code, dạng "<số hiệu>.<vùng>":
#     OS4.0.6.0.XPKCNXM   -> đuôi CNXM    = China
#     OS4.0.6.0.XMGEUXM   -> đuôi EUXM    = EEA (Global)
#     OS4.0.6.0.XMGRU     -> đuôi RU      = Russia
#
# Trước đây bước này tin DEVICE_TYPE, mà DEVICE_TYPE chỉ là "China nếu
# device_code không chứa chữ Global". Mã Global không phải lúc nào cũng có chữ
# "global" trong tên file (XMGEUXM!), nên ROM EEA bị nhận là China và toàn bộ
# mod de-China chạy sai base.
#
# Kiểm tra 2 lớp:
#   (1) Ở đây - theo tên file, chặn TRƯỚC khi tải cả GB.
#   (2) target_check.sh - đọc ro.miui.build.region từ build.prop sau khi bung,
#       vì tên file có thể bị đổi.
#
# Đuôi nhận là China: CNXM (và biến thể chứa CN như CNXM/CHN).
# ---------------------------------------------------------------------------
ROM_REGION_TAIL=$(echo "$base_rom_code" | sed -E 's/^.*\.//; s/[0-9]+$//' | tr -d '\r\n ')

case "$ROM_REGION_TAIL" in
    CNXM|CNXM*|*CNXM)
        : # China - nhận
        ;;
    "")
        warn "ROM: không đọc được mã vùng từ tên file ('$base_rom_code') - sẽ kiểm lại bằng build.prop"
        ;;
    *)
        echo "ROM vùng '$ROM_REGION_TAIL' (mã '$base_rom_code') KHÔNG phải China (CNXM)."
        echo "Repo này chỉ build ROM CHINA. Dừng."
        exit 1
        ;;
esac

# Tên file có chữ "global" -> chắc chắn quốc tế, dừng luôn.
if echo "$device_code" | grep -qi 'global'; then
    echo "ROM quốc tế ('$device_code') - chỉ nhận ROM CHINA. Dừng."
    exit 1
fi

# Chỉ hỗ trợ HyperOS 4. Các nhánh OS1/OS2/OS3 và MIUI (V13/V14) đã bị xoá cùng
# toàn bộ mod/modfile của chúng — nhận nhầm một ROM cũ sẽ dựng ROM thiếu patch mà
# không báo lỗi, nên ở đây phải DỪNG và nói rõ.
if echo "$base_rom_code" | grep -q "OS4"; then
    ROM_OS="OS4"
elif echo "$base_rom_code" | grep -qE "(OS1|OS2|OS3|V13|V14)"; then
    echo "ROM này là '$(echo "$base_rom_code" | grep -oE '(OS[0-9]+|V1[34])' | head -n1)' - repo chỉ hỗ trợ OS4."
    echo "Unsupport ROM Exiting..."
    exit 1
elif echo "$base_rom_code" | grep -qE "OS[0-9]+"; then
    echo "ROM '$(echo "$base_rom_code" | grep -oE 'OS[0-9]+' | head -n1)' chưa có target - chỉ hỗ trợ OS4."
    echo "Unsupport ROM Exiting..."
    exit 1
else
    echo "Unsupport ROM Exiting..."
    exit 1
fi

echo $base_rom_code > $work_dir/bin/ddevice/base_rom_code.txt
echo $base_rom_code > $work_dir/bin/ddevice/os_code.txt
echo $device_code > $work_dir/bin/ddevice/device_code.txt
echo $DEVICE_TYPE > $work_dir/bin/ddevice/device_type.txt
echo $ROM_OS > $work_dir/bin/ddevice/rom_os.txt
