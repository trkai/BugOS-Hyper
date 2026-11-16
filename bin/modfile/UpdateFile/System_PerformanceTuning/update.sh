#!/bin/bash
# SPDX-License-Identifier: GPL-3.0
# ---------------------------------------------------------------------------
# System_PerformanceTuning - giảm nhiệt và mức tiêu thụ pin mà KHÔNG đổi
# trải nghiệm người dùng.
#
# Nguyên tắc thiết kế (quan trọng):
#   * KHÔNG đụng scaling_governor. Governor gốc của Qualcomm là `walt` đã điều
#     tiết theo tải rất tốt. Đổi sang `powersave` làm máy giật rõ rệt (phá trải
#     nghiệm), đổi sang `performance` ghim xung tối đa (gây nóng) — cả hai đều
#     trái yêu cầu.
#   * Chỉ dùng đúng một đòn bẩy: trần xung nhịp (scaling_max_freq), giống hệt
#     card "Hiệu năng" trong Toolbox. Nhờ vậy hai nơi không đá nhau.
#   * Phần "giảm nhiệt/pin" đến từ việc tắt dịch vụ nền không cần thiết, chứ
#     không phải bóp xung.
#
# Mức được lưu ở /data/adb/bugos_perf_mode (Toolbox ghi khi người dùng bấm).
# Script này chỉ áp lại sau khi boot xong (dự phòng khi KernelSU service.d
# không chạy), đọc cùng một file nên luôn khớp lựa chọn của người dùng.
# ---------------------------------------------------------------------------

work_dir=$(pwd)
source "$work_dir/functions.sh"

ENABLE=$(grep -m1 '^perf_tuning=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
[ -z "$ENABLE" ] && ENABLE=true

if [ "$ENABLE" = "false" ]; then
    mods "PerfTuning: bỏ qua (perf_tuning=false)"
    exit 0
fi

IMG="$work_dir/build/baserom/images"
SYS="$IMG/system/system"
[ -d "$SYS/etc" ] || SYS="$IMG/system"
if [ ! -d "$SYS" ]; then
    warn "PerfTuning: không thấy phân vùng system - bỏ qua"
    exit 0
fi

# ==================== 1. Init hook ====================
# Chạy SAU khi boot xong: PackageManager đã sẵn sàng (pm disable mới có tác
# dụng) và mọi tiến trình khởi động đã ổn định.
INIT_DIR="$SYS/etc/init"
mkdir -p "$INIT_DIR"

cat > "$INIT_DIR/bugos.perf.rc" << 'EOF'
# BugOS - áp lại mức hiệu năng và tắt dịch vụ nền sau khi boot xong.
# Chỉ chỉnh trần xung nhịp, không đổi governor (xem apply_perf.sh).
on property:sys.boot_completed=1
    exec - root root -- /system/etc/bugos/apply_perf.sh
EOF

mods "PerfTuning: cài init hook $INIT_DIR/bugos.perf.rc"

# ==================== 2. apply_perf.sh ====================
ETC_DIR="$SYS/etc/bugos"
mkdir -p "$ETC_DIR"

cat > "$ETC_DIR/apply_perf.sh" << 'SCRIPT'
#!/system/bin/sh
# Áp mức hiệu năng đã chọn + tắt dịch vụ nền.
# Đòn bẩy duy nhất là trần xung nhịp; governor giữ nguyên `walt`.

MODE_FILE=/data/adb/bugos_perf_mode
LEVEL=$(cat "$MODE_FILE" 2>/dev/null)
[ -z "$LEVEL" ] && LEVEL=balanced

P0=/sys/devices/system/cpu/cpufreq/policy0
P6=/sys/devices/system/cpu/cpufreq/policy6

case "$LEVEL" in
    power)
        # Tiết kiệm pin: hạ trần ~27% ở cả 2 cụm, giữ nguyên sàn. Giao diện
        # vẫn mượt vì governor vẫn được phép nâng xung trong khoảng trần mới.
        N0=556800; N6=1017600; X0=1996800; X6=2438400 ;;
    performance)
        # Hiệu năng: nâng SÀN để CPU lên xung cao nhanh hơn -> phản hồi tốt
        # hơn, nhưng KHÔNG ghim xung tối đa nên không nóng.
        N0=960000; N6=1401600; X0=2745600; X6=3072000 ;;
    *)
        # Cân bằng: đúng cấu hình nhà sản xuất.
        N0=556800; N6=1017600; X0=2745600; X6=3072000 ;;
esac

# Chỉ ghi khi giá trị hiện tại khác, tránh wake-up vô ích.
apply() {
    # $1=file $2=value
    [ -f "$1" ] || return 0
    [ -z "$2" ] && return 0
    [ "$(cat "$1" 2>/dev/null)" = "$2" ] && return 0
    echo "$2" > "$1" 2>/dev/null
}

# Đặt sàn trước rồi mới đặt trần: nếu trần mới thấp hơn sàn hiện tại, kernel
# sẽ từ chối lệnh ghi trần.
apply "$P0/scaling_min_freq" "$N0"
apply "$P6/scaling_min_freq" "$N6"
apply "$P0/scaling_max_freq" "$X0"
apply "$P6/scaling_max_freq" "$X6"

# --- Tắt dịch vụ nền không cần thiết -----------------------------------
# Chỉ những gói telemetry/quét mã, không ảnh hưởng chức năng người dùng thấy.
# Bọc kiểm tra: gói nào không có thì bỏ qua, không ghi log lỗi.
for p in com.miui.analytics com.miui.hybrid com.xiaomi.scanner; do
    if pm path "$p" >/dev/null 2>&1; then
        pm disable-user --user 0 "$p" >/dev/null 2>&1
    fi
done

log -t BugOSPerf "PerfTuning: level=$LEVEL max0=$X0 max6=$X6"
SCRIPT

chmod 0755 "$ETC_DIR/apply_perf.sh"

# ==================== 3. fs_config ====================
FS_CFG="$IMG/config/system_fs_config"
if [ -f "$FS_CFG" ]; then
    {
        echo "system/etc/init/bugos.perf.rc 0 0 0644"
        echo "system/etc/bugos/apply_perf.sh 0 0 0755"
    } >> "$FS_CFG"
fi

mods "PerfTuning: cài apply_perf.sh + fs_config"
mods "PerfTuning: giữ governor gốc, chỉ chỉnh trần xung theo mức đã chọn"
exit 0
