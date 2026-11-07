#!/usr/bin/env python3
"""Raise android:versionCode inside an APK's binary AndroidManifest.xml.

Why: GetApps (com.xiaomi.market) is fed updates by comparing the versionCode
installed on the device with the one its server offers. Raising the shipped
version above anything Xiaomi will publish makes the store stop offering an
update for that package, and turns any forced install into a downgrade, which
PackageManager rejects on its own.

Only the 4-byte value of attribute android:versionCode (resource id
0x0101021b) is rewritten; the chunk sizes do not change. The zip is rebuilt
with the original entries and the original META-INF signatures, so the signing
certificate stays Xiaomi's - the signature digest no longer matches, which the
ROM already tolerates because COREPATCH patches ApkSignatureVerifier.

Usage: bump_versioncode.py <apk> [newVersionCode]
       bump_versioncode.py --show <apk>
"""
import struct
import sys
import zipfile

VERSION_CODE_RES_ID = 0x0101021B
RES_XML_TYPE = 0x0003
RES_STRING_POOL_TYPE = 0x0001
RES_XML_START_ELEMENT_TYPE = 0x0102
TYPE_INT_DEC = 0x10
TYPE_INT_HEX = 0x11
UTF8_FLAG = 0x100


def _u16(b, o):
    return struct.unpack_from('<H', b, o)[0]


def _u32(b, o):
    return struct.unpack_from('<I', b, o)[0]


def _string_pool(buf, base):
    """Return list of strings from a ResStringPool chunk at base."""
    header_size = _u16(buf, base + 2)
    size = _u32(buf, base + 4)
    count = _u32(buf, base + 8)
    flags = _u32(buf, base + 16)
    strings_start = _u32(buf, base + 20)
    utf8 = bool(flags & UTF8_FLAG)
    out = []
    for i in range(count):
        off = base + strings_start + _u32(buf, base + header_size + i * 4)
        if utf8:
            # utf16 length (skipped), then utf8 byte length
            p = off + (2 if buf[off] & 0x80 else 1)
            n = buf[p]
            p += 1
            if n & 0x80:
                n = ((n & 0x7F) << 8) | buf[p]
                p += 1
            out.append(buf[p:p + n].decode('utf-8', 'replace'))
        else:
            n = _u16(buf, off)
            p = off + 2
            if n & 0x8000:
                n = ((n & 0x7FFF) << 16) | _u16(buf, p)
                p += 2
            out.append(buf[p:p + n * 2].decode('utf-16-le', 'replace'))
    return out, size


def find_version_code_offset(manifest):
    """Return (offset of the 4-byte value, current value) or None.

    The attribute stride varies between aapt versions (16 or 20 bytes here), so
    instead of hardcoding the struct we scan each attribute slot for the word
    that encodes a Res_value header of an int (size=8, res0=0, type=0x10/0x11)
    and read the value right after it.
    """
    if _u16(manifest, 0) != RES_XML_TYPE:
        return None
    pools = []
    off = _u16(manifest, 2)
    total = len(manifest)
    while off + 8 <= total:
        ctype = _u16(manifest, off)
        header_size = _u16(manifest, off + 2)
        chunk_size = _u32(manifest, off + 4)
        if chunk_size < 8 or off + chunk_size > total:
            break
        if ctype == RES_STRING_POOL_TYPE:
            pools.append(_string_pool(manifest, off)[0])
        elif ctype == RES_XML_START_ELEMENT_TYPE:
            ext = off + header_size
            attr_start = _u16(manifest, ext + 8)
            attr_size = _u16(manifest, ext + 10)
            attr_count = _u16(manifest, ext + 12)
            if not attr_size:
                off += chunk_size
                continue
            names = pools[0] if pools else []
            for i in range(attr_count):
                a = ext + attr_start + i * attr_size
                if a + 8 > total:
                    break
                name_idx = _u32(manifest, a + 4)
                is_version = False
                if name_idx < len(names) and names[name_idx] == 'versionCode':
                    is_version = True
                if not is_version:
                    continue
                # find the Res_value header inside this attribute slot
                for w in range(a, min(a + attr_size - 4, total - 8) + 1, 4):
                    hdr = _u32(manifest, w)
                    dtype = (hdr >> 24) & 0xFF
                    size = hdr & 0xFFFF
                    if size == 8 and dtype in (TYPE_INT_DEC, TYPE_INT_HEX):
                        return w + 4, _u32(manifest, w + 4)
        off += chunk_size
    return None


def read_apk(path):
    with zipfile.ZipFile(path) as z:
        manifest = z.read('AndroidManifest.xml')
    return manifest


def show(path):
    offset, value = find_version_code_offset(read_apk(path)) or (None, None)
    print('versionCode=%s (offset %s)' % (value, offset))
    return value


ALIGNED_ENTRIES = ('resources.arsc',)


def _aligned_extra(cur_offset, name_len, align=4):
    """Extra field sized so the entry data starts on an `align` boundary.

    Android refuses to install an APK whose resources.arsc is compressed or not
    4-byte aligned, so stored entries get a filler extra field. An unknown extra
    id is ignored by the platform reader.
    """
    base = cur_offset + 30 + name_len
    extra_len = ((align - base % align) % align) + align
    pad = b'\x00' * (extra_len - 4)
    return struct.pack('<HH', 0x0000, len(pad)) + pad


def bump(path, new_code):
    with zipfile.ZipFile(path) as z:
        infos = z.infolist()
        data = {i.filename: z.read(i.filename) for i in infos}

    manifest = bytearray(data['AndroidManifest.xml'])
    found = find_version_code_offset(bytes(manifest))
    if not found:
        raise SystemExit('versionCode attribute not found in %s' % path)
    offset, old = found

    struct.pack_into('<I', manifest, offset, new_code)
    data['AndroidManifest.xml'] = bytes(manifest)

    tmp = path + '.tmp'
    with zipfile.ZipFile(tmp, 'w') as out:
        for info in infos:
            zi = zipfile.ZipInfo(info.filename, date_time=info.date_time)
            zi.compress_type = info.compress_type
            zi.external_attr = info.external_attr
            zi.internal_attr = info.internal_attr
            zi.create_system = info.create_system
            if info.filename in ALIGNED_ENTRIES and info.compress_type == zipfile.ZIP_STORED:
                zi.extra = _aligned_extra(out.fp.tell(), len(info.filename.encode('utf-8')))
            out.writestr(zi, data[info.filename])

    if find_version_code_offset(data['AndroidManifest.xml'])[1] != new_code:
        raise SystemExit('patch did not stick for %s' % path)
    import os
    os.replace(tmp, path)
    print('%s: versionCode %d -> %d' % (path.split('/')[-1], old, new_code))


if __name__ == '__main__':
    if len(sys.argv) == 3 and sys.argv[1] == '--show':
        show(sys.argv[2])
    elif len(sys.argv) == 3:
        bump(sys.argv[1], int(sys.argv[2]))
    elif len(sys.argv) == 2:
        show(sys.argv[1])
    else:
        raise SystemExit(__doc__)
