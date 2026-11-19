#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# lib/env.sh - đường dẫn chuẩn + kiểm tra môi trường build.
#
# Source SAU lib/log.sh. Không cài package (đó là việc của setup.sh): thiếu gì
# thì báo đúng tên rồi để script gọi dừng, không tự chạy apt giữa build.
# ---------------------------------------------------------------------------

if [ -z "${BUGOS_ROOT:-}" ]; then
    BUGOS_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
fi
export BUGOS_ROOT

# --- Đường dẫn -------------------------------------------------------------
export DEVICE_DIR="$BUGOS_ROOT/bin/ddevice"       # file trạng thái cho mod cũ
export BUILD_DIR="$BUGOS_ROOT/build"
export ROM_DIR="$BUILD_DIR/rom"                   # zip, payload, state
export IMG_DIR="$BUILD_DIR/baserom/images"        # cây partition đã bung
export STATE_FILE="$ROM_DIR/state.env"            # state của stage tải/unpack
export ROM_ZIP="$ROM_DIR/base.zip"                # tên zip CỐ ĐỊNH
export OTA_METADATA="$ROM_DIR/ota_metadata.txt"   # META-INF/com/android/metadata

# --- Tool của repo lên trước PATH hệ thống ---------------------------------
_bugos_plat="$BUGOS_ROOT/bin/$(uname)/$(uname -m)"
case ":$PATH:" in
    *":$_bugos_plat:"*) ;;
    *) PATH="$_bugos_plat:$PATH" ;;
esac
export PATH
unset _bugos_plat

# Không có thư mục tool nghĩa là kiến trúc lạ (vd runner arm64) hoặc repo thiếu
# binary - build chắc chắn gãy ở bước sau, báo ngay tại đây.
env_check_platform() {
    local dir="$BUGOS_ROOT/bin/$(uname)/$(uname -m)"
    if [ ! -d "$dir" ]; then
        error "Không có thư mục tool cho $(uname)/$(uname -m): $dir"
        error "Repo chỉ đóng gói binary cho Linux x86_64."
        return 1
    fi
    return 0
}

# Xoá sạch sản phẩm build cũ. Chỉ đụng build/ và out/ - không xoá file lạ nào.
env_prepare() {
    rm -rf "$BUILD_DIR" "$BUGOS_ROOT/out"
    mkdir -p "$ROM_DIR" "$IMG_DIR" "$BUGOS_ROOT/out"
}

# Sau khi clone/giải nén trên Windows, bit thực thi có thể mất.
env_fix_perms() {
    chmod -R a+rX "$BUGOS_ROOT/bin" 2>/dev/null || true
    chmod a+x "$BUGOS_ROOT"/bin/Linux/x86_64/* 2>/dev/null || true
}

env_require_tools() {
    # Tool hệ thống: setup.sh cài, ở đây chỉ kiểm.
    local system=(unzip zip 7z java python3 zstd bc xmlstarlet aapt zipalign)
    # Binary đóng trong repo, phải tồn tại và chạy được.
    local repo=(payload-extract extract.erofs lpunpack lpmake simg2img mkfs.erofs make_ext4fs gettype magiskboot)
    local missing=() t

    for t in "${system[@]}"; do
        exists "$t" || missing+=("$t")
    done
    for t in "${repo[@]}"; do
        [ -x "$BUGOS_ROOT/bin/Linux/x86_64/$t" ] || missing+=("$t (repo)")
    done

    if [ ${#missing[@]} -gt 0 ]; then
        error "Thiếu: ${missing[*]}"
        error "Chạy: sudo bash setup.sh"
        return 1
    fi
    return 0
}

env_require_java() {
    local v
    v=$(java -version 2>&1 | awk -F'"' '/version/ {print $2; exit}')
    if [ -z "$v" ]; then
        error "Không đọc được phiên bản Java (java -version thất bại)"
        return 1
    fi
    case "$v" in
        1.8*|9*|1[0-6]*)
            error "Java $v quá cũ - apke.jar cần Java >= 17"
            return 1
            ;;
    esac
    debug "Java $v"
    return 0
}
