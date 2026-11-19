#!/usr/bin/env python3
"""Áp bảng patch method vào một cây smali đã decompile.

    python3 apply_patches.py <smali_tree> <patch.json> [-v|--verbose]

Không có -v (mặc định khi build): chỉ in cảnh báo THIẾU ra stderr, im lặng khi
áp đủ. Caller đã in "Tên.apk: vá N dex" nên không cần thêm.

Với mỗi entry trong JSON:
  - "_newfile": ghi nguyên nội dung thành file mới (đường dẫn tương đối rel).
  - "methods": tìm .method có chữ ký khớp trong cây, thay toàn bộ thân
    (.method ... .end method) bằng thân trong JSON.

So khớp chữ ký theo TÊN + KIỂU THAM SỐ + KIỂU TRẢ VỀ ở cuối dòng .method, bỏ
qua access flag (public/private/blacklist...) để không lệch khi Xiaomi đổi.

Thoát 0 nếu áp được hết, 2 nếu có method không tìm thấy (đã in danh sách).
"""
import json
import os
import re
import sys

SIG_RE = re.compile(r'^\s*\.method\s+(.*)$')


def sig_of(line):
    """.method public blacklist foo(I)V  ->  'foo(I)V'"""
    m = SIG_RE.match(line)
    if not m:
        return None
    parts = m.group(1).strip().split()
    return parts[-1] if parts else None


def key_sig(key):
    """Key trong JSON có thể kèm access flag: 'private foo(I)V' -> 'foo(I)V'."""
    parts = key.split()
    return parts[-1] if parts else key


def apply_file(path, entry):
    """Trả về (áp được, thiếu)."""
    if entry.get('_newfile'):
        os.makedirs(os.path.dirname(path) or '.', exist_ok=True)
        with open(path, 'w', encoding='utf-8', newline='\n') as f:
            f.write(entry['_body'])
        return 1, []

    if not os.path.exists(path):
        return 0, [key_sig(k) for k in entry.get('methods', {})]

    lines = open(path, encoding='utf-8', errors='ignore').read().splitlines()
    want = {key_sig(k): v for k, v in entry.get('methods', {}).items()}
    add = {key_sig(k): v for k, v in entry.get('added', {}).items()}
    out = []
    i = 0
    done = 0
    n = len(lines)
    while i < n:
        ln = lines[i]
        s = sig_of(ln)
        if s is not None and s in want:
            # thay nguyên method: bỏ .method..end method cũ, ghi thân mới
            out.extend(want.pop(s))
            done += 1
            # bỏ tới .end method
            while i < n and lines[i].strip() != '.end method':
                i += 1
            i += 1  # bỏ chính dòng .end method
            continue
        if s is not None and s in add:
            # method này đã có sẵn trong file -> không thêm trùng, chỉ tính là khớp
            add.pop(s)
            done += 1
        out.append(ln)
        i += 1

    # method mới: nối vào cuối file (smali không bắt buộc thứ tự method)
    appended = 0
    if add:
        if out and out[-1].strip():
            out.append('')
        for body in add.values():
            out.extend(body)
            out.append('')
            appended += 1

    if done or appended:
        with open(path, 'w', encoding='utf-8', newline='\n') as f:
            f.write('\n'.join(out).rstrip('\n') + '\n')
    return done + appended, list(want.keys())


def main():
    if len(sys.argv) < 3:
        sys.stderr.write('dùng: apply_patches.py <smali_tree> <patch.json> [-v]\n')
        return 1
    tree, json_path = sys.argv[1], sys.argv[2]
    # --verbose (hoặc DEBUG=1) mới in dòng tổng kết từng file. Xem ghi chú ở cuối.
    verbose = ('-v' in sys.argv[3:] or '--verbose' in sys.argv[3:]
               or os.environ.get('DEBUG') == '1')
    with open(json_path, encoding='utf-8') as f:
        patch = json.load(f)

    total_ok = 0
    total_new = 0
    missing = []

    # quét 1 lần: map "phần đuôi đường dẫn" -> đường dẫn thật, tránh listdir lặp
    index = {}
    subs = []
    for name in sorted(os.listdir(tree)):
        full = os.path.join(tree, name)
        if os.path.isdir(full):
            subs.append(full)
    for dirpath, _, files in os.walk(tree):
        for fn in files:
            if not fn.endswith('.smali'):
                continue
            full = os.path.join(dirpath, fn)
            rel = os.path.relpath(full, tree).replace(os.sep, '/')
            index[rel] = full
            # bản không có tiền tố thư mục con (classes_out/...)
            parts = rel.split('/')
            if len(parts) > 1:
                index.setdefault('/'.join(parts[1:]), full)
    base_for_new = subs[0] if subs else tree

    for rel, entry in patch.items():
        target = index.get(rel)
        if target is None:
            target = os.path.join(base_for_new, rel.replace('/', os.sep))

        ok, miss = apply_file(target, entry)
        if entry.get('_newfile'):
            total_new += 1
        else:
            total_ok += ok
            if miss:
                missing.append((rel, miss))

    # Dòng tổng kết chỉ in khi cần: script này được gọi 1 lần cho MỖI file trong
    # mỗi APK (PRECHINAFIX 69 file + FEATURE_UNLOCK 22 file), nên log build thật
    # có ~20 dòng "[apply_patches] method áp được: N" xen giữa log có tiền tố.
    # Caller đã in "MiuiSystemUI.apk: vá 2 dex" - đủ thông tin ở mức bình thường.
    if verbose:
        print('[apply_patches] method áp được: {} | file mới: {}'.format(total_ok, total_new))
    if missing:
        # THIẾU thì luôn phải thấy: đó là patch không áp được, không phải chi tiết.
        print('[apply_patches] THIẾU {} file:'.format(len(missing)), file=sys.stderr)
        for rel, ms in missing:
            print('  {} ({} method)'.format(rel, len(ms)), file=sys.stderr)
            for m in ms[:3]:
                print('      - ' + m[:90], file=sys.stderr)
        return 2
    return 0


if __name__ == '__main__':
    sys.exit(main())
