#!/usr/bin/env python3
"""Tìm APK của một package trong cây images đã bung.

Không dựa vào tên thư mục (MIUIGallery / Weather / MIUIWeather ... đổi theo bản),
mà đọc AndroidManifest.xml của từng APK và so khớp chuỗi package. String pool
nằm ở đầu file nên chỉ cần đọc ~128KB đầu là đủ.

Usage:
    find_apk_by_package.py <images_dir> <package>
    find_apk_by_package.py <images_dir> --list <package1,package2,...>

In ra đường dẫn APK (dòng đầu) hoặc rỗng nếu không thấy.
"""
import os
import sys
import zipfile

SCAN_ROOTS = ("app", "priv-app")
HEAD = 256 * 1024


def candidates(images):
    for part in sorted(os.listdir(images)):
        pdir = os.path.join(images, part)
        if not os.path.isdir(pdir):
            continue
        for kind in SCAN_ROOTS:
            kdir = os.path.join(pdir, kind)
            if not os.path.isdir(kdir):
                continue
            for app in sorted(os.listdir(kdir)):
                adir = os.path.join(kdir, app)
                if not os.path.isdir(adir):
                    continue
                for fn in sorted(os.listdir(adir)):
                    if fn.endswith(".apk"):
                        # luôn in bằng '/' để bash xử lý được trên mọi HĐH
                        yield os.path.join(adir, fn).replace(os.sep, "/")


def manifest_head(apk):
    try:
        with zipfile.ZipFile(apk) as z:
            with z.open("AndroidManifest.xml") as f:
                return f.read(HEAD)
    except Exception:
        return b""


def has_package(data, pkg):
    if not data:
        return False
    return pkg.encode("utf-16-le") in data or pkg.encode("utf-8") in data


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        return 2
    images, arg = sys.argv[1], sys.argv[2]

    if not os.path.isdir(images):
        print(f"images dir không tồn tại: {images}", file=sys.stderr)
        return 2

    if arg == "--list":
        pkgs = [p for p in sys.argv[3].split(",") if p]
        found = {}
        for apk in candidates(images):
            head = manifest_head(apk)
            for p in pkgs:
                if p in found:
                    continue
                if has_package(head, p):
                    found[p] = apk
        for p in pkgs:
            print(f"{p}\t{found.get(p, '')}")
        return 0 if found else 1

    for apk in candidates(images):
        if has_package(manifest_head(apk), arg):
            print(apk)
            return 0
    return 1


if __name__ == "__main__":
    sys.exit(main())
