#!/usr/bin/env python3
"""Đổi chữ "Xiaomi HyperOS" -> "Xiaomi BugOS", và ẩn dòng version dưới logo.

Hai chế độ:

  patch_strings.py <res_dir> [--dry]
      Đổi string wordmark. Chỉ đụng string mà TOÀN BỘ giá trị khớp
      "Xiaomi HyperOS" (kèm version nếu có). Nếu string đó được layout tham
      chiếu thì dùng <font color> để "OS" xanh (Resources.getText() parse được
      markup; setText(getString()) thì không, nên chỉ dùng khi chắc chắn có
      layout tham chiếu). Đồng thời ẩn dòng version ngay dưới logo.

  patch_strings.py <res_dir> --hide-drawables name1,name2,...
      Chỉ ẩn dòng version. Dùng khi logo là DRAWABLE
      (res/drawable/xiaomi_os_logo...): tìm layout tham chiếu @drawable/<name>
      rồi ẩn TextView version đứng sau nó.

      Đây là trường hợp THỰC TẾ trên HyperOS 3 - nếu chỉ chạy ở chế độ string
      thì dòng version sẽ không bao giờ được ẩn, vì nhánh drawable đã thắng.

Quy tắc chọn TextView để ẩn (an toàn, không đoán bừa):
  1. TextView đầu tiên sau logo có id chứa "version"
  2. nếu sau logo chỉ có ĐÚNG MỘT TextView không có android:text tĩnh
  3. không khớp -> không đụng gì, in danh sách id ra log
"""
import os
import re
import sys

BRAND = "Xiaomi Bug"
OS = "OS"
OS_COLOR = "#2E54A1"

WORDMARK_RE = re.compile(r"^\s*(Xiaomi\s+)?HyperOS\s*(\d+(?:\.\d+)*)?\s*$", re.I)
ANY_RE = re.compile(r"HyperOS", re.I)

VER_ID_RE = re.compile(r"(?i)version")
TAG_RE = re.compile(r"<(TextView|com\.miuix\.androidx\.preference\.internal\.(?:Card)?TextView|"
                    r"androidx\.appcompat\.widget\.AppCompatTextView)\b[^>]*?/?>", re.S)
ID_RE = re.compile(r'android:id="@\+?id/([A-Za-z0-9_]+)"')
TEXT_RE = re.compile(r'android:text="@string/([A-Za-z0-9_]+)"')


def read(p):
    try:
        with open(p, "r", encoding="utf-8", errors="replace") as f:
            return f.read()
    except OSError:
        return ""


def layout_dirs(res):
    for d in sorted(os.listdir(res)):
        if d.startswith("layout"):
            sub = os.path.join(res, d)
            if os.path.isdir(sub):
                for fn in sorted(os.listdir(sub)):
                    if fn.endswith(".xml"):
                        yield os.path.join(d, fn)


def layouts_with(res, needle):
    """Các layout chứa chuỗi needle (vd '@drawable/xiaomi_os_logo')."""
    out = []
    for rel in layout_dirs(res):
        if needle in read(os.path.join(res, rel)):
            out.append(rel)
    return out


def _add_gone(block):
    """Thêm android:visibility="gone" vào thẻ, giữ nguyên kiểu thẻ."""
    if block.rstrip().endswith("/>"):
        return block[:-2] + ' android:visibility="gone"' + block[-2:]
    return block[:-1] + ' android:visibility="gone">'


def _write_validated(path, body):
    """Ghi sau khi chắc chắn XML vẫn hợp lệ."""
    try:
        import xml.etree.ElementTree as ET
        ET.fromstring(body)
    except Exception as e:
        return False, f"XML hỏng sau khi sửa, bỏ qua ({e})"
    with open(path, "w", encoding="utf-8", newline="\n") as fh:
        fh.write(body)
    return True, ""


