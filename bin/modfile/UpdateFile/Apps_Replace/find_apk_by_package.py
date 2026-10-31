#!/usr/bin/env python3
"""Tìm APK của một package trong cây images đã bung.

Đọc AndroidManifest.xml (binary AXML) và so khớp **thuộc tính package của thẻ
<manifest>**, KHÔNG tìm chuỗi package ở bất kỳ đâu trong file.

Vì sao quan trọng: rất nhiều APK có nhắc tới package khác trong manifest (khai
báo permission, provider, queries...). Bản trước dùng tìm-chuỗi nên đã khớp sai
trên ROM thật:
  - "com.miui.gallery"  khớp nhầm MIUICloudService.apk
  - "com.miui.weather2" khớp nhầm CarWith.apk
và thay thế luôn hai app đó bằng Gallery/Weather.

Usage:
    find_apk_by_package.py <images_dir> <package>
    find_apk_by_package.py <images_dir> --list <pkg1,pkg2,...>
    find_apk_by_package.py -- --pkg-of <file.apk>      # in package của 1 APK
"""
import os
import struct
import sys
import zipfile

# Thư mục không bao giờ chứa APK -> bỏ qua để khỏi quét thừa
SKIP_DIRS = {
    'overlay', 'lib', 'lib64', 'lib32', 'etc', 'framework', 'media', 'fonts',
    'bin', 'xbin', 'oat', 'usr', 'lost+found', 'config', 'build.prop',
}
CHUNK_STRING_POOL = 0x0001
CHUNK_START_TAG = 0x0102
TYPE_STRING = 0x03


def _strings(data, off):
    """Đọc string pool. Trả về list[str]."""
    cnt, _styc, flags, sstart, _systart = struct.unpack_from('<IIIII', data, off + 8)
    offsets = struct.unpack_from('<%dI' % cnt, data, off + 28)
    base = off + sstart
    utf8 = bool(flags & 0x100)
    out = []
    for o in offsets:
        p = base + o
        if utf8:
            n = data[p]; p += 1
            if n & 0x80:
                p += 1
            n2 = data[p]; p += 1
            if n2 & 0x80:
                n2 = ((n2 & 0x7F) << 8) | data[p]; p += 1
            out.append(data[p:p + n2].decode('utf-8', 'replace'))
        else:
            n = struct.unpack_from('<H', data, p)[0]; p += 2
            if n & 0x8000:
                n = ((n & 0x7FFF) << 16) | struct.unpack_from('<H', data, p)[0]; p += 2
            out.append(data[p:p + 2 * n].decode('utf-16-le', 'replace'))
    return out


def manifest_package(apk):
    """Trả về package name khai trong thẻ <manifest>, hoặc None.

    Mọi lỗi (zip hỏng, AXML lạ, struct.error) đều trả None. Trước đây một APK
    lỗi làm cả script chết giữa đường, stderr bị 2>/dev/null nuốt mất, và kết quả
    là "KHÔNG thấy package ... trong images" dù app có trong ROM.
    """
    try:
        return _manifest_package(apk)
    except Exception:
        return None


def _manifest_package(apk):
    try:
        with zipfile.ZipFile(apk) as z:
            data = z.read('AndroidManifest.xml')
    except Exception:
        return None
    if len(data) < 8 or data[0:2] != b'\x03\x00':
        return None

    strings = None
    off = 8
    while off + 8 <= len(data):
        ctype, _hsize, csize = struct.unpack_from('<HHI', data, off)
        if csize <= 0:
            break
        if ctype == CHUNK_STRING_POOL:
            strings = _strings(data, off)
        elif ctype == CHUNK_START_TAG and strings is not None:
            _ns, name = struct.unpack_from('<iI', data, off + 16)
            if name < len(strings) and strings[name] == 'manifest':
                a_start, a_size, a_count = struct.unpack_from('<HHH', data, off + 24)
                base = off + 16 + a_start
                for i in range(a_count):
                    a = base + i * a_size
                    if a + 20 > len(data):
                        break
                    _ans, aname, _raw, _vsize, _res0, dtype, vdata = \
                        struct.unpack_from('<iIIHBBI', data, a)
                    if (aname < len(strings) and strings[aname] == 'package'
                            and dtype == TYPE_STRING and vdata < len(strings)):
                        return strings[vdata]
                return None
        off += csize
    return None


def candidates(images):
    """Mọi *.apk trong cây images, trừ các thư mục chắc chắn không có app.

    Trước đây chỉ quét <part>/app và <part>/priv-app, nên app nằm ở
    <part>/data-app (MIUI xếp Gallery/Weather vào đây ở một số bản) bị bỏ sót
    hoàn toàn.
    """
    for part in sorted(os.listdir(images)):
        pdir = os.path.join(images, part)
        if not os.path.isdir(pdir):
            continue
        for root, dirs, files in os.walk(pdir):
            dirs[:] = sorted(d for d in dirs if d not in SKIP_DIRS)
            for fn in sorted(files):
                if fn.endswith('.apk'):
                    # luôn in bằng '/' để bash xử lý được trên mọi HĐH
                    yield os.path.join(root, fn).replace(os.sep, "/")


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        return 2
    images, arg = sys.argv[1], sys.argv[2]

    if arg == "--pkg-of":
        if len(sys.argv) < 4:
            print("thiếu đường dẫn APK", file=sys.stderr)
            return 2
        pkg = manifest_package(sys.argv[3])
        if pkg:
            print(pkg)
            return 0
        return 1

    if not os.path.isdir(images):
        print(f"images dir không tồn tại: {images}", file=sys.stderr)
        return 2

    wanted = arg == "--list"
    pkgs = [p for p in sys.argv[3].split(",") if p] if wanted else [arg]
    found = {}

    for apk in candidates(images):
        pkg = manifest_package(apk)
        if pkg in pkgs and pkg not in found:
            found[pkg] = apk
        if len(found) == len(pkgs):
            break

    if wanted:
        for p in pkgs:
            print(f"{p}\t{found.get(p, '')}")
        return 0 if found else 1

    if arg in found:
        print(found[arg])
        return 0
    return 1


if __name__ == "__main__":
    sys.exit(main())
