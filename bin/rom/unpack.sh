#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# bin/rom/unpack.sh - ROM zip -> build/baserom/images/<partition>/
#
#   bash bin/rom/unpack.sh [--keep-source]
#
# Ba định dạng nguồn, cùng một kết quả đầu ra:
#   payload.bin      OTA A/B của Xiaomi
#   *.new.dat.br     OTA kiểu cũ (brotli + sdat2img)
#   super.img*       bản fastboot / xiaomi.eu
#
# Nguyên tắc:
#   - Mỗi phân vùng được bung xong, KIỂM TRA thư mục không rỗng, rồi mới xoá
#     file .img của nó. Lỗi thì giữ lại để debug.
#   - Kiểu filesystem ghi RIÊNG cho từng phân vùng (build/rom/fstype/<part>).
#     Bản cũ ghi một file chung nên phân vùng sau đè phân vùng trước.
#   - zip/payload/.img bị xoá theo đúng thứ tự để đỉnh dung lượng thấp nhất;
#     zip chỉ bị xoá khi nó do ta tải về, không bao giờ xoá file của người dùng.
# ---------------------------------------------------------------------------

set -uo pipefail

ROOT=$(cd "$(dirname "$0")/../.." && pwd)
source "$ROOT/lib/log.sh"
source "$ROOT/lib/env.sh"
source "$ROOT/bin/rom/state.sh"

KEEP_SOURCE=false
for arg in "$@"; do
    case "$arg" in
        --keep-source) KEEP_SOURCE=true ;;
        -h|--help)
            sed -n '2,20p' "$0"
            exit 0
            ;;
        *) die "Tham số lạ: $arg" ;;
    esac
done

# Phân vùng CÓ filesystem: bung thành cây thư mục.
# boot / dtbo / vbmeta ... không nằm ở đây - chúng giữ nguyên dạng .img cho
# bước đóng gói và cho script flash.
FS_PARTS="system system_ext product vendor odm mi_ext system_dlkm vendor_dlkm odm_dlkm product_dlkm"
REQUIRED_PARTS="system vendor product"

as_root() {
    if [ "$(id -u)" -eq 0 ]; then "$@"; else sudo "$@"; fi
}

delete_zip() {
    if [ "$KEEP_SOURCE" = true ]; then
        info "Giữ zip theo --keep-source"
        return 0
    fi
    if [ "$(state_get rom_zip_origin)" != "download" ]; then
        info "ROM là file cục bộ - không xoá"
        return 0
    fi
    if [ -f "$ZIP" ]; then
        info "Xoá zip để lấy chỗ cho images ($(size_of "$ZIP"))"
        rm -f "$ZIP" "$ZIP.aria2"
    fi
}

# --- Nguồn: payload.bin ----------------------------------------------------
unpack_payload() {
    section "Bung payload.bin"
    local pb="$ROM_DIR/payload.bin"

    info "Tách payload.bin khỏi zip"
    unzip -o -qq "$ZIP" payload.bin -d "$ROM_DIR" || die "Không tách được payload.bin từ zip"
    require_file "$pb" "payload.bin" || exit 1

    # Xoá zip ngay: payload.bin + images cần chỗ, và payload.bin vẫn đủ để
    # bung lại nếu bước sau lỗi.
    delete_zip

    info "payload-extract -> $IMG_DIR"
    payload-extract extract -o "$IMG_DIR/" "$pb" || die "payload-extract thất bại"

    rm -f "$pb"
    info "Đã xoá payload.bin"
}

# --- Nguồn: new.dat.br -----------------------------------------------------
unpack_br() {
    section "Bung *.new.dat.br"
    local d="$ROM_DIR/br" opl parts p br tl nd

    require_cmds brotli python3 || exit 1

    rm -rf "$d"
    mkdir -p "$d"
    info "Giải nén zip -> $d"
    unzip -o -qq "$ZIP" -d "$d" || die "Không giải nén được zip"

    opl="$d/dynamic_partitions_op_list"
    require_file "$opl" "danh sách phân vùng động" || exit 1
    parts=$(awk '$1 == "add" { print $2 }' "$opl")
    [ -n "$parts" ] || die "dynamic_partitions_op_list không có dòng 'add' nào"

    delete_zip

    for p in $parts; do
        br="$d/$p.new.dat.br"
        tl="$d/$p.transfer.list"
        nd="$d/$p.new.dat"

        if [ ! -f "$br" ] || [ ! -f "$tl" ]; then
            warn "$p: thiếu .new.dat.br hoặc .transfer.list - bỏ qua"
            continue
        fi

        brotli -d -f "$br" -o "$nd" || die "brotli [$p] thất bại"
        python3 "$ROOT/bin/Linux/x86_64/sdat2img.py" "$tl" "$nd" "$IMG_DIR/$p.img" \
            || die "sdat2img [$p] thất bại"
        [ -s "$IMG_DIR/$p.img" ] || die "sdat2img [$p] tạo file rỗng"

        # Xoá ngay từng cặp: mỗi phân vùng có thể tới 8 GB khi đã giải nén.
        rm -f "$nd" "$br"
        unpack "[$p] sdat2img xong"
    done

    rm -rf "$d"
}

