#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Căn lề lại (zipalign) một APK mà không cần Android SDK.

Vì sao cần: bump_versioncode.py phải nén lại AndroidManifest.xml nên toàn bộ
offset phía sau dịch đi -> các .so (lưu uncompressed) mất căn lề trang. APK có
extractNativeLibs=false thì Android mmap thẳng .so trong APK và BẮT BUỘC data
offset chia hết 4096; sai căn lề = app không nạp được native lib.

Cách làm: ghi lại zip theo đúng thứ tự entry gốc; mỗi entry được chèn thêm
extra-field vào LOCAL header sao cho data bắt đầu ở bội số 4096 (với .so) hoặc
4 (entry thường). Nội dung, thứ tự, method nén, META-INF đều giữ nguyên nên
chứng thư vẫn là của Xiaomi (không re-sign).

Usage: realign_apk.py <in.apk> <out.apk> [align]
"""
import struct
import sys

LOCAL_SIG = 0x04034B50
CENTRAL_SIG = 0x02014B50
EOCD_SIG = 0x06054B50
PAD_ID = 0xD935          # extra-field id cho phần padding (giống zipalign)
LOCAL_FIXED = 30
CENTRAL_FIXED = 46


def page_for(name, align):
    return 4096 if name.endswith('.so') else align


def find_eocd(buf):
    start = max(0, len(buf) - 66000)
    idx = buf.rfind(struct.pack('<I', EOCD_SIG), start)
    if idx < 0:
        raise SystemExit('EOCD not found')
    n, cd_size, cd_off = struct.unpack_from('<HII', buf, idx + 10)
    return idx, cd_off, cd_size, n


def parse_central(buf, cd_off, n):
    entries, p = [], cd_off
    for _ in range(n):
        if struct.unpack_from('<I', buf, p)[0] != CENTRAL_SIG:
            raise SystemExit('bad central directory')
        (flags, method, mtime, mdate, crc, csize, usize, nlen, elen, clen,
         disk, iattr, eattr, lho) = struct.unpack_from('<HHHHIIIHHHHHII', buf, p + 8)
        name = buf[p + CENTRAL_FIXED:p + CENTRAL_FIXED + nlen].decode('utf-8', 'replace')
        extra = buf[p + CENTRAL_FIXED + nlen:p + CENTRAL_FIXED + nlen + elen]
        comment = buf[p + CENTRAL_FIXED + nlen + elen:
                      p + CENTRAL_FIXED + nlen + elen + clen]
        entries.append(dict(flags=flags, method=method, mtime=mtime, mdate=mdate,
                            crc=crc, csize=csize, usize=usize, name=name,
                            extra=extra, comment=comment, lho=lho, iattr=iattr,
                            eattr=eattr, disk=disk))
        p += CENTRAL_FIXED + nlen + elen + clen
    return entries


def local_payload(buf, lho, csize_cd):
    """Trả (name_bytes, extra, data_bytes, descriptor_bytes).

    csize_cd lấy từ central directory - đáng tin hơn local header: khi entry
    dùng data descriptor (flag bit 3), local header ghi csize = 0 còn kích thước
    thật chỉ có trong central directory.
    """
    if struct.unpack_from('<I', buf, lho)[0] != LOCAL_SIG:
        raise SystemExit('bad local header')
    nlen, elen, flags = struct.unpack_from('<HH', buf, lho + 26)[0], \
        struct.unpack_from('<H', buf, lho + 28)[0], \
        struct.unpack_from('<H', buf, lho + 6)[0]
    name = buf[lho + LOCAL_FIXED:lho + LOCAL_FIXED + nlen]
    extra = buf[lho + LOCAL_FIXED + nlen:lho + LOCAL_FIXED + nlen + elen]
    data_off = lho + LOCAL_FIXED + nlen + elen
    data = buf[data_off:data_off + csize_cd]

    desc = b''
    if flags & 0x08:  # bit 3: có data descriptor sau data
        after = data_off + csize_cd
        # descriptor có thể có chữ ký PK\x07\x08 (16 byte) hoặc không (12 byte)
        if buf[after:after + 4] == b'PK\x07\x08':
            desc = buf[after:after + 16]
        else:
            desc = buf[after:after + 12]
    return name, extra, data, desc


def pad_to(base_offset, name_bytes, extra_len, page):
    """Sinh extra-field để data bắt đầu đúng bội số page."""
    head = base_offset + LOCAL_FIXED + len(name_bytes) + extra_len
    need = (-head) % page
    if need == 0:
        return b''
    if need < 4:
        need += page          # extra tối thiểu 4 byte
    body = b'\x00' * (need - 4)
    return struct.pack('<HH', PAD_ID, len(body)) + body


def main():
    if len(sys.argv) < 3:
        raise SystemExit(__doc__)
    src, dst = sys.argv[1], sys.argv[2]
    align = int(sys.argv[3]) if len(sys.argv) > 3 else 4

    buf = open(src, 'rb').read()
    eocd_off, cd_off, cd_size, n = find_eocd(buf)
    entries = parse_central(buf, cd_off, n)

    out = bytearray()
    new_lho = []
    for e in entries:
        name_b, extra, data, desc = local_payload(buf, e['lho'], e['csize'])
        page = page_for(e['name'], align)
        pad = pad_to(len(out), name_b, len(extra), page)
        extra_new = extra + pad
        new_lho.append(len(out))
        # Với entry dùng data descriptor, local header phải ghi csize=usize=0
        # (giá trị thật nằm sau data) — giữ đúng như bản gốc.
        if e['flags'] & 0x08:
            l_crc, l_csize, l_usize = 0, 0, 0
        else:
            l_crc, l_csize, l_usize = e['crc'], e['csize'], e['usize']
        out += struct.pack('<IHHHHHIIIHH', LOCAL_SIG, 20, e['flags'], e['method'],
                           e['mtime'], e['mdate'], l_crc, l_csize, l_usize,
                           len(name_b), len(extra_new))
        out += name_b + extra_new + data + desc

    cd_start = len(out)
    for e, lho in zip(entries, new_lho):
        name_b = e['name'].encode('utf-8')
        out += struct.pack('<IHHHHHHIIIHHHHHII', CENTRAL_SIG, 20, 20, e['flags'],
                           e['method'], e['mtime'], e['mdate'], e['crc'], e['csize'],
                           e['usize'], len(name_b), len(e['extra']),
                           len(e['comment']), e['disk'], e['iattr'], e['eattr'], lho)
        out += name_b + e['extra'] + e['comment']
    cd_end = len(out)
    out += struct.pack('<IHHHHIIH', EOCD_SIG, 0, 0, n, n,
                       cd_end - cd_start, cd_start, 0)

    open(dst, 'wb').write(out)
    print(f'{dst}: {n} entries, {len(out)} bytes')


if __name__ == '__main__':
    main()
