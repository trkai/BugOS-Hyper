#!/usr/bin/env python3
# ---------------------------------------------------------------------------
# Vá section bootconfig trong boot.img de gia verified-boot state.
#
# VI SAO KHONG PHAI CMDLINE / BUILD.PROP:
#   bootloader truyen androidboot.verifiedbootstate / vbmeta.device_state qua
#   BOOTCONFIG (khong phai cmdline). init ap bootconfig TRUOC cmdline va dung
#   properties.emplace("ro.boot."+key, value) - emplace KHONG ghi de key da co.
#   Nen noi them co vao cmdline vendor_boot (cach cac tool khac lam) luon thua:
#   /proc/cmdline co green nhung getprop van orange. Da kiem chung tren
#   annibale OS4.0.5.0.XPKCNXM.
#
# DINH DANG BLOCK (Linux Documentation/admin-guide/bootconfig.rst):
#   "#BOOTCONFIG\n" + "key = value\n"... + padding 4 byte
#   + u32 checksum (LE, tong cac byte cua phan du lieu)
#   + u32 size     (LE, tong kich thuoc block, GOM ca 8 byte cua 2 truong nay)
#   Block nam o CUOI boot.img.
#
# AN TOAN:
#   Chi ghi khi tim thay magic VA checksum cua block goc khop. Khong khop ->
#   exit 2, khong dong vao file. Khong bao gio doan layout.
# ---------------------------------------------------------------------------
import argparse
import shutil
import struct
import sys

MAGIC = b"#BOOTCONFIG\n"
ALIGN = 4

# Gia tri can dat. Chi 3 key nay: ro.boot.vbmeta.digest CO Y KHONG co mat.
# Tren may unlocked TEE tra verifiedBootHash = 0 hoac gia tri that; dat prop
# thanh mot hash khac se tao mismatch - detector bat de hon la de nguyen.
WANTED = {
    "androidboot.verifiedbootstate": "green",
    "androidboot.flash.locked": "1",
    "androidboot.vbmeta.device_state": "locked",
}


def _u32(data, off):
    return struct.unpack_from("<I", data, off)[0]


def _sum(data):
    return sum(data) & 0xFFFFFFFF


def find_block(data):
    """Tra ve (offset, size) cua bootconfig, hoac None neu khong hieu layout."""
    off = data.rfind(MAGIC)
    if off < 0:
        return None
    if len(data) < len(MAGIC) + 8:
        return None
    size = _u32(data, len(data) - 4)
    if size < len(MAGIC) + 8 or size > len(data):
        return None
    if off + size != len(data):
        return None
    return off, size


def parse_block(blob):
    """blob = toan bo block (magic..size). Tra ve (list dong, ok_checksum)."""
    size = len(blob)
    body = blob[: size - 8]
    want = _u32(blob, size - 8)
    ok = _sum(body) == want
    text = body[len(MAGIC):].decode("utf-8", "replace")
    lines = [ln for ln in text.split("\n")]
    return lines, ok


def build_block(params):
    """params: list dong 'key = value'. Tra ve block hoan chinh."""
    body = bytearray(MAGIC)
    for ln in params:
        body += ln.encode("utf-8") + b"\n"
    while len(body) % ALIGN:
        body += b"\n"
    block = bytearray(body)
    block += struct.pack("<I", _sum(body))
    block += struct.pack("<I", len(block) + 4)
    return bytes(block)


def patch_params(lines, wanted):
    """Thay gia tri key da co, giu nguyen moi thu khac; thieu thi noi vao cuoi."""
    out, seen = [], set()
    for ln in lines:
        s = ln.strip()
        if not s or s.startswith("#"):
            out.append(ln)
            continue
        key = s.split("=", 1)[0].strip() if "=" in s else None
        if key in wanted:
            out.append("%s = %s" % (key, wanted[key]))
            seen.add(key)
        else:
            out.append(ln)
    for key, val in wanted.items():
        if key not in seen:
            out.append("%s = %s" % (key, val))
    while out and out[-1] == "":
        out.pop()
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("image")
    ap.add_argument("--apply", action="store_true",
                    help="ghi thay doi (mac dinh chi kiem tra)")
    ap.add_argument("--no-backup", action="store_true")
    args = ap.parse_args()

    with open(args.image, "rb") as f:
        data = f.read()

    found = find_block(data)
    if not found:
        print("FAIL: khong thay block '#BOOTCONFIG' o cuoi %s" % args.image)
        print("      (bootconfig co the nam giua image, hoac kernel khong bat "
              "CONFIG_BOOT_CONFIG)")
        return 2
    off, size = found

    lines, ok = parse_block(data[off:off + size])
    if not ok:
        print("FAIL: checksum cua block goc KHONG khop -> khong hieu layout, "
              "khong ghi gi")
        print("      offset=%d size=%d" % (off, size))
        return 2

    print("OK: bootconfig @%d, %d byte, checksum hop le" % (off, size))
    for ln in lines:
        if ln.strip():
            print("   | " + ln)

    new_params = patch_params(lines, WANTED)
    new_block = build_block(new_params)

    # tu kiem tra block moi truoc khi ghi
    chk_lines, chk_ok = parse_block(new_block)
    if not chk_ok or find_block(data[:off] + new_block) is None:
        print("FAIL: block moi khong round-trip duoc - khong ghi")
        return 2

    changed = [k for k in WANTED if ("%s = %s" % (k, WANTED[k])) not in
               [x.strip() for x in lines]]
    if not changed and len(new_block) == size:
        print("SKIP: ca 3 key da dung gia tri, khong can ghi")
        return 0

    print("SUA: " + ", ".join(changed) if changed else "SUA: chuan hoa padding")

    if not args.apply:
        print("DRY-RUN: them --apply de ghi")
        return 0

    if not args.no_backup:
        bak = args.image + ".bootconfig.bak"
        shutil.copy2(args.image, bak)
        print("backup: " + bak)

    with open(args.image, "wb") as f:
        f.write(data[:off] + new_block)

    with open(args.image, "rb") as f:
        after = f.read()
    chk = find_block(after)
    if not chk:
        print("FAIL: doc lai khong thay block - file co the hong")
        return 3
    a_lines, a_ok = parse_block(after[chk[0]:chk[0] + chk[1]])
    if not a_ok:
        print("FAIL: checksum sau khi ghi khong hop le")
        return 3
    got = {ln.split("=", 1)[0].strip(): ln.split("=", 1)[1].strip()
           for ln in a_lines if "=" in ln}
    for k, v in WANTED.items():
        if got.get(k) != v:
            print("FAIL: %s = %r (mong doi %r)" % (k, got.get(k), v))
            return 3
    print("DONE: da ghi va verify lai")
    return 0


if __name__ == "__main__":
    sys.exit(main())
