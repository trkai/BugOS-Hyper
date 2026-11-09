#!/usr/bin/env python3
"""Tích hợp toàn bộ BugOS Toolbox vào Settings -> Mod (Settings.apk).

Thực hiện:
  1. Trích xuất 2 asset (sukisu_ultra.apk, ZygiskNext+AlwaysStrongInject.zip)
     từ bin/package/RootToolbox/RootToolbox.apk vào <out>/root/assets/.
  2. Sao chép các file smali (BugOSModActivity, ToolboxFileProvider) vào
     <out>/smali/classes/com/android/settings/mod/.
  3. Tạo giao diện activity_bugos_mod.xml với phong cách Settings/Miuix bo góc.
  4. Tạo các drawable bo góc có mask ripple chống vệt mờ vuông:
     - bg_mod_card.xml
     - bg_mod_btn_primary.xml
     - bg_mod_btn_outline.xml
  5. Tạo màu sắc tương thích Light/Dark mode (values và values-night).
  6. Khai báo Activity, Provider, queries và permission trong AndroidManifest.xml.
  7. Cập nhật settings_headers.xml và top_level_settings*.xml với Intent mở Mod.
"""

import os
import re
import shutil
import sys
import xml.etree.ElementTree as ET
import zipfile


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


def copy_assets_to_apk(work_dir, out_dir):
    """Trích xuất 2 asset cần thiết vào <out>/root/assets/."""
    target_assets = os.path.join(out_dir, "root", "assets")
    os.makedirs(target_assets, exist_ok=True)

    toolbox_apk = os.path.join(work_dir, "bin", "package", "RootToolbox", "RootToolbox.apk")
    if not os.path.isfile(toolbox_apk):
        # Fallback check
        alt_apk = r"C:\Users\Khai\Downloads\toolbox\RootToolbox.apk"
        if os.path.isfile(alt_apk):
            toolbox_apk = alt_apk

    if os.path.isfile(toolbox_apk):
        try:
            with zipfile.ZipFile(toolbox_apk, "r") as z:
                for item in z.namelist():
                    if item.startswith("assets/"):
                        fn = os.path.basename(item)
                        if not fn:
                            continue
                        dest = os.path.join(target_assets, fn)
                        if not os.path.isfile(dest) or os.path.getsize(dest) == 0:
                            with z.open(item) as src, open(dest, "wb") as dst:
                                shutil.copyfileobj(src, dst)
                            print(f"  [OK] Đã trích xuất asset {fn} ({os.path.getsize(dest)} byte)")
        except Exception as e:
            print(f"  [WARN] Trích xuất asset thất bại: {e}", file=sys.stderr)
    else:
        print(f"  [WARN] Không tìm thấy file {toolbox_apk} để lấy asset", file=sys.stderr)


def copy_smali_to_apk(src_dir, out_dir):
    """Sao chép các file smali vào <out>/smali/classes/com/android/settings/mod/."""
    smali_src = os.path.join(src_dir, "smali", "com", "android", "settings", "mod")
    if not os.path.isdir(smali_src):
        print(f"  [WARN] Không thấy thư mục smali nguồn: {smali_src}", file=sys.stderr)
        return

    # Tìm thư mục smali trong out (ưu tiên classes, nếu không thì classes2/...)
    smali_target_base = os.path.join(out_dir, "smali", "classes")
    if not os.path.isdir(smali_target_base):
        # Tìm bất kỳ thư mục classes nào
        smali_root = os.path.join(out_dir, "smali")
        if os.path.isdir(smali_root):
            cand = [os.path.join(smali_root, d) for d in os.listdir(smali_root) if d.startswith("classes")]
            if cand:
                smali_target_base = cand[0]

    dest_dir = os.path.join(smali_target_base, "com", "android", "settings", "mod")
    os.makedirs(dest_dir, exist_ok=True)

    copied = 0
    for fn in os.listdir(smali_src):
        if fn.endswith(".smali"):
            src_f = os.path.join(smali_src, fn)
            dst_f = os.path.join(dest_dir, fn)
            shutil.copy2(src_f, dst_f)
            copied += 1
    print(f"  [OK] Đã sao chép {copied} file smali vào {dest_dir}")


