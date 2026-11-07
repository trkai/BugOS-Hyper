work_dir=$(pwd)
source $work_dir/functions.sh
rom_os=$(cat $WORK_DIR/bin/ddevice/rom_os.txt)
regionTYPE=$(cat $work_dir/bin/ddevice/device_type.txt)
androidVER=$(cat $WORK_DIR/bin/ddevice/androidver.txt)
BuildProp1="$work_dir/build/baserom/images/system/system/build.prop"
BuildProp2="$work_dir/build/baserom/images/product/etc/build.prop"
BuildProp3="$work_dir/build/baserom/images/system_ext/etc/build.prop"
BuildProp4="$work_dir/build/baserom/images/vendor/build.prop"


# ---------------------------------------------------------------------------
# Memory Extension (内存扩展 / EXT) = dùng một phần bộ nhớ trong làm swap để mở
# rộng RAM. Tắt nó đi thì máy KHÔNG còn phần đệm đó nữa -> RAM khả dụng thấp,
# ứng dụng bị kill nhiều hơn. Đây là lý do chính khiến "hệ thống ăn RAM nhiều".
#
# Mặc định giờ GIỮ NGUYÊN giá trị của ROM (thường là bật). Muốn tắt như hành vi
# cũ thì đặt disable_memory_ext=true trong config.env.
# ---------------------------------------------------------------------------
DISABLE_MEM_EXT=$(grep -m1 '^disable_memory_ext=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d '\r\n ')
[ -z "$DISABLE_MEM_EXT" ] && DISABLE_MEM_EXT=false

log_extm_state() {
    local p v
    for p in "$BuildProp1" "$BuildProp2" "$BuildProp3" "$BuildProp4"; do
        [ -f "$p" ] || continue
        v=$(grep -m1 '^persist\.miui\.extm\.enable=' "$p" 2>/dev/null | cut -d= -f2 | tr -d '\r\n')
        if [ -n "$v" ]; then
            mods "Memory Extension: $(echo "$p" | sed "s|$work_dir/build/baserom/images/||") = $v"
            return 0
        fi
    done
    mods "Memory Extension: ROM không khai báo persist.miui.extm.enable"
}

disable_memory_extenstion() {
    BuildProp1="$work_dir/build/baserom/images/system/system/build.prop"
	BuildProp2="$work_dir/build/baserom/images/product/etc/build.prop"
	BuildProp3="$work_dir/build/baserom/images/system_ext/etc/build.prop"
	BuildProp4="$work_dir/build/baserom/images/vendor/build.prop"

    if [ "$DISABLE_MEM_EXT" != "true" ]; then
        mods "Memory Extension: giữ nguyên của ROM (không tắt)"
        log_extm_state
        return 0
    fi

    mods "Disable Memory Ext"
    sed -i "s/persist.miui.extm.enable=1/persist.miui.extm.enable=0/g" $BuildProp1
	sed -i "s/persist.miui.extm.enable=1/persist.miui.extm.enable=0/g" $BuildProp2
	sed -i "s/persist.miui.extm.enable=1/persist.miui.extm.enable=0/g" $BuildProp3
	sed -i "s/persist.miui.extm.enable=1/persist.miui.extm.enable=0/g" $BuildProp4
    log_extm_state
}

disable_privapp_control_enforce () {
    mods "Disable priv-app control enforce"
    BuildProp1="$work_dir/build/baserom/images/system/system/build.prop"
	BuildProp2="$work_dir/build/baserom/images/product/etc/build.prop"
	BuildProp3="$work_dir/build/baserom/images/system_ext/etc/build.prop"
	BuildProp4="$work_dir/build/baserom/images/vendor/build.prop"
	sed -i "s/ro.control_privapp_permissions=enforce/ro.control_privapp_permissions=/g" $BuildProp1
	sed -i "s/ro.control_privapp_permissions=enforce/ro.control_privapp_permissions=/g" $BuildProp2
	sed -i "s/ro.control_privapp_permissions=enforce/ro.control_privapp_permissions=/g" $BuildProp3
    sed -i "s/ro.control_privapp_permissions=enforce/ro.control_privapp_permissions=/g" $BuildProp4
}

disable_privapp_control_disable () {
    mods "Disable priv-app control disable"
    BuildProp1="$work_dir/build/baserom/images/system/system/build.prop"
	BuildProp2="$work_dir/build/baserom/images/product/etc/build.prop"
	BuildProp3="$work_dir/build/baserom/images/system_ext/etc/build.prop"
	BuildProp4="$work_dir/build/baserom/images/vendor/build.prop"
	sed -i "s/ro.control_privapp_permissions=disable/ro.control_privapp_permissions=/g" $BuildProp1
	sed -i "s/ro.control_privapp_permissions=disable/ro.control_privapp_permissions=/g" $BuildProp2
	sed -i "s/ro.control_privapp_permissions=disable/ro.control_privapp_permissions=/g" $BuildProp3
    sed -i "s/ro.control_privapp_permissions=disable/ro.control_privapp_permissions=/g" $BuildProp4
}

# Remove over volume alert
echo "audio.safemedia.bypass=true" >> build/baserom/images/product/etc/build.prop
echo "audio.safemedia.force=false" >> build/baserom/images/product/etc/build.prop
echo "audio.safemedia.csd.force=false" >> build/baserom/images/product/etc/build.prop

recoveryimg="$work_dir/build/baserom/images/recovery.img"
if [ -f $recoveryimg ]; then
 rm -rf $recoveryimg
else
 mods "No Found recovery.img!Skipping..."
fi

fix_themereset() {
    InitRC1=$(find $work_dir/build/baserom/images -type f -name "init.rc" 2>/dev/null | head -n 1)
    mods "Fix theme reset"
    if [ -z "$InitRC1" ]; then
        warn "Fix theme reset: không thấy init.rc - bỏ qua"
        return 0
    fi
    sed -i '/on boot/a\'$'\n''    chmod 0731 \/data\/system\/theme' "$InitRC1"
    mods "Done"
}

# Tổng kết các prop ảnh hưởng RAM để nhìn được ngay trong log build
ram_summary() {
    local p="$work_dir/build/baserom/images/system/system/build.prop"
    local p2="$work_dir/build/baserom/images/product/etc/build.prop"
    [ -f "$p" ] || return 0
    mods "---- RAM summary ----"
    for k in persist.miui.extm.enable persist.miui.extm.size \
             ro.config.low_ram ro.config.low_ram.threshold_gb \
             ro.config.low_ram.middle.threshold_gb \
             persist.sys.advanced_visual_release persist.sys.computility.cpulevel; do
        v=$(grep -m1 "^${k}=" "$p" 2>/dev/null | cut -d= -f2- | tr -d '\r\n')
        [ -z "$v" ] && v=$(grep -m1 "^${k}=" "$p2" 2>/dev/null | cut -d= -f2- | tr -d '\r\n')
        [ -n "$v" ] && mods "  $k = $v"
    done
}

disable_memory_extenstion
disable_privapp_control_enforce
disable_privapp_control_disable
fix_themereset
ram_summary