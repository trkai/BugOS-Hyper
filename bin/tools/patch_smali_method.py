#!/usr/bin/env python3
"""Thay thân một method smali bằng hằng số trả về.

    python3 patch_smali_method.py <file.smali> <ten_method> <kieu_tra_ve> <gia_tri>

Ví dụ:
    # isGmsControlEnabled()Z -> false
    python3 patch_smali_method.py GmsObserver.smali isGmsControlEnabled Z 0

Vì sao không dùng sed theo mẫu thân hàm: thân hàm đổi giữa các bản ROM, còn
chữ ký method thì ổn định. Ở đây chỉ cần đúng tên + kiểu trả về.

Trả về 0 nếu vá được, 1 nếu không tìm thấy (không sửa gì).
"""
import re
import sys

METHOD_RE = r'\.method[^\n]*\b{name}\('
END_RE = r'\.end method'


def patch(path, name, ret, value):
    with open(path, encoding='utf-8') as f:
        lines = f.read().splitlines()

    start = None
    for i, ln in enumerate(lines):
        if re.match(r'\s*\.method\b', ln) and re.search(r'\b%s\(' % re.escape(name), ln):
            # kiểm tra kiểu trả về ở cuối chữ ký
            if ln.rstrip().endswith(')' + ret):
                start = i
                break
    if start is None:
        return False

    end = None
    for j in range(start + 1, len(lines)):
        if re.match(r'\s*\.end method\b', lines[j]):
            end = j
            break
    if end is None:
        return False

    if ret == 'V':
        body = ['    .locals 0', '    return-void']
    elif ret in ('Z', 'B', 'S', 'C', 'I'):
        body = ['    .locals 1', '    const/4 v0, 0x%s' % format(int(value), 'x'),
                '    return v0']
    elif ret in ('J',):
        body = ['    .locals 2', '    const-wide/16 v0, 0x%s' % format(int(value), 'x'),
                '    return-wide v0']
    elif ret in ('F',):
        body = ['    .locals 1', '    const/4 v0, 0x0', '    return v0']
    else:  # object
        body = ['    .locals 1', '    const/4 v0, 0x0', '    return-object v0']

    new = lines[:start + 1] + body + lines[end:]
    with open(path, 'w', encoding='utf-8', newline='\n') as f:
        f.write('\n'.join(new) + '\n')
    return True


def main():
    if len(sys.argv) != 5:
        print(__doc__)
        return 2
    ok = patch(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])
    if not ok:
        print(f'không thấy method {sys.argv[2]}(...){sys.argv[3]}', file=sys.stderr)
        return 1
    print(f'patched {sys.argv[2]} -> {sys.argv[4]}')
    return 0


if __name__ == '__main__':
    sys.exit(main())
