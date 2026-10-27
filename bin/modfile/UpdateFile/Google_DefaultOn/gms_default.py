#!/usr/bin/env python3
"""Locate and flip the default of the "Google basic services" switch.

MIUI/HyperOS China ROMs ship the switch in its own tiny system app
(package com.miui.googlebase, activity ...ui.GmsCoreSettings).  The switch
state lives behind a Settings provider key, and the app passes its own
"disabled" default to getInt()/getBoolean().  We cannot know that key offline,
so we discover it from the decoded APK:

  1. find the string used as the switch title ("谷歌基础服务" / "Google basic
     services")
  2. find the preference XML that references that string and read android:key
  3. fall back to any android:key whose name looks GMS related

Then flip the constant the app uses as the "off" default, so a freshly
flashed ROM boots with Google services already enabled.

Usage:
    gms_default.py find  <decoded_dir>
    gms_default.py patch <decoded_dir> <key>[,<key>...]
"""
import os
import re
import sys

TITLE_RE = re.compile(
    r"谷歌基础服务|Google\s*基础服务|Google\s*basic\s*services?|Google\s*services?",
    re.I,
)
KEY_HINT = re.compile(r"(gms|google)", re.I)


def res_dirs(decoded):
    out = []
    root = os.path.join(decoded, "resources")
    if not os.path.isdir(root):
        return out
    for pkg in sorted(os.listdir(root)):
        res = os.path.join(root, pkg, "res")
        if os.path.isdir(res):
            out.append(res)
    return out


def read(path):
    try:
        with open(path, "r", encoding="utf-8", errors="replace") as f:
            return f.read()
    except OSError:
        return ""


def string_names_with_title(res):
    """-> set of string resource names whose text is the switch title."""
    names = set()
    for d in sorted(os.listdir(res)):
        if not d.startswith("values"):
            continue
        f = os.path.join(res, d, "strings.xml")
        if not os.path.isfile(f):
            continue
        for m in re.finditer(r'<string name="([^"]+)"[^>]*>(.*?)</string>', read(f), re.S):
            if TITLE_RE.search(m.group(2)):
                names.add(m.group(1))
    return names


def keys_from_xml(res, names):
    """-> keys of preference/layout nodes that show the switch title."""
    keys, files = [], []
    for d in sorted(os.listdir(res)):
        if not (d.startswith("xml") or d.startswith("layout")):
            continue
        sub = os.path.join(res, d)
        if not os.path.isdir(sub):
            continue
        for fn in sorted(os.listdir(sub)):
            if not fn.endswith(".xml"):
                continue
            p = os.path.join(sub, fn)
            body = read(p)
            if not body:
                continue
            for name in names:
                if "@string/" + name not in body:
                    continue
                files.append(os.path.join(d, fn))
                # every element that mentions the title, grab its android:key
                for el in re.finditer(r"<[^>]*@string/" + re.escape(name) + r"[^>]*>", body, re.S):
                    k = re.search(r'android:key="([^"]+)"', el.group(0))
                    if k:
                        keys.append(k.group(1))
                # preference screens often put the key on the parent node
                for k in re.finditer(r'android:key="([^"]+)"', body):
                    if KEY_HINT.search(k.group(1)):
                        keys.append(k.group(1))
    return list(dict.fromkeys(keys)), list(dict.fromkeys(files))


def all_gms_keys(res):
    """Fallback: any android:key that looks GMS related."""
    keys = []
    for d in sorted(os.listdir(res)):
        if not (d.startswith("xml") or d.startswith("layout")):
            continue
        sub = os.path.join(res, d)
        if not os.path.isdir(sub):
            continue
        for fn in sorted(os.listdir(sub)):
            if not fn.endswith(".xml") or not KEY_HINT.search(fn):
                continue
            body = read(os.path.join(sub, fn))
            for k in re.finditer(r'android:key="([^"]+)"', body):
                if KEY_HINT.search(k.group(1)):
                    keys.append(k.group(1))
    return list(dict.fromkeys(keys))