# --- Nguồn: super.img ------------------------------------------------------
unpack_super() {
    section "Bung super.img"
    local d="$ROM_DIR/super" first sdir cf

    rm -rf "$d"
    mkdir -p "$d"
    info "Giải nén super.img* + cust.img* từ zip"
    unzip -o -qq "$ZIP" '*super.img*' 'cust.img*' -d "$d" || die "Không giải nén được super.img"

    first=$(find "$d" -name 'super.img*' -type f | sort -V | head -n1)
    [ -n "$first" ] || die "Không thấy super.img* sau khi giải nén"
    sdir=$(dirname "$first")

    if ls "$sdir"/super.img.[0-9]* >/dev/null 2>&1; then
        info "Ghép các mảnh super.img.* bằng simg2img"
        simg2img $(ls -v "$sdir"/super.img.[0-9]*) "$ROM_DIR/super.img" \
            || die "simg2img thất bại"
    else
        mv -f "$first" "$ROM_DIR/super.img"
    fi
    require_file "$ROM_DIR/super.img" "super.img" || exit 1

    # cust.img chỉ có ở một số ROM (xiaomi.eu). Giữ bản thật nếu có.
    cf=$(find "$d" -name 'cust.img.0' -type f | head -n1)
    if [ -n "$cf" ]; then
        if simg2img $(ls -v "$(dirname "$cf")"/cust.img.[0-9]*) "$IMG_DIR/cust.img" 2>/dev/null; then
            info "cust.img: $(size_of "$IMG_DIR/cust.img")"
        else
            warn "Ghép cust.img thất bại - bỏ qua (uploadROM sẽ dùng bản mẫu)"
        fi
    fi

    delete_zip
    rm -rf "$d"

    info "Tách phân vùng bằng lpunpack"
    if exists lpunpack; then
        lpunpack "$ROM_DIR/super.img" "$IMG_DIR" || die "lpunpack thất bại"
    else
        python3 "$ROOT/bin/lpunpack.py" "$ROM_DIR/super.img" "$IMG_DIR" || die "lpunpack.py thất bại"
    fi

    rm -f "$ROM_DIR/super.img"
}

