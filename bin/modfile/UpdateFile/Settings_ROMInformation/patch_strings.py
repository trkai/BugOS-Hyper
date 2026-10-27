#!/usr/bin/env python3
"""Đổi chữ "Xiaomi HyperOS" trong resource thành "Xiaomi BugOS".

Trang Giới thiệu điện thoại của HyperOS có 2 khả năng:
  a) header là ảnh/vector  -> đã xử lý ở nhánh drawable
  b) header là TextView dùng string resource -> script này

Với (b) không thể tô 2 màu bằng XML thường. Android có parse <b>/<i>/<u>/
<font color> trong string resource, NHƯNG chỉ khi TextView lấy text qua
Resources.getText() (tức là android:text="@string/x" trong layout, hoặc
setText(resId)). Nếu code gọi setText(getString(...)) thì markup sẽ hiện
nguyên văn -> xấu. Vì vậy chỉ dùng markup khi string đó THỰC SỰ được tham
chiếu từ một layout xml.

Usage: patch_strings.py <res_dir> [--dry]
"""
import os
import re
import sys

BRAND = "Xiaomi Bug"
OS = "OS"
OS_COLOR = "#2E54A1"

# Chỉ đụng vào string mà TOÀN BỘ nội dung là wordmark, tránh thay bừa
WORDMARK_RE = re.compile(r"^\s*(Xiaomi\s+)?HyperOS\s*(\d+(?:\.\d+)*)?\s*$", re.I)
# Dùng để báo cáo: mọi string có nhắc HyperOS
ANY_RE = re.compile(r"HyperOS", re.I)


def read(p):
    try:
        with open(p, "r", encoding="utf-8", errors="replace") as f:
            return f.read()
    except OSError:
        return ""


def layouts_referencing(res, name):
    """Có layout xml nào dùng @string/<name> không."""
    needle = "@string/" + name
    for d in sorted(os.listdir(res)):
        if not d.startswith("layout"):
            continue
        sub = os.path.join(res, d)
        if not os.path.isdir(sub):
            continue
        for fn in os.listdir(sub):
            if fn.endswith(".xml") and needle in read(os.path.join(sub, fn)):
                return os.path.join(d, fn)
    return None


def main():
    if len(sys.argv) < 2:
        print("usage: patch_strings.py <res_dir> [--dry]")
        return 2
    res = sys.argv[1]
    dry = "--dry" in sys.argv

    changed, reported = 0, 0
    for d in sorted(os.listdir(res)):
        if not d.startswith("values"):
            continue
        f = os.path.join(res, d, "strings.xml")
        if not os.path.isfile(f):
            continue
        body = read(f)
        if not ANY_RE.search(body):
            continue

        def repl(m):
            nonlocal changed, reported
            name, value = m.group(1), m.group(2)
            if not ANY_RE.search(value):
                return m.group(0)
            reported += 1
            if not WORDMARK_RE.match(value):
                print(f"  [skip] {d}/{name} = {value!r} (không phải wordmark thuần)")
                return m.group(0)

            wm = WORDMARK_RE.match(value)
            ver = (wm.group(2) or "").strip() if wm else ""
            tail = (" " + ver) if ver else ""

            lay = layouts_referencing(res, name)
            if lay:
                new = f'{BRAND}<font color="{OS_COLOR}">{OS}</font>{tail}'
                how = f"layout {lay}"
            else:
                new = BRAND + OS + tail
                how = "plain (không thấy layout tham chiếu)"
            changed += 1
            print(f"  [ok]   {d}/{name}: {value!r} -> {new!r}  [{how}]")
            return m.group(0).replace(f'>{value}<', f'>{new}<', 1)

        new_body = re.sub(r'<string name="([^"]+)"[^>]*>(.*?)</string>', repl, body, flags=re.S)
        if new_body != body and not dry:
            with open(f, "w", encoding="utf-8", newline="\n") as fh:
                fh.write(new_body)

    print(f"strings: {reported} chứa HyperOS, {changed} đã đổi")
    return 0 if changed else 1


if __name__ == "__main__":
    sys.exit(main())