def smali_keys(decoded):
    """Last resort: const-string values that are actually used as the key of a
    Settings provider read (looked up backwards from the getInt/getBoolean
    call site, so unrelated "google" strings such as analytics constants are
    not picked up)."""
    keys = []
    root = os.path.join(decoded, "smali")
    if not os.path.isdir(root):
        return keys
    const_re = re.compile(r'const-string[a-z/]*\s+v\d+,\s*"([^"]+)"')
    read_re = re.compile(r"invoke-\w+.*Settings\$(Secure|System|Global);->(getInt|getBoolean|getLong)\(")
    key_re = re.compile(r"^[A-Za-z0-9_.]*(gms|google)[A-Za-z0-9_.]*$", re.I)
    for dirpath, _dirs, files in os.walk(root):
        for fn in files:
            if not fn.endswith(".smali"):
                continue
            lines = read(os.path.join(dirpath, fn)).splitlines()
            for i, line in enumerate(lines):
                if not read_re.search(line):
                    continue
                for j in range(i - 1, max(i - 21, -1), -1):
                    m = const_re.search(lines[j])
                    if not m:
                        continue
                    k = m.group(1)
                    if len(k) < 45 and key_re.match(k):
                        keys.append(k)
                    break
    return list(dict.fromkeys(keys))


def cmd_find(decoded):
    res_list = res_dirs(decoded)
    print("res dirs:", len(res_list))
    names, keys, files = set(), [], []
    for res in res_list:
        names |= string_names_with_title(res)
        k, f = keys_from_xml(res, names)
        keys += k
        files += f
    if names:
        print("title strings:", ", ".join(sorted(names)))
    if files:
        print("preference files:", ", ".join(files[:8]))
    if keys:
        print("KEYS:", ",".join(dict.fromkeys(keys)))
        return 0
    for res in res_list:
        keys += all_gms_keys(res)
    if keys:
        print("KEYS(fallback-xml):", ",".join(dict.fromkeys(keys)))
        return 0
    keys = smali_keys(decoded)
    if keys:
        print("KEYS(fallback-smali):", ",".join(keys[:12]))
        return 0
    print("KEYS: none")
    return 1


CONST_RE = re.compile(r"^(\s*)const/(4|16)\s+(v\d+),\s*(0x0|0)$")
INVOKE_RE = re.compile(r"invoke-\w+.*Settings\$(Secure|System|Global);->(getInt|getBoolean|getLong)\(")


def cmd_patch(decoded, keys):
    keys = [k for k in keys.split(",") if k]
    if not keys:
        print("no key given")
        return 1
    patched_files, patched_sites = 0, 0
    for dirpath, _dirs, files in os.walk(decoded):
        for fn in files:
            if not fn.endswith(".smali"):
                continue
            p = os.path.join(dirpath, fn)
            lines = read(p).splitlines()
            hit = False
            for i, line in enumerate(lines):
                m = re.search(r'const-string[a-z/]*\s+v\d+,\s*"([^"]+)"', line)
                if not m or m.group(1) not in keys:
                    continue
                # look ahead for the provider read that consumes this key
                for j in range(i + 1, min(i + 26, len(lines))):
                    if INVOKE_RE.search(lines[j]):
                        # flip the closest "off" default above the invoke
                        for k in range(j - 1, i, -1):
                            cm = CONST_RE.match(lines[k])
                            if cm:
                                lines[k] = f"{cm.group(1)}const/{cm.group(2)} {cm.group(3)}, 0x1"
                                patched_sites += 1
                                hit = True
                                break
                        break
            if hit:
                with open(p, "w", encoding="utf-8", newline="\n") as f:
                    f.write("\n".join(lines) + "\n")
                patched_files += 1
    print(f"patched sites: {patched_sites} in {patched_files} file(s)")
    return 0 if patched_sites else 1


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print(__doc__)
        sys.exit(2)
    mode, target = sys.argv[1], sys.argv[2]
    if mode == "find":
        sys.exit(cmd_find(target))
    if mode == "patch":
        sys.exit(cmd_patch(target, sys.argv[3] if len(sys.argv) > 3 else ""))
    print("unknown mode", mode)
    sys.exit(2)