# --- Chuẩn hoá slot A/B ----------------------------------------------------
# Chỉ giữ slot A. payload-extract sinh cả system_a.img và system_b.img; slot B
# không bao giờ được sửa nên vô nghĩa với ROM mod.
normalize_slots() {
    local f
    for f in "$IMG_DIR"/*_a.img; do
        [ -f "$f" ] || continue
        mv -f "$f" "${f%_a.img}.img"
    done
    for f in "$IMG_DIR"/*_b.img; do
        [ -f "$f" ] || continue
        rm -f "$f"
    done
}

# --- Bung từng phân vùng filesystem ---------------------------------------
extract_fs() {
    local part img ftype failed=0

    mkdir -p "$ROM_DIR/fstype"

    for part in $FS_PARTS; do
        img="$IMG_DIR/$part.img"
        if [ ! -f "$img" ]; then
            debug "$part: ROM không có phân vùng này"
            continue
        fi

        ftype=$(gettype -i "$img" 2>/dev/null | tr -d '\r\n ')

        case "$ftype" in
            ext|ext4|EXT|EXT4)
                as_root python3 "$ROOT/bin/imgextractor/imgextractor.py" "$img" "$IMG_DIR" >/dev/null 2>&1 \
                    || { error "Bung ext4 [$part] thất bại"; failed=1; continue; }
                echo "EXT" > "$ROM_DIR/fstype/$part"
                ;;
            erofs|EROFS)
                extract.erofs -x -i "$img" -o "$IMG_DIR" >/dev/null 2>&1 \
                    || { error "Bung erofs [$part] thất bại"; failed=1; continue; }
                echo "EROFS" > "$ROM_DIR/fstype/$part"
                ;;
            *)
                error "Không nhận ra filesystem của $part (gettype='$ftype')"
                failed=1
                continue
                ;;
        esac

        if [ -d "$IMG_DIR/$part" ] && [ -n "$(ls -A "$IMG_DIR/$part" 2>/dev/null)" ]; then
            rm -f "$img"
            unpack "[$part] $ftype -> $(size_of "$IMG_DIR/$part")"
        else
            error "[$part] bung xong nhưng thư mục rỗng - GIỮ LẠI $img để kiểm tra"
            failed=1
        fi
    done

    [ "$failed" -eq 0 ] || die "Có phân vùng bung thất bại (xem log phía trên)"
}

verify_required() {
    local p missing="" empty=""

    for p in $REQUIRED_PARTS; do
        if [ ! -d "$IMG_DIR/$p" ]; then
            missing="$missing $p"
        elif [ -z "$(ls -A "$IMG_DIR/$p" 2>/dev/null)" ]; then
            empty="$empty $p"
        fi
    done

    if [ -n "$missing$empty" ]; then
        [ -n "$missing" ] && error "Thiếu phân vùng bắt buộc:$missing"
        [ -n "$empty" ] && error "Phân vùng rỗng:$empty"
        error "Nội dung $IMG_DIR:"
        ls -la "$IMG_DIR" >&2
        return 1
    fi

    info "Phân vùng bắt buộc đã đủ: $REQUIRED_PARTS"
    return 0
}

write_fstype() {
    local types count f p kv=""

    types=$(cat "$ROM_DIR"/fstype/* 2>/dev/null | sort -u)
    if [ -z "$types" ]; then
        warn "Không xác định được filesystem - mặc định EROFS"
        state_set fstype "EROFS"
        return 0
    fi

    count=$(printf '%s\n' "$types" | wc -l | tr -d ' ')
    if [ "$count" -gt 1 ]; then
        warn "ROM trộn filesystem: $(printf '%s ' $types)"
        # packROM.sh hiện chỉ nhận MỘT kiểu. Ghi MIXED để bước đóng gói dừng
        # với lỗi rõ ràng, thay vì đóng sai công cụ rồi ra ROM hỏng.
        state_set fstype "MIXED"
        for f in "$ROM_DIR"/fstype/*; do
            p=$(basename "$f")
            kv="$kv $p=$(cat "$f")"
        done
        state_set fstype_by_part "${kv# }"
        warn "Chi tiết: ${kv# }"
        return 0
    fi

    state_set fstype "$types"
    info "Filesystem: $types"
}

report() {
    local p fw

    section "Kết quả unpack"
    for p in $(cd "$IMG_DIR" && ls -d */ 2>/dev/null | tr -d '/'); do
        printf '    %-16s %s\n' "$p" "$(size_of "$IMG_DIR/$p")" >&2
    done

    fw=$(cd "$IMG_DIR" && ls *.img 2>/dev/null | tr '\n' ' ')
    [ -n "$fw" ] && info "Giữ dạng .img cho bước đóng gói: $fw"
    info "Cây partition: $IMG_DIR"

    state_dump
}

main() {
    state_load

    ZIP=$(state_get rom_zip) || die "Chưa có ROM trong state - chạy bin/rom/fetch.sh trước"
    ROMTYPE=$(state_get romtype) || die "Chưa biết định dạng ROM - chạy bin/rom/inspect.sh trước"

    require_file "$ZIP" "ROM zip" || exit 1
    require_free_gb 20 "$ROOT" || die "Không đủ dung lượng để bung ROM"

    mkdir -p "$IMG_DIR" "$ROM_DIR/fstype"

    case "$ROMTYPE" in
        payload) unpack_payload ;;
        br)      unpack_br ;;
        super)   unpack_super ;;
        *) die "romtype='$ROMTYPE' không hợp lệ (phải là payload|br|super)" ;;
    esac

    normalize_slots
    extract_fs
    verify_required || exit 1
    write_fstype

    state_set unpacked "1"
    state_set partitions "$(cd "$IMG_DIR" && ls -d */ 2>/dev/null | tr -d '/' | tr '\n' ' ')"
    state_emit_compat

    report
}

main "$@"
