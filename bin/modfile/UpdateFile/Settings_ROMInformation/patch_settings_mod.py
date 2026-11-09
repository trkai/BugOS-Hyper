#!/usr/bin/env python3
"""Tích hợp toàn bộ BugOS Toolbox vào Settings -> Toolbox (Settings.apk).

Thiết kế giao diện:
  1. Thẻ Banner trên cùng (Device Banner Card):
     - Chiều cao 200dp, bo góc 18dp.
     - Tên thiết bị hiển thị ở giữa, cách đỉnh 38dp, đọc động từ hệ thống.
     - Nút tròn cây bút ở góc dưới bên phải (chạm để đổi ảnh, giữ để đặt lại ảnh Gojo mặc định).
     - Ảnh nền mặc định: Hình Gojo Satoru (@drawable/bg_mod_banner_default).
  2. Hai thẻ chức năng bên dưới:
     - Bố cục dạng hàng ngang nhỏ gọn.
     - SukiSU Ultra: Nút capsule góc phải tự chuyển đổi trạng thái "Cài đặt" -> "Đang cài..." -> "Mở".
     - Flash Module: Nút "Flash" góc phải tự mở khóa khi SukiSU đã cài.
  3. Kỹ thuật APKEditor:
     - Sử dụng các View ID có sẵn của Settings.apk (banner, banner_background, device_name,
       edit_button, action_button, status, button1, other_advanced_settings).
     - KHÔNG chèn ID mới vào ids.xml để tránh lỗi 'Undefined entry name'.
     - Tự động đăng ký các drawable/layout mới vào public.xml với ID tuần tự hợp lệ.
     - Tương thích hoàn hảo Light/Dark mode qua drawable/ và drawable-night/.
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
    """Sao chép các file smali vào thư mục classesN có nhiều slot trống nhất (classes12...)."""
    smali_src = os.path.join(src_dir, "smali", "com", "android", "settings", "mod")
    if not os.path.isdir(smali_src):
        print(f"  [WARN] Không thấy thư mục smali nguồn: {smali_src}", file=sys.stderr)
        return

    smali_root = os.path.join(out_dir, "smali")
    smali_target_base = os.path.join(smali_root, "classes")
    if os.path.isdir(smali_root):
        cand = [d for d in os.listdir(smali_root) if d.startswith("classes")]
        if cand:
            def key_func(d):
                m = re.search(r"classes(\d+)", d)
                return int(m.group(1)) if m else 1
            # Chọn classes có số lớn nhất (classes12 chỉ có ~800 methods, tránh tràn 65K methods ở classes1)
            best_dir = max(cand, key=key_func)
            smali_target_base = os.path.join(smali_root, best_dir)

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


def register_public_resources(res_root):
    """Đăng ký các file layout và drawable mới vào public.xml để APKEditor gán ID hợp lệ."""
    pub_path = os.path.join(res_root, "values", "public.xml")
    if not os.path.isfile(pub_path):
        return

    try:
        tree = ET.parse(pub_path)
        root = tree.getroot()
    except Exception as e:
        print(f"  [WARN] Lỗi đọc public.xml: {e}", file=sys.stderr)
        return

    max_ids = {}
    existing = set()
    for elem in root.findall("public"):
        t = elem.get("type")
        name = elem.get("name")
        existing.add((t, name))
        raw_id_str = elem.get("id", "0")
        try:
            raw_id = int(raw_id_str, 16)
            max_ids[t] = max(max_ids.get(t, 0), raw_id)
        except ValueError:
            pass

    new_items = [
        ("layout", "activity_bugos_mod"),
        ("drawable", "bg_mod_banner_frame"),
        ("drawable", "bg_mod_banner_default"),
        ("drawable", "bg_mod_banner_scrim"),
        ("drawable", "bg_mod_btn_circle"),
        ("drawable", "ic_mod_pencil"),
        ("drawable", "bg_mod_card"),
        ("drawable", "bg_mod_btn_pill_primary"),
        ("drawable", "bg_mod_btn_pill_outline"),
        ("drawable", "bg_mod_btn_pill_disabled"),
    ]

    added = 0
    for res_type, res_name in new_items:
        if (res_type, res_name) not in existing:
            curr_max = max_ids.get(res_type, 0x7f000000)
            new_id = curr_max + 1
            max_ids[res_type] = new_id
            ET.SubElement(root, "public", {
                "id": f"0x{new_id:08x}",
                "type": res_type,
                "name": res_name
            })
            existing.add((res_type, res_name))
            added += 1

    if added > 0:
        tree.write(pub_path, encoding="utf-8", xml_declaration=True)
        print(f"  [OK] Đã đăng ký {added} resource mới vào public.xml")


def setup_resources(src_dir, out_dir):
    """Tạo layout và drawable cho trang Toolbox."""
    res_root = os.path.join(out_dir, "resources", "package_1", "res")
    if not os.path.isdir(res_root):
        for root, dirs, _ in os.walk(out_dir):
            if os.path.basename(root) == "res" and "drawable" in dirs:
                res_root = root
                break

    layout_dir = os.path.join(res_root, "layout")
    drawable_dir = os.path.join(res_root, "drawable")
    drawable_night_dir = os.path.join(res_root, "drawable-night")

    os.makedirs(layout_dir, exist_ok=True)
    os.makedirs(drawable_dir, exist_ok=True)
    os.makedirs(drawable_night_dir, exist_ok=True)

    # 1. Layout activity_bugos_mod.xml (Dùng các View ID có sẵn của Settings.apk)
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
        android:paddingTop="14dp"
        android:paddingBottom="36dp">

        <!-- Banner Card -->
        <FrameLayout
            android:id="@id/banner"
            android:layout_width="match_parent"
            android:layout_height="200dp"
            android:background="@drawable/bg_mod_banner_frame"
            android:layout_marginBottom="14dp">

            <ImageView
                android:id="@id/banner_background"
                android:layout_width="match_parent"
                android:layout_height="match_parent"
                android:scaleType="centerCrop"
                android:src="@drawable/bg_mod_banner_default" />

            <View
                android:layout_width="match_parent"
                android:layout_height="match_parent"
                android:background="@drawable/bg_mod_banner_scrim" />

            <!-- Tên máy ở giữa, dịch xuống 38dp -->
            <TextView
                android:id="@id/device_name"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_gravity="top|center_horizontal"
                android:layout_marginTop="38dp"
                android:gravity="center"
                android:text="Xiaomi HyperOS"
                android:textColor="#FFFFFF"
                android:textSize="19sp"
                android:textStyle="bold"
                android:shadowColor="#99000000"
                android:shadowDx="0"
                android:shadowDy="1"
                android:shadowRadius="4" />

            <!-- Nút tròn cây bút góc dưới bên phải -->
            <FrameLayout
                android:id="@id/edit_button"
                android:layout_width="32dp"
                android:layout_height="32dp"
                android:layout_gravity="bottom|end"
                android:layout_marginEnd="12dp"
                android:layout_marginBottom="12dp"
                android:background="@drawable/bg_mod_btn_circle"
                android:clickable="true"
                android:focusable="true">

                <ImageView
                    android:layout_width="16dp"
                    android:layout_height="16dp"
                    android:layout_gravity="center"
                    android:src="@drawable/ic_mod_pencil" />
            </FrameLayout>
        </FrameLayout>

        <!-- Card 1: SukiSU Ultra -->
        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="horizontal"
            android:gravity="center_vertical"
            android:background="@drawable/bg_mod_card"
            android:paddingStart="18dp"
            android:paddingEnd="18dp"
            android:paddingTop="18dp"
            android:paddingBottom="18dp"
            android:layout_marginBottom="14dp">

            <LinearLayout
                android:layout_width="0dp"
                android:layout_height="wrap_content"
                android:layout_weight="1"
                android:orientation="vertical"
                android:paddingEnd="12dp">

                <TextView
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:text="SukiSU Ultra"
                    android:textSize="16sp"
                    android:textStyle="bold"
                    android:textColor="?android:attr/textColorPrimary" />

                <TextView
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:layout_marginTop="4dp"
                    android:text="Quản lý cấp quyền root cho kernel"
                    android:textSize="12sp"
                    android:textColor="?android:attr/textColorSecondary" />
            </LinearLayout>

            <Button
                android:id="@id/action_button"
                android:layout_width="wrap_content"
                android:layout_height="34dp"
                android:minWidth="76dp"
                android:paddingStart="14dp"
                android:paddingEnd="14dp"
                android:background="@drawable/bg_mod_btn_pill_primary"
                android:text="Cài đặt"
                android:textColor="#FFFFFF"
                android:textSize="13sp"
                android:textStyle="bold"
                android:textAllCaps="false"
                android:stateListAnimator="@null" />
        </LinearLayout>

        <!-- Card 2: Flash Module -->
        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="horizontal"
            android:gravity="center_vertical"
            android:background="@drawable/bg_mod_card"
            android:paddingStart="18dp"
            android:paddingEnd="18dp"
            android:paddingTop="18dp"
            android:paddingBottom="18dp">

            <LinearLayout
                android:layout_width="0dp"
                android:layout_height="wrap_content"
                android:layout_weight="1"
                android:orientation="vertical"
                android:paddingEnd="12dp">

                <TextView
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:text="Flash Module có sẵn"
                    android:textSize="16sp"
                    android:textStyle="bold"
                    android:textColor="?android:attr/textColorPrimary" />

                <TextView
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:layout_marginTop="4dp"
                    android:text="Zygisk Next + AlwaysStrong Inject"
                    android:textSize="12sp"
                    android:textColor="?android:attr/textColorSecondary" />

                <TextView
                    android:id="@id/status"
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:layout_marginTop="4dp"
                    android:text="Cần SukiSU Ultra trước"
                    android:textSize="11sp"
                    android:textStyle="bold"
                    android:textColor="#FF5252" />
            </LinearLayout>

            <Button
                android:id="@id/button1"
                android:layout_width="wrap_content"
                android:layout_height="34dp"
                android:minWidth="76dp"
                android:paddingStart="14dp"
                android:paddingEnd="14dp"
                android:background="@drawable/bg_mod_btn_pill_primary"
                android:text="Flash"
                android:textColor="#FFFFFF"
                android:textSize="13sp"
                android:textStyle="bold"
                android:textAllCaps="false"
                android:enabled="false"
                android:stateListAnimator="@null" />
        </LinearLayout>
    </LinearLayout>
</ScrollView>
'''
    write_file_validated(os.path.join(layout_dir, "activity_bugos_mod.xml"), layout_content)

    # 2. Drawables cho Banner
    banner_frame = '''<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="rectangle">
    <corners android:radius="18dp" />
    <solid android:color="#202227" />
</shape>
'''
    write_file_validated(os.path.join(drawable_dir, "bg_mod_banner_frame.xml"), banner_frame)

    # Ảnh Gojo mặc định
    banner_img_src = os.path.join(src_dir, "bg_mod_banner_default.jpg")
    banner_img_dest = os.path.join(drawable_dir, "bg_mod_banner_default.jpg")
    if os.path.isfile(banner_img_src):
        shutil.copy2(banner_img_src, banner_img_dest)
        xml_fallback = os.path.join(drawable_dir, "bg_mod_banner_default.xml")
        if os.path.isfile(xml_fallback):
            os.remove(xml_fallback)
        print(f"  [OK] Đã chép ảnh bìa Gojo mặc định vào {os.path.basename(banner_img_dest)}")

    banner_scrim = '''<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="rectangle">
    <corners android:radius="18dp" />
    <gradient
        android:startColor="#66000000"
        android:centerColor="#15000000"
        android:endColor="#44000000"
        android:angle="270" />
</shape>
'''
    write_file_validated(os.path.join(drawable_dir, "bg_mod_banner_scrim.xml"), banner_scrim)

    btn_circle = '''<?xml version="1.0" encoding="utf-8"?>
<ripple xmlns:android="http://schemas.android.com/apk/res/android"
    android:color="#44FFFFFF">
    <item android:id="@android:id/mask">
        <shape android:shape="oval">
            <solid android:color="#FFFFFF" />
        </shape>
    </item>
    <item>
        <selector>
            <item android:state_pressed="true">
                <shape android:shape="oval">
                    <solid android:color="#88000000" />
                </shape>
            </item>
            <item>
                <shape android:shape="oval">
                    <solid android:color="#4D000000" />
                </shape>
            </item>
        </selector>
    </item>
</ripple>
'''
    write_file_validated(os.path.join(drawable_dir, "bg_mod_btn_circle.xml"), btn_circle)

    pencil_vector = '''<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24">
    <path
        android:fillColor="#FFFFFFFF"
        android:pathData="M3,17.25V21h3.75L17.81,9.94l-3.75,-3.75L3,17.25zM20.71,7.04c0.39,-0.39 0.39,-1.02 0,-1.41l-2.34,-2.34c-0.39,-0.39 -1.02,-0.39 -1.41,0l-1.83,1.83 3.75,3.75 1.83,-1.83z" />
</vector>
'''
    write_file_validated(os.path.join(drawable_dir, "ic_mod_pencil.xml"), pencil_vector)

    # 3. Drawables cho thẻ Card (Light & Dark mode tách theo thư mục)
    card_light = '''<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="rectangle">
    <solid android:color="#FFFFFF" />
    <corners android:radius="18dp" />
    <stroke android:width="1dp" android:color="#EAEAEA" />
</shape>
'''
    write_file_validated(os.path.join(drawable_dir, "bg_mod_card.xml"), card_light)

    card_dark = '''<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="rectangle">
    <solid android:color="#202227" />
    <corners android:radius="18dp" />
    <stroke android:width="1dp" android:color="#2D3036" />
</shape>
'''
    write_file_validated(os.path.join(drawable_night_dir, "bg_mod_card.xml"), card_dark)

    # 4. Buttons: Pill Primary
    btn_pill_primary = '''<?xml version="1.0" encoding="utf-8"?>
<ripple xmlns:android="http://schemas.android.com/apk/res/android"
    android:color="#33FFFFFF">
    <item android:id="@android:id/mask">
        <shape android:shape="rectangle">
            <corners android:radius="17dp" />
            <solid android:color="#FFFFFF" />
        </shape>
    </item>
    <item>
        <selector>
            <item android:state_enabled="false">
                <shape android:shape="rectangle">
                    <solid android:color="#E0E0E0" />
                    <corners android:radius="17dp" />
                </shape>
            </item>
            <item android:state_pressed="true">
                <shape android:shape="rectangle">
                    <solid android:color="#158569" />
                    <corners android:radius="17dp" />
                </shape>
            </item>
            <item>
                <shape android:shape="rectangle">
                    <solid android:color="#1BA784" />
                    <corners android:radius="17dp" />
                </shape>
            </item>
        </selector>
    </item>
</ripple>
'''
    write_file_validated(os.path.join(drawable_dir, "bg_mod_btn_pill_primary.xml"), btn_pill_primary)

    # Pill Outline (Light & Dark)
    btn_outline_light = '''<?xml version="1.0" encoding="utf-8"?>
<ripple xmlns:android="http://schemas.android.com/apk/res/android"
    android:color="#221BA784">
    <item android:id="@android:id/mask">
        <shape android:shape="rectangle">
            <corners android:radius="17dp" />
            <solid android:color="#FFFFFF" />
        </shape>
    </item>
    <item>
        <selector>
            <item android:state_pressed="true">
                <shape android:shape="rectangle">
                    <solid android:color="#E2F4ED" />
                    <stroke android:width="1.5dp" android:color="#1BA784" />
                    <corners android:radius="17dp" />
                </shape>
            </item>
            <item>
                <shape android:shape="rectangle">
                    <solid android:color="#F0FAF7" />
                    <stroke android:width="1dp" android:color="#1BA784" />
                    <corners android:radius="17dp" />
                </shape>
            </item>
        </selector>
    </item>
</ripple>
'''
    write_file_validated(os.path.join(drawable_dir, "bg_mod_btn_pill_outline.xml"), btn_outline_light)

    btn_outline_dark = '''<?xml version="1.0" encoding="utf-8"?>
<ripple xmlns:android="http://schemas.android.com/apk/res/android"
    android:color="#221BA784">
    <item android:id="@android:id/mask">
        <shape android:shape="rectangle">
            <corners android:radius="17dp" />
            <solid android:color="#FFFFFF" />
        </shape>
    </item>
    <item>
        <selector>
            <item android:state_pressed="true">
                <shape android:shape="rectangle">
                    <solid android:color="#223731" />
                    <stroke android:width="1.5dp" android:color="#1BA784" />
                    <corners android:radius="17dp" />
                </shape>
            </item>
            <item>
                <shape android:shape="rectangle">
                    <solid android:color="#182622" />
                    <stroke android:width="1dp" android:color="#1BA784" />
                    <corners android:radius="17dp" />
                </shape>
            </item>
        </selector>
    </item>
</ripple>
'''
    write_file_validated(os.path.join(drawable_night_dir, "bg_mod_btn_pill_outline.xml"), btn_outline_dark)

    # Pill Disabled (Light & Dark)
    btn_disabled_light = '''<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="rectangle">
    <solid android:color="#E0E0E0" />
    <corners android:radius="17dp" />
</shape>
'''
    write_file_validated(os.path.join(drawable_dir, "bg_mod_btn_pill_disabled.xml"), btn_disabled_light)

    btn_disabled_dark = '''<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="rectangle">
    <solid android:color="#33353A" />
    <corners android:radius="17dp" />
</shape>
'''
    write_file_validated(os.path.join(drawable_night_dir, "bg_mod_btn_pill_disabled.xml"), btn_disabled_dark)

    # 5. Đăng ký tất cả tài nguyên mới vào public.xml
    register_public_resources(res_root)
    print("  [OK] Đã thiết lập toàn bộ tài nguyên UI cho Toolbox")


def patch_manifest(manifest_path):
    """Đăng ký Activity, Provider, queries và permission trong AndroidManifest.xml."""
    content = read_file(manifest_path)
    if not content:
        return False

    if "com.android.settings.mod.BugOSModActivity" in content:
        return True

    if "REQUEST_INSTALL_PACKAGES" not in content:
        idx = content.find("<application")
        if idx != -1:
            perm = '    <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />\n'
            content = content[:idx] + perm + content[idx:]

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

    app_close = content.rfind("</application>")
    if app_close != -1:
        mod_components = (
            '        <activity android:name="com.android.settings.mod.BugOSModActivity"\n'
            '                  android:label="Toolbox"\n'
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
    """Gắn header Toolbox vào settings_headers.xml ngay dưới my_device."""
    content = read_file(file_path)
    if not content:
        return False

    if "com.android.settings.mod.BugOSModActivity" in content:
        return True

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
        '\n          android:id="@id/other_advanced_settings"'
        '\n          android:title="Toolbox">'
        '\n    <intent android:targetPackage="com.android.settings"'
        '\n            android:targetClass="com.android.settings.mod.BugOSModActivity" />'
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
        '\n                          android:title="Toolbox"'
        '\n                          android:key="top_level_toolbox"'
        '\n                          android:order="-9">'
        '\n        <intent android:targetPackage="com.android.settings"'
        '\n                android:targetClass="com.android.settings.mod.BugOSModActivity" />'
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

    work_dir = os.getcwd()
    src_dir = os.path.join(work_dir, "bin", "modfile", "UpdateFile", "Settings_ROMInformation")

    print("Settings: Bắt đầu tích hợp Toolbox vào Settings -> Toolbox...")

    # 1. Assets
    copy_assets_to_apk(work_dir, out_dir)

    # 2. Smali
    copy_smali_to_apk(src_dir, out_dir)

    # 3. Resources (layout, drawables, public.xml)
    setup_resources(src_dir, out_dir)

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

    print("Settings: Tích hợp Toolbox vào Settings -> Toolbox hoàn tất.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
