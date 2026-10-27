#!/bin/bash
work_dir=$(pwd)
source "$work_dir/functions.sh"

FILE_JSON="$work_dir/bin/ddevice/data/devices.json"
KEY="${1:-$(cat $work_dir/bin/ddevice/device_f.txt 2>/dev/null)}"
KEY=$(echo "$KEY" | tr -d '\r\n ' | tr '[:upper:]' '[:lower:]')

REGION_TYPE=$(cat "$work_dir/bin/ddevice/device_type.txt" 2>/dev/null | tr -d '\r\n ')
IS_CHINA=0
[ "$REGION_TYPE" = "China" ] && IS_CHINA=1

# Giá trị rác hay gặp trong build.prop, không phải tên bán của máy
is_placeholder() {
  case "$(echo "$1" | tr '[:upper:]' '[:lower:]' | tr -d '\r\n ')" in
    ""|null|unknown|xiaomidevice|miui|hyperos|bugos|missi|miproduct|product|generic|phone|device) return 0 ;;
    *) return 1 ;;
  esac
}

# Tên trong devices.json có thể là nhiều alias ngăn cách bằng |:
#   China  -> REDMI -> Xiaomi -> alias đầu
#   Global -> POCO  -> Xiaomi -> alias đầu
json_pick() {
  local key="$1" val pick
  [ -f "$FILE_JSON" ] || return 0
  [ -n "$key" ] || return 0
  val=$(jq -r --arg key "$key" '.[$key] // empty' "$FILE_JSON" 2>/dev/null)
  if [ -z "$val" ] || [ "$val" = "null" ]; then
    return 0
  fi

  if [[ "$val" == *"|"* ]]; then
    if [ "$IS_CHINA" -eq 1 ]; then
      pick=$(printf '%s\n' "$val" | tr '|' '\n' | grep -i -m1 '^redmi')
      [ -z "$pick" ] && pick=$(printf '%s\n' "$val" | tr '|' '\n' | grep -i -m1 '^xiaomi')
    else
      pick=$(printf '%s\n' "$val" | tr '|' '\n' | grep -i -m1 '^poco')
      [ -z "$pick" ] && pick=$(printf '%s\n' "$val" | tr '|' '\n' | grep -i -m1 '^xiaomi')
    fi
    [ -z "$pick" ] && pick=$(printf '%s' "$val" | cut -d'|' -f1)
    val="$pick"
  fi
  printf '%s' "$val" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'
}

# Key chính xác trong devices.json (codename có thể lệch hoa/thường)
json_key() {
  local k
  k=$(grep -ix "$KEY" "$work_dir/bin/ddevice/data/devices_data.txt" 2>/dev/null | head -n 1)
  [ -z "$k" ] && k=$(grep -ix "$KEY" "$work_dir/bin/ddevice/data/pad_data.txt" 2>/dev/null | head -n 1)
  [ -z "$k" ] && k="$KEY"
  printf '%s' "$k"
}

# Đọc marketname từ build.prop của chính ROM
rom_marketname() {
  local prop val
  for prop in \
    "$work_dir/build/baserom/images/product/etc/build.prop" \
    "$work_dir/build/baserom/images/system/system/build.prop" \
    "$work_dir/build/baserom/images/system_ext/etc/build.prop" \
    "$work_dir/build/baserom/images/vendor/build.prop" \
    "$work_dir/build/baserom/images/odm/etc/build.prop"; do
    [ -f "$prop" ] || continue
    val=$(grep -E "^ro\.(product|vendor|system|odm|system_ext)\.(product\.|vendor\.|system\.|odm\.|system_ext\.)?marketname=" "$prop" 2>/dev/null \
      | head -n 1 | cut -d'=' -f2- | tr -d '\r\n' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    if [ -n "$val" ] && ! is_placeholder "$val"; then
      printf '%s' "$val"
      return 0
    fi
  done
}

# ==================== 1. LẤY TÊN MÁY TỪ CHÍNH ROM ====================
VALUE=$(rom_marketname)
SOURCE="ROM (ro.product.marketname)"

# ==================== 2. FALLBACK: devices.json ====================
JKEY=$(json_key)
if [ -z "$VALUE" ]; then
  VALUE=$(json_pick "$JKEY")
  SOURCE="devices.json [$JKEY]"
fi

# ==================== 2b. POCO không bán ở Trung Quốc ====================
# ROM China đôi khi vẫn mang marketname quốc tế (POCO) do dùng chung product tree
if [ "$IS_CHINA" -eq 1 ] && [[ "$VALUE" =~ ^[Pp][Oo][Cc][Oo] ]]; then
  ALT=$(json_pick "$JKEY")
  if [ -n "$ALT" ] && [[ ! "$ALT" =~ ^[Pp][Oo][Cc][Oo] ]]; then
    mods "Tên máy '$VALUE' là tên quốc tế nhưng ROM là China -> dùng '$ALT'"
    VALUE="$ALT"
    SOURCE="devices.json [$JKEY] (POCO -> REDMI vì ROM China)"
  fi
fi

[ -z "$VALUE" ] && VALUE="Xiaomi Device"

# ==================== 3. Cuối cùng: ro.product.model (thường là mã máy) ====================
if [ "$VALUE" = "Xiaomi Device" ]; then
  for prop in \
    "$work_dir/build/baserom/images/product/etc/build.prop" \
    "$work_dir/build/baserom/images/system/system/build.prop" \
    "$work_dir/build/baserom/images/vendor/build.prop"; do
    [ -f "$prop" ] || continue
    model_val=$(grep -m1 '^ro\.product\.model=' "$prop" 2>/dev/null | cut -d'=' -f2- | tr -d '\r\n')
    if [ -n "$model_val" ] && ! is_placeholder "$model_val"; then
      VALUE="$model_val"
      SOURCE="ROM (ro.product.model)"
      break
    fi
  done
fi

# Đồng bộ ghi ra CẢ HAI file để tránh lệch dữ liệu giữa các script
mods "Tên máy: $VALUE  <- $SOURCE"

mkdir -p "$work_dir/bin/ddevice"
echo "$VALUE" > "$work_dir/bin/ddevice/name_devices.txt"
echo "$VALUE" > "$work_dir/bin/ddevice/device_name.txt"