def setup_resources(out_dir):
    """Tạo layout, drawable và color tương thích chuẩn HyperOS Miuix."""
    res_root = os.path.join(out_dir, "resources", "package_1", "res")
    if not os.path.isdir(res_root):
        # Tìm thư mục res thực tế
        for root, dirs, _ in os.walk(out_dir):
            if os.path.basename(root) == "res" and "drawable" in dirs:
                res_root = root
                break

    layout_dir = os.path.join(res_root, "layout")
    drawable_dir = os.path.join(res_root, "drawable")
    values_dir = os.path.join(res_root, "values")
    values_night_dir = os.path.join(res_root, "values-night")

    os.makedirs(layout_dir, exist_ok=True)
    os.makedirs(drawable_dir, exist_ok=True)
    os.makedirs(values_dir, exist_ok=True)
    os.makedirs(values_night_dir, exist_ok=True)

    # 1. Layout activity_bugos_mod.xml
    layout_content = '''<?xml version="1.0" encoding="utf-8"?>
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="?android:attr/colorBackground"
    android:fillViewport="true">

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="vertical"
        android:paddingStart="16dp"
        android:paddingEnd="16dp"
        android:paddingTop="16dp"
        android:paddingBottom="36dp">

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="vertical"
            android:background="@drawable/bg_mod_card"
            android:padding="20dp"
            android:layout_marginBottom="16dp">

            <TextView
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:text="01"
                android:textSize="13sp"
                android:textStyle="bold"
                android:textColor="#1BA784" />

            <TextView
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_marginTop="4dp"
                android:text="Cài đặt SukiSU Ultra"
                android:textSize="17sp"
                android:textStyle="bold"
                android:textColor="?android:attr/textColorPrimary" />

            <TextView
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_marginTop="4dp"
                android:layout_marginBottom="18dp"
                android:text="Cài đặt trình quản lý SukiSU Ultra để cấp quyền root cho kernel."
                android:textSize="13sp"
                android:textColor="?android:attr/textColorSecondary" />

            <Button
                android:id="@+id/btn_install"
                android:layout_width="match_parent"
                android:layout_height="48dp"
                android:background="@drawable/bg_mod_btn_primary"
                android:text="Cài đặt"
                android:textColor="#FFFFFF"
                android:textSize="15sp"
                android:textStyle="bold"
                android:textAllCaps="false"
                android:stateListAnimator="@null" />

            <Button
                android:id="@+id/btn_open_sukisu"
                android:layout_width="match_parent"
                android:layout_height="48dp"
                android:layout_marginTop="10dp"
                android:background="@drawable/bg_mod_btn_outline"
                android:text="Mở SukiSU Ultra"
                android:textColor="#1BA784"
                android:textSize="15sp"
                android:textStyle="bold"
                android:textAllCaps="false"
                android:visibility="gone"
                android:stateListAnimator="@null" />
        </LinearLayout>

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="vertical"
            android:background="@drawable/bg_mod_card"
            android:padding="20dp">

            <TextView
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:text="02"
                android:textSize="13sp"
                android:textStyle="bold"
                android:textColor="#1BA784" />

            <TextView
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_marginTop="4dp"
                android:text="Flash Module có sẵn"
                android:textSize="17sp"
                android:textStyle="bold"
                android:textColor="?android:attr/textColorPrimary" />

            <TextView
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_marginTop="4dp"
                android:text="SukiSU hỏi xác nhận, rồi vào màn hình flash."
                android:textSize="13sp"
                android:textColor="?android:attr/textColorSecondary" />

            <TextView
                android:id="@+id/tv_step2_status"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_marginTop="6dp"
                android:layout_marginBottom="18dp"
                android:text="Bật chức năng 1 trước đã."
                android:textSize="13sp"
                android:textColor="#FF5252" />

            <Button
                android:id="@+id/btn_flash"
                android:layout_width="match_parent"
                android:layout_height="48dp"
                android:background="@drawable/bg_mod_btn_primary"
                android:text="Flash module"
                android:textColor="#FFFFFF"
                android:textSize="15sp"
                android:textStyle="bold"
                android:textAllCaps="false"
                android:enabled="false"
                android:stateListAnimator="@null" />
        </LinearLayout>
    </LinearLayout>
</ScrollView>
'''
    write_file_validated(os.path.join(layout_dir, "activity_bugos_mod.xml"), layout_content)

    # 2. bg_mod_card.xml
    card_drawable = '''<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="rectangle">
    <solid android:color="@color/mod_card_bg" />
    <corners android:radius="18dp" />
    <stroke android:width="1dp" android:color="@color/mod_card_stroke" />
</shape>
'''
    write_file_validated(os.path.join(drawable_dir, "bg_mod_card.xml"), card_drawable)

    # 3. bg_mod_btn_primary.xml (Ripple with mask corners to avoid square bleed)
    btn_primary = '''<?xml version="1.0" encoding="utf-8"?>
<ripple xmlns:android="http://schemas.android.com/apk/res/android"
    android:color="#33FFFFFF">
    <item android:id="@android:id/mask">
        <shape android:shape="rectangle">
            <corners android:radius="24dp" />
            <solid android:color="#FFFFFF" />
        </shape>
    </item>
    <item>
        <selector>
            <item android:state_enabled="false">
                <shape android:shape="rectangle">
                    <solid android:color="@color/mod_btn_disabled" />
                    <corners android:radius="24dp" />
                </shape>
            </item>
            <item android:state_pressed="true">
                <shape android:shape="rectangle">
                    <solid android:color="@color/mod_teal_pressed" />
                    <corners android:radius="24dp" />
                </shape>
            </item>
            <item>
                <shape android:shape="rectangle">
                    <solid android:color="@color/mod_teal_primary" />
                    <corners android:radius="24dp" />
                </shape>
            </item>
        </selector>
    </item>
</ripple>
'''
    write_file_validated(os.path.join(drawable_dir, "bg_mod_btn_primary.xml"), btn_primary)

    # 4. bg_mod_btn_outline.xml
    btn_outline = '''<?xml version="1.0" encoding="utf-8"?>
<ripple xmlns:android="http://schemas.android.com/apk/res/android"
    android:color="#221BA784">
    <item android:id="@android:id/mask">
        <shape android:shape="rectangle">
            <corners android:radius="24dp" />
            <solid android:color="#FFFFFF" />
        </shape>
    </item>
    <item>
        <selector>
            <item android:state_pressed="true">
                <shape android:shape="rectangle">
                    <solid android:color="@color/mod_outline_pressed" />
                    <stroke android:width="1.5dp" android:color="@color/mod_outline_stroke" />
                    <corners android:radius="24dp" />
                </shape>
            </item>
            <item>
                <shape android:shape="rectangle">
                    <solid android:color="@color/mod_outline_bg" />
                    <stroke android:width="1dp" android:color="@color/mod_outline_stroke" />
                    <corners android:radius="24dp" />
                </shape>
            </item>
        </selector>
    </item>
</ripple>
'''
    write_file_validated(os.path.join(drawable_dir, "bg_mod_btn_outline.xml"), btn_outline)

    # 5. bugos_mod_colors.xml (Light)
    colors_light = '''<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="mod_card_bg">#FFFFFF</color>
    <color name="mod_card_stroke">#EAEAEA</color>
    <color name="mod_teal_primary">#1BA784</color>
    <color name="mod_teal_pressed">#158569</color>
    <color name="mod_btn_disabled">#CCCCCC</color>
    <color name="mod_outline_bg">#F7FBF9</color>
    <color name="mod_outline_pressed">#E8F4F0</color>
    <color name="mod_outline_stroke">#1BA784</color>
</resources>
'''
    write_file_validated(os.path.join(values_dir, "bugos_mod_colors.xml"), colors_light)

    # 6. bugos_mod_colors.xml (Night / Dark)
    colors_dark = '''<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="mod_card_bg">#242424</color>
    <color name="mod_card_stroke">#333333</color>
    <color name="mod_teal_primary">#1BA784</color>
    <color name="mod_teal_pressed">#158569</color>
    <color name="mod_btn_disabled">#383838</color>
    <color name="mod_outline_bg">#1F2926</color>
    <color name="mod_outline_pressed">#283833</color>
    <color name="mod_outline_stroke">#1BA784</color>
</resources>
'''
    write_file_validated(os.path.join(values_night_dir, "bugos_mod_colors.xml"), colors_dark)

    # 7. IDs registration in ids.xml
    ids_xml = os.path.join(values_dir, "ids.xml")
    if os.path.isfile(ids_xml):
        c = read_file(ids_xml)
        for id_name in ["btn_install", "btn_open_sukisu", "tv_step2_status", "btn_flash", "mod_settings", "top_level_mod_settings"]:
            if id_name not in c:
                idx = c.rfind("</resources>")
                if idx != -1:
                    item = f'    <item type="id" name="{id_name}" />\n'
                    c = c[:idx] + item + c[idx:]
        write_file_validated(ids_xml, c)

    print("  [OK] Đã thiết lập toàn bộ tài nguyên UI cho Mod")


