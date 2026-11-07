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

# ---------------------------------------------------------------------------
# fix_hidden_launcher_icons: giữ icon "Bảo mật" và "Chủ đề" trên màn hình chính.
#
# TRIỆU CHỨNG: sau khi flash, hai app này biến mất khỏi launcher, bấm không mở
# được. Không phải do debloat (2 package vẫn còn), mà activity bị DISABLE.
#
# NGUYÊN NHÂN (đọc smali của MIUISecurityCenter 13.6.5, không đoán):
#   com.miui.common.i.<clinit>:
#       a = pr.a.a || SystemProperties.getBoolean(
#               "ro.miui.support.system.app.uninstall.v2", false)
#   pr.a.a = ro.product.mod_device chứa "_global"  -> trên annibale là false.
#   ll.b.m() "processSecurityCenterLauncherState":
#       if (mod_device global) { ...; return; }
#       if (!com.miui.common.i.a) { restore(); return; }   // không có prop -> bật
#       else { disable(MainActivity, ThemeResourceTabActivity, voiceassist) }
#   Bản đồ bị disable nằm ở ll.b.<clinit> và gồm ĐÚNG 3 activity đó — nên mất
#   icon Bảo mật KÉO THEO mất icon Chủ đề (cùng một lệnh).
#
#   Prop đó = true trong /mi_ext/etc/build.prop (dòng
#   "ro.miui.support.system.app.uninstall.v2=true") của base ROM, không phải do
#   mod nào của BugOS. Đã kiểm trên máy: đặt false bằng resetprop thì cả hai icon
#   trở lại và GIỮ nguyên sau nhiều phút (activity không bị tắt lại).
#
# Đánh đổi: mất tính năng "gỡ cài đặt app hệ thống" kiểu v2 của MIUI. Đổi lại
# icon hiện đúng như bản ROM gốc.
# ---------------------------------------------------------------------------
fix_hidden_launcher_icons() {
    local want
    want=$(grep -m1 '^keep_security_theme_icons=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
    [ "$want" = "false" ] && { mods "Launcher icons: keep_security_theme_icons=false - bỏ qua"; return 0; }

    # debloat_securitycenter=true xoá hẳn Trung tâm An toàn, nên việc "giữ icon
    # Bảo mật" thành vô nghĩa - chỉ còn icon Chủ đề. Prop vẫn phải đặt false vì
    # cùng lệnh đó cũng tắt ThemeResourceTabActivity.
    local sc_gone
    sc_gone=$(grep -m1 '^debloat_securitycenter=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
    [ "$sc_gone" = "true" ] && mods "Launcher icons: Trung tâm An toàn bị debloat - chỉ giữ icon Chủ đề"

    local prop=""
    local f
    while IFS= read -r f; do
        [ -n "$f" ] || continue
        if grep -q "ro.miui.support.system.app.uninstall.v2" "$f" 2>/dev/null; then
            prop="$f"
            break
        fi
    done < <(find "$work_dir/build/baserom/images" -maxdepth 4 -type f -name "build.prop" 2>/dev/null)
    if [ -z "$prop" ]; then
        warn "Launcher icons: không thấy prop uninstall.v2 trong images - bỏ qua"
        return 0
    fi

    sed -i 's|^ro\.miui\.support\.system\.app\.uninstall\.v2=.*|ro.miui.support.system.app.uninstall.v2=false|' "$prop"
    mods "Launcher icons: ${prop#$work_dir/build/baserom/images/} -> uninstall.v2=false (giữ icon Bảo mật + Chủ đề)"
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
fix_hidden_launcher_icons
ram_summary