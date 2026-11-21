#!/usr/bin/env python3
"""Sinh bảng patch method từ hai cây smali (gốc vs đã vá).

    python3 gen_patches.py <old_tree> <new_tree> <out.json>

Với mỗi file .smali khác nhau, so từng method: method nào có thân khác thì lưu
thân MỚI vào JSON. File mới (chỉ có ở new) được đánh dấu NEWFILE để chép nguyên.

Vì sao lưu thân method thay vì diff dòng: sau khi baksmali lại, số label
(:cond_1b) và số register đổi theo phiên bản smali, nên diff dòng rất dễ lệch.
Thân method thì thay được nguyên khối vào file gốc mà không phụ thuộc label
bên ngoài (label chỉ có nghĩa trong phạm vi một method).
"""
import json
import os
import re
import sys

META_RE = re.compile(r'\s*\.(line|local|param|prologue|end local|source|restart)\b')


def read_methods(path):
    """Trả về dict: signature -> list dòng thân (gồm .method ... .end method)."""
    try:
        lines = open(path, encoding='utf-8', errors='ignore').read().splitlines()
    except OSError:
        return None
    out = {}
    cur = None
    buf = []
    for ln in lines:
        if cur is None:
            m = re.match(r'\s*\.method\s+(.*)$', ln)
            if m:
                cur = m.group(1).strip()
                buf = [ln]
            continue
        buf.append(ln)
        if ln.strip() == '.end method':
            key = cur
            n = 1
            while key in out:  # overload trùng chữ ký (hiếm): đánh số
                key = '{}\x00{}'.format(cur, n)
                n += 1
            out[key] = buf
            cur = None
    return out


def strip_meta(body):
    """Bỏ .line/.local/... để so sánh chỉ phần thực thi."""
    return [ln.rstrip() for ln in body if ln.strip() and not META_RE.match(ln)]


def norm_labels(body):
    """Bình thường hoá số hiệu label để so sánh."""
    out = []
    for ln in body:
        ln = re.sub(r'(:[A-Za-z_]+_)[0-9a-f]+', r'\1#', ln)
        out.append(ln)
    return out


def main():
    old_root, new_root, out_path = sys.argv[1], sys.argv[2], sys.argv[3]
    patch = {}

    for dirpath, _, files in os.walk(new_root):
        for fn in files:
            if not fn.endswith('.smali'):
                continue
            npth = os.path.join(dirpath, fn)
            rel = os.path.relpath(npth, new_root).replace('\\', '/')
            opth = os.path.join(old_root, os.path.relpath(npth, new_root))

            if not os.path.exists(opth):
                patch[rel] = {'_newfile': True,
                              '_body': open(npth, encoding='utf-8', errors='ignore').read()}
                continue

            om = read_methods(opth)
            nm = read_methods(npth)
            if om is None or nm is None or om == nm:
                continue

            methods = {}
            added = {}
            for sig, nbody in nm.items():
                obody = om.get(sig)
                if obody is None:
                    added[sig] = nbody          # method mới thêm
                elif norm_labels(strip_meta(obody)) != norm_labels(strip_meta(nbody)):
                    methods[sig] = nbody        # thân đổi THẬT (không chỉ label)
            entry = {}
            if methods:
                entry['methods'] = methods
            if added:
                entry['added'] = added
            if entry:
                patch[rel] = entry

    os.makedirs(os.path.dirname(out_path) or '.', exist_ok=True)
    with open(out_path, 'w', encoding='utf-8') as f:
        json.dump(patch, f, ensure_ascii=False, indent=1)

    nfiles = len(patch)
    nmeth = sum(len(v.get('methods', {})) for v in patch.values())
    nadd = sum(len(v.get('added', {})) for v in patch.values())
    nnew = sum(1 for v in patch.values() if v.get('_newfile'))
    print('files: {} | methods: {} | added: {} | new files: {} | {} KB'.format(
        nfiles, nmeth, nadd, nnew, os.path.getsize(out_path) // 1024))


if __name__ == '__main__':
    main()