def patch_manifest(manifest_path):
    """Đăng ký Activity, Provider, queries và permission trong AndroidManifest.xml."""
    content = read_file(manifest_path)
    if not content:
        return False

    if "com.android.settings.mod.BugOSModActivity" in content:
        return True

    # 1. uses-permission
    if "REQUEST_INSTALL_PACKAGES" not in content:
        idx = content.find("<application")
        if idx != -1:
            perm = '    <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />\n'
            content = content[:idx] + perm + content[idx:]

    # 2. queries package com.sukisu.ultra
    if "com.sukisu.ultra" not in content:
        q_idx = content.find("</queries>")
        if q_idx != -1:
            pkg_tag = '        <package android:name="com.sukisu.ultra" />\n'
            content = content[:q_idx] + pkg_tag + content[q_idx:]
        else:
            app_idx = content.find("<application")
            if app_idx != -1:
                q_tag = '    <queries>\n        <package android:name="com.sukisu.ultra" />\n    </queries>\n'
                content = content[:app_idx] + q_tag + content[app_idx:]

    # 3. activity & provider inside <application>
    app_close = content.rfind("</application>")
    if app_close != -1:
        mod_components = (
            '        <activity android:name="com.android.settings.mod.BugOSModActivity"\n'
            '                  android:label="Mod"\n'
            '                  android:exported="true"\n'
            '                  android:configChanges="orientation|screenSize" />\n'
            '        <provider android:name="com.android.settings.mod.ToolboxFileProvider"\n'
            '                  android:authorities="com.android.settings.mod.fileprovider"\n'
            '                  android:exported="false"\n'
            '                  android:grantUriPermissions="true" />\n'
        )
        content = content[:app_close] + mod_components + content[app_close:]

    if write_file_validated(manifest_path, content):
        print(f"  [OK] Đã đăng ký Activity và Provider vào {os.path.basename(manifest_path)}")
        return True
    return False


