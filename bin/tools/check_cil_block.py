#!/usr/bin/env python3
"""Kiem tra khoi CIL ma BugOS them vao plat_sepolicy.cil.

Vi sao khong dung secilc: policy cua ROM co permissionx kind "nlmsg"
(app_neverallows.te:151), ma secilc 3.5 cua Ubuntu khong biet kind do - no chet
o dong 16237, truoc ca khoi cua minh. Khong co ban secilc moi hon trong repo
Ubuntu nay. Chi secilc tren may moi xac nhan duoc policy dung duoc luc boot.

Nen script nay chi kiem nhung loi da tung lam brick may:
  1. dung '#' lam comment (CIL dung ';')      -> "Symbol not inside parenthesis"
  2. ngoac lech
  3. type / attribute / role / class khong ton tai trong policy
  4. quyen khong co trong khai bao class

Dung: python3 check_cil_block.py <plat_sepolicy.cil>
Thoat 0 = khong thay khoi, hoac khoi hop le. Thoat 1 = khoi sai.
"""
from __future__ import annotations

import re
import sys

BEGIN = "; BUGOS-KAORIOS-BEGIN"
END = "; BUGOS-KAORIOS-END"


def main() -> int:
    if len(sys.argv) != 2:
        print("dung: check_cil_block.py <plat_sepolicy.cil>", file=sys.stderr)
        return 2

    with open(sys.argv[1], encoding="utf-8", errors="replace") as fh:
        cil = fh.read()

    if BEGIN not in cil:
        print(f"không có {BEGIN} - bỏ qua (kaorios_service_policy=false)")
        return 0
    if END not in cil:
        print(f"có {BEGIN} nhưng thiếu {END} - khối bị cắt cụt", file=sys.stderr)
        return 1

    block = cil[cil.index(BEGIN): cil.index(END) + len(END)]

    errors: list[str] = []
    stmts: list[tuple[int, str]] = []

    for n, raw in enumerate(block.splitlines(), 1):
        line = raw.strip()
        if not line or line.startswith(";"):
            continue
        if "#" in line:
            errors.append(f"dòng {n}: có '#'. CIL dùng ';' cho comment -> {line!r}")
            continue
        if not (line.startswith("(") and line.endswith(")")):
            errors.append(f"dòng {n}: không phải form ngoặc -> {line!r}")
            continue
        depth = 0
        bad = False
        for ch in line:
            if ch == "(":
                depth += 1
            elif ch == ")":
                depth -= 1
                if depth < 0:
                    bad = True
                    break
        if bad or depth != 0:
            errors.append(f"dòng {n}: ngoặc không cân bằng -> {line!r}")
            continue
        stmts.append((n, line))

    types = set(re.findall(r"^\(type\s+([A-Za-z0-9_]+)\)", cil, re.M))
    attrs = set(re.findall(r"^\(typeattribute\s+([A-Za-z0-9_]+)\)", cil, re.M))
    roles = set(re.findall(r"^\(role\s+([A-Za-z0-9_]+)\)", cil, re.M))

    def class_perms(cls: str) -> set[str]:
        m = re.search(rf"^\(class\s+{cls}\s+\(([^)]*)\)\)", cil, re.M)
        return set(m.group(1).split()) if m else set()

    svc_perms = class_perms("service_manager")
    binder_perms = class_perms("binder")
    if not svc_perms:
        errors.append("không tìm thấy (class service_manager ...) trong policy")
    if not binder_perms:
        errors.append("không tìm thấy (class binder ...) trong policy")

    def need_type(n: int, name: str) -> None:
        if name not in types:
            errors.append(f"dòng {n}: type '{name}' không có trong policy")

    for n, line in stmts:
        m = re.match(r"^\(allow\s+(\S+)\s+(\S+)\s+\((\w+)\s+\(([^)]*)\)\)\)$", line)
        if m:
            src, tgt, cls, perms = m.groups()
            need_type(n, src)
            need_type(n, tgt)
            known = {"service_manager": svc_perms, "binder": binder_perms}.get(cls)
            if known is None:
                errors.append(f"dòng {n}: class '{cls}' chưa được bước kiểm này hỗ trợ")
            else:
                for p in perms.split():
                    if p not in known:
                        errors.append(f"dòng {n}: class {cls} không có quyền '{p}'")
            continue

        m = re.match(r"^\(typeattributeset\s+(\S+)\s+\(([^)]*)\)\)$", line)
        if m:
            attr, members = m.groups()
            if attr not in attrs:
                errors.append(f"dòng {n}: attribute '{attr}' không có trong policy")
            for name in members.split():
                need_type(n, name)
            continue

        m = re.match(r"^\(roletype\s+(\S+)\s+(\S+)\)$", line)
        if m:
            role, name = m.groups()
            if role not in roles:
                errors.append(f"dòng {n}: role '{role}' không có trong policy")
            need_type(n, name)
            continue

        if re.match(r"^\(type\s+\S+\)$", line):
            continue

        errors.append(f"dòng {n}: câu lệnh chưa được bước kiểm này hiểu -> {line!r}")

    if errors:
        print("Khối CIL Kaorios KHÔNG hợp lệ:", file=sys.stderr)
        for e in errors:
            print("  -", e, file=sys.stderr)
        return 1

    print(f"Khối CIL Kaorios OK: {len(stmts)} câu lệnh")
    for n, line in stmts:
        print("  ", line)
    print("Lưu ý: kiểm cấu trúc, không phải biên dịch. Chỉ secilc trên máy mới")
    print("xác nhận được policy này dựng được lúc boot.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
