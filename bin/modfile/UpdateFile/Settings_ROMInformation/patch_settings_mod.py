#!/usr/bin/env python3
"""Gắn mục Toolbox vào Settings ngay bên dưới 'Thiết bị của tôi' (My Device).

Áp dụng cho:
  1. res/xml/settings_headers.xml:
     Chèn <header> cho mục Toolbox ngay sau <header ... id="@id/my_device" ...>
     với Intent mở com.khai.roottoolbox / com.khai.roottoolbox.MainActivity.

  2. res/xml/top_level_settings*.xml:
     Chèn <HomepagePreference> cho mục Toolbox ngay sau top_level_about_device
     với Intent mở com.khai.roottoolbox / com.khai.roottoolbox.MainActivity.

An toàn tuyệt đối:
  - KHÔNG can thiệp smali của Settings.apk (tránh tràn 64K methods).
  - KHÔNG can thiệp AndroidManifest.xml hay thêm Provider vào Settings.apk.
  - KHÔNG can thiệp ids.xml hay public.xml của Settings.apk.
  - Settings.apk giữ nguyên 100% tính toàn vẹn, không bao giờ bị crash khi mở.
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
    """Gắn header Toolbox vào settings_headers.xml ngay dưới my_device."""
    content = read_file(file_path)
    if not content:
        return False

    if "com.khai.roottoolbox" in content:
        return True

    # Gỡ bỏ các thẻ cũ (nếu có)
    content = re.sub(
        r'\s*<header\b[^>]*?android:id="@\+?id/mod_settings"[^>]*?(?:/>|>.*?</header>)',
        '',
        content,
        flags=re.S
    )
    content = re.sub(
        r'\s*<header\b[^>]*?android:targetClass="com\.android\.settings\.mod\.BugOSModActivity"[^>]*?.*?</header>',
        '',
        content,
        flags=re.S
    )

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
        '\n          android:title="Toolbox">'
        '\n    <intent android:targetPackage="com.khai.roottoolbox"'
        '\n            android:targetClass="com.khai.roottoolbox.MainActivity" />'
        '\n  </header>'
    )

    insert_pos = match.end()
    new_content = content[:insert_pos] + mod_header + content[insert_pos:]

    if write_file_validated(file_path, new_content):
        print(f"  [OK] Đã gắn Intent mở Toolbox vào {os.path.basename(file_path)}")
        return True
    return False


def patch_top_level_settings(file_path):
    """Gắn Preference Toolbox có Intent vào top_level_settings*.xml."""
    content = read_file(file_path)
    if not content:
        return False

    if "com.khai.roottoolbox" in content:
        return True

    # Gỡ bỏ các thẻ cũ (nếu có)
    content = re.sub(
        r'\s*<com\.android\.settings\.widget\.HomepagePreference\b[^>]*?android:targetClass="com\.android\.settings\.mod\.BugOSModActivity"[^>]*?.*?</com\.android\.settings\.widget\.HomepagePreference>',
        '',
        content,
        flags=re.S
    )
    content = re.sub(
        r'\s*<com\.android\.settings\.widget\.HomepagePreference\b[^>]*?android:key="top_level_mod_settings"[^>]*?(?:/>|>.*?</com\.android\.settings\.widget\.HomepagePreference>)',
        '',
        content,
        flags=re.S
    )
    content = re.sub(
        r'\s*<com\.android\.settings\.widget\.HomepagePreference\b[^>]*?android:key="top_level_toolbox"[^>]*?(?:/>|>.*?</com\.android\.settings\.widget\.HomepagePreference>)',
        '',
        content,
        flags=re.S
    )

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
        '\n                          android:title="Toolbox"'
        '\n                          android:order="-9">'
        '\n        <intent android:targetPackage="com.khai.roottoolbox"'
        '\n                android:targetClass="com.khai.roottoolbox.MainActivity" />'
        '\n    </com.android.settings.widget.HomepagePreference>'
    )

    insert_pos = match.end()
    new_content = content[:insert_pos] + mod_pref + content[insert_pos:]

    if write_file_validated(file_path, new_content):
        print(f"  [OK] Đã gắn Intent mở Toolbox vào {os.path.basename(file_path)}")
        return True
    return False


def main():
    if len(sys.argv) < 2:
        print("Usage: patch_settings_mod.py <decoded_apk_dir>")
        return 1

    out_dir = sys.argv[1]
    if not os.path.isdir(out_dir):
        print(f"Thư mục không tồn tại: {out_dir}", file=sys.stderr)
        return 1

    print("Settings: Gắn mục Toolbox vào menu Settings...")

    # Duyệt và gắn vào settings_headers*.xml và top_level_settings*.xml
    for root, _, files in os.walk(out_dir):
        for fn in files:
            if fn.startswith("settings_headers") and fn.endswith(".xml"):
                full_p = os.path.join(root, fn)
                patch_settings_headers(full_p)
            elif fn.startswith("top_level_settings") and fn.endswith(".xml"):
                full_p = os.path.join(root, fn)
                patch_top_level_settings(full_p)

    print("Settings: Gắn mục Toolbox hoàn tất (an toàn, không can thiệp DEX).")
    return 0


if __name__ == "__main__":
    sys.exit(main())