def patch_settings_headers(file_path):
    """Gắn header Mod có Intent vào settings_headers.xml ngay dưới my_device."""
    content = read_file(file_path)
    if not content:
        return False

    if "com.android.settings.mod.BugOSModActivity" in content:
        return True

    # Gỡ bỏ thẻ cũ nếu chưa có Intent
    content = re.sub(
        r'\s*<header\b[^>]*?android:id="@\+?id/mod_settings"[^>]*?(?:/>|>.*?</header>)',
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
        '\n          android:id="@+id/mod_settings"'
        '\n          android:title="Mod">'
        '\n    <intent android:targetPackage="com.android.settings"'
        '\n            android:targetClass="com.android.settings.mod.BugOSModActivity" />'
        '\n  </header>'
    )

    insert_pos = match.end()
    new_content = content[:insert_pos] + mod_header + content[insert_pos:]

    if write_file_validated(file_path, new_content):
        print(f"  [OK] Đã gắn Intent mở Mod vào {os.path.basename(file_path)}")
        return True
    return False


def patch_top_level_settings(file_path):
    """Gắn Preference Mod có Intent vào top_level_settings*.xml."""
    content = read_file(file_path)
    if not content:
        return False

    if "com.android.settings.mod.BugOSModActivity" in content:
        return True

    content = re.sub(
        r'\s*<com\.android\.settings\.widget\.HomepagePreference\b[^>]*?android:key="top_level_mod_settings"[^>]*?(?:/>|>.*?</com\.android\.settings\.widget\.HomepagePreference>)',
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
        '\n                          android:title="Mod"'
        '\n                          android:key="top_level_mod_settings"'
        '\n                          android:order="-9">'
        '\n        <intent android:targetPackage="com.android.settings"'
        '\n                android:targetClass="com.android.settings.mod.BugOSModActivity" />'
        '\n    </com.android.settings.widget.HomepagePreference>'
    )

    insert_pos = match.end()
    new_content = content[:insert_pos] + mod_pref + content[insert_pos:]

    if write_file_validated(file_path, new_content):
        print(f"  [OK] Đã gắn Intent mở Mod vào {os.path.basename(file_path)}")
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

    work_dir = os.getcwd()
    src_dir = os.path.join(work_dir, "bin", "modfile", "UpdateFile", "Settings_ROMInformation")

    print("Settings: Bắt đầu tích hợp Toolbox vào Settings -> Mod...")

    # 1. Assets
    copy_assets_to_apk(work_dir, out_dir)

    # 2. Smali
    copy_smali_to_apk(src_dir, out_dir)

    # 3. Resources (layout, drawable, color, ids)
    setup_resources(out_dir)

    # 4. AndroidManifest.xml
    manifest_path = os.path.join(out_dir, "AndroidManifest.xml")
    if os.path.isfile(manifest_path):
        patch_manifest(manifest_path)

    # 5. XML headers & preferences
    for root, _, files in os.walk(out_dir):
        for fn in files:
            if fn.startswith("settings_headers") and fn.endswith(".xml"):
                full_p = os.path.join(root, fn)
                patch_settings_headers(full_p)
            elif fn.startswith("top_level_settings") and fn.endswith(".xml"):
                full_p = os.path.join(root, fn)
                patch_top_level_settings(full_p)

    print("Settings: Tích hợp Toolbox vào Settings -> Mod hoàn tất.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
