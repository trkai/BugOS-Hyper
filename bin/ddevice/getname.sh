#!/bin/bash
work_dir=$(pwd)
source $work_dir/functions.sh

FILE_JSON="$work_dir/bin/ddevice/data/devices.json"
KEY="${1:-$(cat $work_dir/bin/ddevice/device_f.txt 2>/dev/null)}"
KEY=$(echo "$KEY" | tr -d '\r\n ' | tr '[:upper:]' '[:lower:]')

REGION_TYPE=$(cat "$work_dir/bin/ddevice/device_type.txt" 2>/dev/null | tr -d '\r\n ')

# Giá trị rác hay gặp trong build.prop, không phải tên bán của máy
is_placeholder() {
  case "$(echo "$1" | tr '[:upper:]' '[:lower:]' | tr -d '\r\n ')" in
    ""|null|unknown|xiaomidevice|miui|hyperos|bugos|missi|miproduct|product|generic|phone|device) return 0 ;;
    *) return 1 ;;
  esac
}

# ==================== 1. LẤY TÊN MÁY TỪ CHÍNH ROM ====================
# marketname là tên thương mại Xiaomi ghi trong ROM (China -> tên nội địa, Global -> tên quốc tế)
VALUE=""
for prop in \
  "$work_dir/build/baserom/images/product/etc/build.prop" \
  "$work_dir/build/baserom/images/system/system/build.prop" \
  "$work_dir/build/baserom/images/system_ext/etc/build.prop" \
  "$work_dir/build/baserom/images/vendor/build.prop" \
  "$work_dir/build/baserom/images/odm/etc/build.prop"; do
  [ -f "$prop" ] || continue
  prop_val=$(grep -E "^(ro\.product\.(product\.|vendor\.|system\.|odm\.)?marketname)=" "$prop" 2>/dev/null \
    | head -n 1 | cut -d'=' -f2- | tr -d '\r\n')
  if [ -n "$prop_val" ] && ! is_placeholder "$prop_val"; then
    VALUE="$prop_val"
    break
  fi
done

# ==================== 2. FALLBACK: devices.json ====================
if [ -z "$VALUE" ]; then
  EXACT_KEY=$(grep -ix "$KEY" "$work_dir/bin/ddevice/data/devices_data.txt" 2>/dev/null | head -n 1)
  [ -z "$EXACT_KEY" ] && EXACT_KEY=$(grep -ix "$KEY" "$work_dir/bin/ddevice/data/pad_data.txt" 2>/dev/null | head -n 1)
  [ -z "$EXACT_KEY" ] && EXACT_KEY="$KEY"

  if [ -f "$FILE_JSON" ] && [ -n "$EXACT_KEY" ]; then
    JSON_VALUE=$(jq -r --arg key "$EXACT_KEY" '.[$key] // empty' "$FILE_JSON" 2>/dev/null)
  fi

  # Nhiều alias ngăn cách bằng | -> chọn theo region:
  #   China  -> REDMI -> Xiaomi -> tên đầu
  #   Global -> POCO  -> Xiaomi -> tên đầu
  if [[ "$JSON_VALUE" == *"|"* ]]; then
    if [[ "$REGION_TYPE" == "China" ]]; then
      PICK=$(echo "$JSON_VALUE" | tr '|' '\n' | grep -i -m1 '^redmi')
      [ -z "$PICK" ] && PICK=$(echo "$JSON_VALUE" | tr '|' '\n' | grep -i -m1 '^xiaomi')
    else
      PICK=$(echo "$JSON_VALUE" | tr '|' '\n' | grep -i -m1 '^poco')
      [ -z "$PICK" ] && PICK=$(echo "$JSON_VALUE" | tr '|' '\n' | grep -i -m1 '^xiaomi')
    fi
    [ -z "$PICK" ] && PICK=$(echo "$JSON_VALUE" | cut -d'|' -f1)
    VALUE=$(echo "$PICK" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
  elif [ -n "$JSON_VALUE" ] && [ "$JSON_VALUE" != "null" ]; then
    VALUE="$JSON_VALUE"
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
      break
    fi
  done
fi

# Đồng bộ ghi ra CẢ HAI file để tránh lệch dữ liệu giữa các script
mkdir -p "$work_dir/bin/ddevice"
echo "$VALUE" > "$work_dir/bin/ddevice/name_devices.txt"
echo "$VALUE" > "$work_dir/bin/ddevice/device_name.txt"