def hide_after_anchor(layout_path, anchor, dry=False):
    """Ẩn TextView version đứng sau phần tử chứa `anchor` trong layout."""
    body = read(layout_path)
    if not body:
        return False, "không đọc được layout"

    elems = list(TAG_RE.finditer(body))
    if not elems:
        return False, "layout không có TextView"

    # Logo có thể là ImageView (android:src="@drawable/...") chứ không phải
    # TextView, nên xác định vị trí theo offset ký tự rồi lấy TextView đầu tiên
    # nằm SAU đó.
    anchor_pos = body.find(anchor)
    if anchor_pos < 0:
        return False, f"không thấy {anchor} trong layout"

    # anchor_idx = index của TextView cuối cùng nằm TRƯỚC logo; -1 nếu logo
    # đứng trước mọi TextView. elems[anchor_idx + 1:] là các TextView sau logo.
    anchor_idx = len(elems) - 1
    for i, m in enumerate(elems):
        if m.start() > anchor_pos:
            anchor_idx = i - 1
            break

    cands, no_text = [], []
    for m in elems[anchor_idx + 1:]:
        block = m.group(0)
        idm = ID_RE.search(block)
        cands.append(idm.group(1) if idm else "(no-id)")
        if not TEXT_RE.search(block):
            no_text.append(m)
        if idm and VER_ID_RE.search(idm.group(1)):
            if dry:
                return True, f"[dry] sẽ ẩn @id/{idm.group(1)}"
            ok, err = _write_validated(layout_path, body[:m.start()] + _add_gone(block) + body[m.end():])
            return (True, f"đã ẩn @id/{idm.group(1)}") if ok else (False, err)

    if len(no_text) == 1:
        m = no_text[0]
        if dry:
            return True, "[dry] sẽ ẩn TextView không có text tĩnh duy nhất sau logo"
        ok, err = _write_validated(layout_path, body[:m.start()] + _add_gone(m.group(0)) + body[m.end():])
        return (True, "đã ẩn TextView không có text tĩnh duy nhất sau logo") if ok else (False, err)

    return False, "không có id dạng version; ứng viên: " + ", ".join(cands[:10])


def do_hide_drawables(res, names, dry=False):
    done = 0
    for name in names:
        name = name.strip()
        if not name:
            continue
        for kind in ("@drawable/", "@mipmap/"):
            for lay in layouts_with(res, kind + name):
                ok, msg = hide_after_anchor(os.path.join(res, lay), kind + name, dry)
                print(f"  [hide] {lay} ({kind}{name}): {'OK' if ok else 'BỎ QUA'} - {msg}")
                if ok:
                    done += 1
    if done == 0:
        print("  [hide] không ẩn được dòng version nào")
    return 0 if done else 1


def do_strings(res, dry=False):
    changed = 0
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
            nonlocal changed
            name, value = m.group(1), m.group(2)
            if not ANY_RE.search(value):
                return m.group(0)
            wm = WORDMARK_RE.match(value)
            if not wm:
                print(f"  [skip] {d}/{name} = {value!r} (không phải wordmark thuần)")
                return m.group(0)

            ver = (wm.group(2) or "").strip()
            tail = (" " + ver) if ver else ""
            lays = layouts_with(res, "@string/" + name)

            if lays:
                new = f'{BRAND}<font color="{OS_COLOR}">{OS}</font>{tail}'
                how = f"layout {lays[0]}"
            else:
                new = BRAND + OS + tail
                how = "plain (không thấy layout tham chiếu)"

            changed += 1
            print(f"  [ok]   {d}/{name}: {value!r} -> {new!r}  [{how}]")

            if lays and not dry:
                for lay in lays:
                    ok, msg = hide_after_anchor(os.path.join(res, lay), "@string/" + name)
                    print(f"         ẩn dòng version: {'OK' if ok else 'BỎ QUA'} - {msg}")

            return m.group(0).replace(f'>{value}<', f'>{new}<', 1)

        new_body = re.sub(r'<string name="([^"]+)"[^>]*>(.*?)</string>', repl, body, flags=re.S)
        if new_body != body and not dry:
            with open(f, "w", encoding="utf-8", newline="\n") as fh:
                fh.write(new_body)

    print(f"strings: {changed} đã đổi")
    return 0 if changed else 1


def main():
    if "--hide-drawables" in sys.argv:
        i = sys.argv.index("--hide-drawables")
        res = sys.argv[1] if len(sys.argv) > 1 else ""
        names = sys.argv[i + 1].split(",") if i + 1 < len(sys.argv) else []
        if not res or not os.path.isdir(res):
            print("res_dir không hợp lệ")
            return 2
        return do_hide_drawables(res, names, "--dry" in sys.argv)

    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    if not args:
        print(__doc__)
        return 2
    return do_strings(args[0], "--dry" in sys.argv)


if __name__ == "__main__":
    sys.exit(main())
