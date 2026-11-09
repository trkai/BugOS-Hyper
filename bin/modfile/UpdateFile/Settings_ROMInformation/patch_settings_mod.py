#!/usr/bin/env python3
"""Thêm mục 'Mod' vào Settings ngay bên dưới 'Thiết bị của tôi' (My Device).

Áp dụng cho:
  1. res/xml/settings_headers.xml:
     Chèn <header> cho mục Mod ngay sau <header ... id="@id/my_device" ...>
     (giao diện chính của HyperOS/MIUI trên điện thoại).

  2. res/xml/top_level_settings*.xml:
     Chèn <HomepagePreference> cho mục Mod ngay sau top_level_about_device
     (giao diện dạng dashboard/AOSP/Expressive).

Tận dụng style, component, icon và cơ chế điều hướng có sẵn của Miuix:
  - Icon: @drawable/ic_other_advanced_settings (bộ icon hệ thống chuẩn MIUI/HyperOS).
  - Title: 'Mod'.
  - Id/Key: mod_settings / top_level_mod_settings.
  - Tự động kế thừa: bo góc thẻ, hiệu ứng nhấn Folme, font chữ, khoảng cách.
  - Không gán action/fragment để tránh crash, click có hiệu ứng nhấn nhưng chưa chạy gì.
"""

import os
import re
import sys
import xml.etree.ElementTree as ET


def read_file(path):
    try:
        with open(path, "r", encoding="utf-8", errors="replace") as f:
            return f.read()
    except OSError:
        return ""


def write_file_validated(path, content):
    """Kiểm tra cú pháp XML hợp lệ trước khi ghi đè."""
    try:
        ET.fromstring(content)
    except Exception as e:
        print(f"  [ERROR] XML không hợp lệ sau khi sửa {path}: {e}", file=sys.stderr)
        return False
    with open(path, "w", encoding="utf-8", newline="\n") as f:
        f.write(content)
    return True


def patch_settings_headers(file_path):
    content = read_file(file_path)
    if not content:
        return False

    if 'mod_settings' in content:
        print(f"  [INFO] {os.path.basename(file_path)}: Mục 'Mod' đã tồn tại sẵn")
        return True

    # Tìm vị trí đóng thẻ header của my_device
    # Hỗ trợ cả tự đóng <header ... /> lẫn thẻ đóng <header ...>...</header>
    pattern = re.compile(
        r'(<header\b[^>]*?(?:android:id="@\+?id/my_device"|android:title="@string/my_device")[^>]*?(?:/>|>.*?</header>))',
        re.S
    )
    match = pattern.search(content)
    if not match:
        print(f"  [WARN] {os.path.basename(file_path)}: Không tìm thấy header my_device")
        return False

    mod_header = (
        '\n  <header android:icon="@drawable/ic_other_advanced_settings"'
        '\n          android:id="@+id/mod_settings"'
        '\n          android:title="Mod" />'
    )

    insert_pos = match.end()
    new_content = content[:insert_pos] + mod_header + content[insert_pos:]

    if write_file_validated(file_path, new_content):
        print(f"  [OK] Đã thêm mục 'Mod' vào {os.path.basename(file_path)} ngay dưới my_device")
        return True
    return False


def patch_top_level_settings(file_path):
    content = read_file(file_path)
    if not content:
        return False

    if 'top_level_mod_settings' in content:
        print(f"  [INFO] {os.path.basename(file_path)}: Mục 'Mod' đã tồn tại sẵn")
        return True

    pattern = re.compile(
        r'(<(?:com\.android\.settings\.widget\.(?:HomepagePreference|RestrictedHomepagePreference)|Preference)\b[^>]*?android:key="top_level_about_(?:device|phone)"[^>]*?(?:/>|>.*?</[^>]+>))',
        re.S
    )
    match = pattern.search(content)
    if not match:
        print(f"  [WARN] {os.path.basename(file_path)}: Không tìm thấy top_level_about_device")
        return False

    mod_pref = (
        '\n    <com.android.settings.widget.HomepagePreference android:icon="@drawable/ic_other_advanced_settings"'
        '\n                          android:title="Mod"'
        '\n                          android:key="top_level_mod_settings"'
        '\n                          android:order="-9" />'
    )

    insert_pos = match.end()
    new_content = content[:insert_pos] + mod_pref + content[insert_pos:]

    if write_file_validated(file_path, new_content):
        print(f"  [OK] Đã thêm mục 'Mod' vào {os.path.basename(file_path)} ngay dưới top_level_about_device")
        return True
    return False


def ensure_id_in_ids_xml(root_dir):
    """Đảm bảo mod_settings được khai báo trong ids.xml nếu file có tồn tại."""
    for root, _, files in os.walk(root_dir):
        if "ids.xml" in files:
            p = os.path.join(root, "ids.xml")
            c = read_file(p)
            if c and "mod_settings" not in c:
                idx = c.rfind("</resources>")
                if idx != -1:
                    item = '    <item type="id" name="mod_settings" />\n'
                    new_c = c[:idx] + item + c[idx:]
                    if write_file_validated(p, new_c):
                        print(f"  [OK] Đã thêm ID 'mod_settings' vào {p}")


def main():
    if len(sys.argv) < 2:
        print("Usage: patch_settings_mod.py <decoded_apk_dir>")
        return 1

    root_dir = sys.argv[1]
    if not os.path.isdir(root_dir):
        print(f"Thư mục không tồn tại: {root_dir}", file=sys.stderr)
        return 1

    patched_any = False

    # 1. Quét mọi file settings_headers*.xml
    for root, _, files in os.walk(root_dir):
        for fn in files:
            if fn.startswith("settings_headers") and fn.endswith(".xml"):
                full_p = os.path.join(root, fn)
                if patch_settings_headers(full_p):
                    patched_any = True

            elif fn.startswith("top_level_settings") and fn.endswith(".xml"):
                full_p = os.path.join(root, fn)
                if patch_top_level_settings(full_p):
                    patched_any = True

    # 2. Khai báo ID an toàn
    ensure_id_in_ids_xml(root_dir)

    if patched_any:
        print("Settings: Hoàn tất chèn mục 'Mod' vào Settings UI")
        return 0
    else:
        print("Settings: Không tìm thấy file XML Settings nào phù hợp để chèn mục 'Mod'", file=sys.stderr)
        return 0


if __name__ == "__main__":
    sys.exit(main())
