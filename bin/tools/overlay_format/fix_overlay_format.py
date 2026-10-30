#!/usr/bin/env python3
"""Chuyển placeholder số (%d, %i, %f, %x, %o) thành %s trong values-vi của overlay RRO.

Vì sao: Java Formatter ném IllegalFormatConversionException khi format %d mà
tham số là String. HyperOS 4 truyền String ở một số chuỗi (ví dụ pin SystemUI:
"Đang sạc %d%%" -> crash), trong khi %s nhận được cả int, float và String.
Đổi sang %s chỉ mất định dạng số (padding, số lẻ) - không bao giờ crash.

Giữ nguyên:
  - chỉ số tham số:  %1$d  ->  %1$s
  - cờ %%           :  %d%%  ->  %s%%   (%% là dấu % literal, không phải tham số)
  - mọi ngôn ngữ khác ngoài values-vi (chỉ đụng values-vi)

Usage:
  fix_overlay_format.py <overlay.apk> [--dry] [--out <path>]
  fix_overlay_format.py --dir <thu_muc_overlay> [--dry] [--jobs N]
"""
import os
import re
import shutil
import subprocess
import sys
import tempfile
import zipfile

JAVA_HOME = os.environ.get("JAVA_HOME", "")
TOOLS = None  # set from --tools
KEYSTORE = None
KS_PASS = "bugos123"


def run(cmd, **kw):
    return subprocess.run(cmd, shell=isinstance(cmd, str), capture_output=True, text=True, **kw)


def java_bin(name):
    return os.path.join(JAVA_HOME, "bin", name) if JAVA_HOME else name


# %[arg$][flags][width][.precision][t]conversion
FMT = re.compile(r"%(\d+\$)?([-#+ 0,(<]*)(\d+)?(\.\d+)?([a-zA-Z%])")


def convert(fmt):
    """Đổi conversion số -> s, giữ arg index / cờ / width."""
    def repl(m):
        idx, flags, width, prec, conv = m.groups()
        if conv in "difxXoeEgGaA":
            # giữ width nếu là số thuần (padding vẫn hợp lệ với %s),
            # bỏ .precision vì %s.precision cắt chuỗi chứ không làm tròn
            w = width or ""
            return f"%{idx or ''}{flags or ''}{w}s"
        return m.group(0)
    return FMT.sub(repl, fmt)


def process(apk, dry=False, out=None):
    tmp = tempfile.mkdtemp(prefix="ovl_")
    dec = os.path.join(tmp, "d")
    try:
        r = run([java_bin("java"), "-jar", os.path.join(TOOLS, "apke.jar"),
                 "d", "-f", "-i", apk, "-o", dec])
        if r.returncode != 0:
            return False, f"decode lỗi: {r.stderr.strip()[:120]}"

        sf = os.path.join(dec, "resources", "package_1", "res", "values-vi", "strings.xml")
        if not os.path.isfile(sf):
            return False, "không có values-vi"
        body = open(sf, encoding="utf-8").read()

        changed = []

        def fix(m):
            name, val = m.group(1), m.group(2)
            new = convert(val)
            if new != val:
                changed.append((name, val, new))
            return m.group(0).replace(f">{val}<", f">{new}<", 1)

        body2 = re.sub(r'<string name="([^"]+)"[^>]*>(.*?)</string>', fix, body, flags=re.S)
        if not changed:
            return True, "không có gì để đổi"
        if dry:
            for n, o, x in changed[:5]:
                print(f"    {n}: {o[:50]!r} -> {x[:50]!r}")
            return True, f"[dry] sẽ đổi {len(changed)} string"

        open(sf, "w", encoding="utf-8", newline="\n").write(body2)

        built = os.path.join(tmp, "u.apk")
        r = run([java_bin("java"), "-jar", os.path.join(TOOLS, "apke.jar"),
                 "b", "-f", "-i", dec, "-o", built])
        if r.returncode != 0 or not os.path.isfile(built):
            return False, f"build lỗi: {r.stderr.strip()[:120]}"

        # bỏ chữ ký cũ (đã invalid sau khi sửa)
        stripped = os.path.join(tmp, "u2.apk")
        with zipfile.ZipFile(built) as zi, zipfile.ZipFile(stripped, "w", zipfile.ZIP_DEFLATED) as zo:
            for it in zi.infolist():
                if not it.filename.startswith("META-INF/"):
                    zo.writestr(it, zi.read(it.filename))

        signed = out or apk
        r = run([java_bin("java"), "-jar", os.path.join(TOOLS, "apksigner.jar"), "sign",
                 "--ks", KEYSTORE, "--ks-pass", f"pass:{KS_PASS}",
                 "--key-pass", f"pass:{KS_PASS}", "--min-sdk-version", "24",
                 "--out", signed, stripped])
        if r.returncode != 0:
            return False, f"sign lỗi: {r.stderr.strip()[:120]}"

        v = run([java_bin("java"), "-jar", os.path.join(TOOLS, "apksigner.jar"),
                 "verify", "--min-sdk-version", "24", signed])
        if v.returncode != 0:
            return False, "verify chữ ký thất bại"
        return True, f"đổi {len(changed)} string, đã ký lại"
    finally:
        shutil.rmtree(tmp, ignore_errors=True)


def main():
    global TOOLS, KEYSTORE
    args = sys.argv[1:]
    dry = "--dry" in args
    args = [a for a in args if a != "--dry"]

    here = os.path.dirname(os.path.abspath(__file__))
    TOOLS = os.path.join(here, "..", "..", "apktool")
    TOOLS = os.path.normpath(TOOLS)
    KEYSTORE = os.path.join(here, "bugos.jks")
    if not os.path.isfile(KEYSTORE):
        print(f"thiếu keystore: {KEYSTORE}", file=sys.stderr)
        return 2

    if "--dir" in args:
        d = args[args.index("--dir") + 1]
        apks = sorted(os.path.join(d, f) for f in os.listdir(d) if f.endswith(".apk"))
    else:
        if not args:
            print(__doc__)
            return 2
        apks = [args[0]]

    ok = 0
    for apk in apks:
        name = os.path.basename(apk)
        good, msg = process(apk, dry)
        print(f"{'OK  ' if good else 'FAIL'} {name}: {msg}")
        ok += 1 if good else 0
    print(f"\n{ok}/{len(apks)} thành công")
    return 0 if ok == len(apks) else 1


if __name__ == "__main__":
    sys.exit(main())
