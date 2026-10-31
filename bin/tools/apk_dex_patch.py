#!/usr/bin/env python3
"""Vá classes*.dex bên trong một APK mà KHÔNG rebuild resource.

Vì sao cần: APKEditor (`apke.jar b`) rebuild cả bảng resource. Với APK hệ thống
của Android 17 nó thất bại, và script PowerKeeper rơi vào nhánh "giữ nguyên bản
gốc" - tức là bản vá thông báo không được áp. Ở đây chỉ thay đúng file dex,
mọi entry khác (resources.arsc, res/, META-INF, lib/) được copy nguyên byte.

Quy trình (bash điều phối, python chỉ lo phần zip):

    python3 apk_dex_patch.py unpack <apk> <dir>
        -> <dir>/dex/classes.dex, classes2.dex, ...

    # bash: baksmali <dir>/dex/X.dex -o <dir>/smali/X  -> sửa smali
    #       smali <dir>/smali/X -o <dir>/dex/X.dex

    python3 apk_dex_patch.py repack <apk> <dir> <out.apk>
        -> <out.apk> giống bản gốc, chỉ dex được thay

Dex được ghi ở dạng STORED và canh 4 byte (yêu cầu của ART khi mmap), tính cả
extra field nên không phụ thuộc zipalign bên ngoài.
"""
import os
import re
import struct
import sys
import zipfile

DEX_RE = re.compile(r'^classes(\d*)\.dex$')
ALIGN = 4
EXTRA_ID = 0xD935  # id tự chọn, không xung đột với các extra field phổ biến


def list_dex(zf):
    return sorted(
        (n for n in zf.namelist() if DEX_RE.match(n)),
        key=lambda n: (len(n), n),
    )


def cmd_unpack(apk, outdir):
    dexdir = os.path.join(outdir, 'dex')
    os.makedirs(dexdir, exist_ok=True)
    with zipfile.ZipFile(apk) as zf:
        names = list_dex(zf)
        if not names:
            print('APK không có classes*.dex', file=sys.stderr)
            return 1
        for n in names:
            data = zf.read(n)
            if data[:4] != b'dex\n':
                print(f'{n}: không phải dex hợp lệ', file=sys.stderr)
                return 1
            with open(os.path.join(dexdir, n), 'wb') as f:
                f.write(data)
    print('\n'.join(names))
    return 0


def _aligned_extra(offset, name_len, align=ALIGN):
    """Chọn extra field sao cho (offset + 30 + name_len + len(extra)) % align == 0."""
    pad = (-(offset + 30 + name_len + 4)) % align
    extra_len = 4 + pad
    return struct.pack('<HH', EXTRA_ID, extra_len - 4) + b'\x00' * pad


def cmd_repack(apk, workdir, outapk):
    dexdir = os.path.join(workdir, 'dex')
    newdex = {}
    for n in os.listdir(dexdir):
        if DEX_RE.match(n):
            with open(os.path.join(dexdir, n), 'rb') as f:
                data = f.read()
            if data[:4] != b'dex\n':
                print(f'{n}: dex hỏng, không ghi đè APK', file=sys.stderr)
                return 1
            newdex[n] = data
    if not newdex:
        print('không có dex nào để đóng gói', file=sys.stderr)
        return 1

    tmp = outapk + '.tmp'
    replaced = 0
    with zipfile.ZipFile(apk) as zin, zipfile.ZipFile(tmp, 'w') as zout:
        for info in zin.infolist():
            is_dex = info.filename in newdex
            # Giữ nguyên kiểu nén của entry gốc; riêng dex thì luôn STORED.
            # Entry STORED phải được canh lại: kích thước dex đổi làm lệch offset
            # của mọi entry phía sau, và resources.arsc / .so cần canh đúng.
            store = is_dex or info.compress_type == zipfile.ZIP_STORED
            align = 4096 if info.filename.endswith('.so') else ALIGN

            data = newdex[info.filename] if is_dex else zin.read(info.filename)
            zi = zipfile.ZipInfo(info.filename, date_time=info.date_time)
            zi.compress_type = zipfile.ZIP_STORED if store else info.compress_type
            zi.external_attr = info.external_attr
            if store:
                # offset của local header sắp ghi = vị trí hiện tại của file
                offset = zout.fp.tell()
                zi.extra = _aligned_extra(
                    offset, len(info.filename.encode('utf-8')), align)
            zout.writestr(zi, data)
            if is_dex:
                replaced += 1

    if replaced == 0:
        os.unlink(tmp)
        print('không thay được dex nào', file=sys.stderr)
        return 1

    with zipfile.ZipFile(tmp) as z:
        bad = z.testzip()
        if bad is not None:
            os.unlink(tmp)
            print(f'zip hỏng ở {bad}', file=sys.stderr)
            return 1
        # Kiểm tra canh lề thật sự: fp.tell() có thể lệch nếu zipfile đổi cách
        # đệm, và lỗi đó chỉ lộ ra khi ART đọc APK trên máy. Thà biết ngay.
        for i in z.infolist():
            if i.compress_type != zipfile.ZIP_STORED:
                continue
            want = 4096 if i.filename.endswith('.so') else ALIGN
            off = i.header_offset + 30 + len(i.filename.encode('utf-8')) + len(i.extra)
            if off % want:
                print(f'CẢNH BÁO: {i.filename} lệch canh lề '
                      f'({off} % {want} != 0)', file=sys.stderr)
    os.replace(tmp, outapk)
    print(f'repacked {replaced} dex -> {outapk}')
    return 0


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        return 2
    cmd = sys.argv[1]
    if cmd == 'unpack' and len(sys.argv) == 4:
        return cmd_unpack(sys.argv[2], sys.argv[3])
    if cmd == 'repack' and len(sys.argv) == 5:
        return cmd_repack(sys.argv[2], sys.argv[3], sys.argv[4])
    print(__doc__)
    return 2


if __name__ == '__main__':
    sys.exit(main())
