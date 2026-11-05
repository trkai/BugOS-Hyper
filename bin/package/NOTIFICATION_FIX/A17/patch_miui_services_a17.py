#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
BugOS - HyperOS 4.0 (Android 17) Notification Fix Patcher for miui-services.jar
Surgical, method-level patcher derived from binary diff analysis of working ROM patch.

Targets:
1. BroadcastQueueModernStubImpl.smali:
   - isInternationalSpecialAction(...)Z -> IS_INTERNATIONAL_BUILD -> IS_MIUI
   - updateBlockBroadcast()V            -> IS_INTERNATIONAL_BUILD -> IS_MIUI
   - checkApplicationAutoStart(...)Z    -> IS_INTERNATIONAL_BUILD -> IS_MIUI (FCM intent handler)
   * checkReceiverAppDealBroadcast(...)Z -> KEPT UNTOUCHED (PACKAGE_ADDED handling)

2. ProcessManagerService.smali:
   - isForceStopEnable(...)Z            -> IS_INTERNATIONAL_BUILD -> IS_MIUI (forces return false)

3. ProcessSceneCleaner.smali:
   - handleSwipeKill(...)Z              -> IS_INTERNATIONAL_BUILD -> IS_MIUI (protects foreground services)
   - killAppForHasOtherTask(...)Z       -> IS_INTERNATIONAL_BUILD -> IS_MIUI (protects foreground services)

4. PackageManagerServiceImpl.smali:
   - verifyIsolationViolation(...)V     -> return-void (bypass package isolation restrictions)
   - canBeUpdate(...)V                  -> return-void (bypass package update restrictions)

5. WindowManagerServiceImpl.smali:
   - notAllowCaptureDisplay(...)Z       -> inject isBypassSecureFlag() check if missing
"""

import os
import re
import sys


def find_files_by_name(root_dir, target_name):
    matches = []
    for dirpath, _, filenames in os.walk(root_dir):
        for f in filenames:
            if f == target_name:
                matches.append(os.path.join(dirpath, f))
    return matches


def patch_smali_methods_replace(file_path, method_names, search_pattern, replace_pattern):
    if not os.path.isfile(file_path):
        print(f"[-] Không tìm thấy file: {file_path}")
        return 0

    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Pattern match specific methods
    method_re = re.compile(
        r'(?ms)(^[ \t]*\.method\b[^\n]*?\b(' +
        '|'.join(re.escape(m) for m in method_names) +
        r')\(.*?^[ \t]*\.end method)'
    )

    total_replaced = 0

    def replacer(match):
        nonlocal total_replaced
        body = match.group(0)
        new_body, count = re.subn(re.escape(search_pattern), replace_pattern, body)
        total_replaced += count
        return new_body

    new_content, n_methods = method_re.subn(replacer, content)
    if total_replaced > 0:
        with open(file_path, 'w', encoding='utf-8', newline='\n') as f:
            f.write(new_content)
        print(f"[+] {os.path.basename(file_path)}: Đã vá {total_replaced} chỗ trong {n_methods} method ({', '.join(method_names)})")
    else:
        print(f"[i] {os.path.basename(file_path)}: Không còn chỗ nào cần thay thế trong ({', '.join(method_names)})")
    return total_replaced


def stub_method_return_void(file_path, method_name, registers=2):
    if not os.path.isfile(file_path):
        return False

    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    pattern = re.compile(
        r'(?ms)(^[ \t]*\.method\b[^\n]*?\b' + re.escape(method_name) + r'\(.*?\n)(.*?)(^[ \t]*\.end method)',
    )

    stub_body = f"    .registers {registers}\n\n    return-void\n"
    new_content, count = pattern.subn(r'\g<1>' + stub_body + r'\g<3>', content)
    if count > 0:
        with open(file_path, 'w', encoding='utf-8', newline='\n') as f:
            f.write(new_content)
        print(f"[+] {os.path.basename(file_path)}: Đã stub {method_name} -> return-void")
        return True
    else:
        print(f"[!] {os.path.basename(file_path)}: Không tìm thấy method {method_name}")
        return False


def patch_window_manager_secure_flag(file_path):
    if not os.path.isfile(file_path):
        return False

    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    if "isBypassSecureFlag" in content:
        print(f"[i] {os.path.basename(file_path)}: Đã có sẵn isBypassSecureFlag (không cần vá lại)")
        return True

    pattern = re.compile(
        r'(?ms)(^[ \t]*\.method public notAllowCaptureDisplay\(Lcom/android/server/wm/RootWindowContainer;I\)Z\n.*?' +
        r'^[ \t]*\.param p2, "displayId"    # I\n)'
    )

    injection = (
        "\n    invoke-static {}, Lcom/android/server/wm/WindowState;->isBypassSecureFlag()Z\n\n"
        "    move-result v0\n\n"
        "    if-eqz v0, :cond_bypass_flag\n\n"
        "    const/4 v0, 0x0\n\n"
        "    return v0\n\n"
        "    :cond_bypass_flag\n"
    )

    new_content, count = pattern.subn(r'\g<1>' + injection, content)
    if count > 0:
        with open(file_path, 'w', encoding='utf-8', newline='\n') as f:
            f.write(new_content)
        print(f"[+] {os.path.basename(file_path)}: Đã chèn isBypassSecureFlag vào notAllowCaptureDisplay")
        return True
    else:
        print(f"[!] {os.path.basename(file_path)}: Không tìm thấy method notAllowCaptureDisplay")
        return False


def main():
    if len(sys.argv) < 2:
        print("Usage: patch_miui_services_a17.py <decompiled_dir>")
        sys.exit(1)

    root_dir = sys.argv[1]
    if not os.path.isdir(root_dir):
        print(f"[-] Thư mục không tồn tại: {root_dir}")
        sys.exit(1)

    print(f"=== Bắt đầu vá miui-services cho Android 17 / HyperOS 4.0 tại: {root_dir} ===")
    total_actions = 0

    # 1. BroadcastQueueModernStubImpl.smali
    bq_files = find_files_by_name(root_dir, "BroadcastQueueModernStubImpl.smali")
    for bq_path in bq_files:
        c = patch_smali_methods_replace(
            bq_path,
            ["isInternationalSpecialAction", "updateBlockBroadcast", "checkApplicationAutoStart"],
            "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z",
            "Lmiui/os/Build;->IS_MIUI:Z"
        )
        total_actions += c

    # 2. ProcessManagerService.smali
    pm_files = find_files_by_name(root_dir, "ProcessManagerService.smali")
    for pm_path in pm_files:
        c = patch_smali_methods_replace(
            pm_path,
            ["isForceStopEnable"],
            "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z",
            "Lmiui/os/Build;->IS_MIUI:Z"
        )
        total_actions += c

    # 3. ProcessSceneCleaner.smali
    psc_files = find_files_by_name(root_dir, "ProcessSceneCleaner.smali")
    for psc_path in psc_files:
        c = patch_smali_methods_replace(
            psc_path,
            ["handleSwipeKill", "killAppForHasOtherTask"],
            "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z",
            "Lmiui/os/Build;->IS_MIUI:Z"
        )
        total_actions += c

    # 4. PackageManagerServiceImpl.smali
    pms_files = find_files_by_name(root_dir, "PackageManagerServiceImpl.smali")
    for pms_path in pms_files:
        if stub_method_return_void(pms_path, "verifyIsolationViolation", registers=3):
            total_actions += 1
        if stub_method_return_void(pms_path, "canBeUpdate", registers=2):
            total_actions += 1

    # 5. WindowManagerServiceImpl.smali
    wm_files = find_files_by_name(root_dir, "WindowManagerServiceImpl.smali")
    for wm_path in wm_files:
        if patch_window_manager_secure_flag(wm_path):
            total_actions += 1

    print(f"=== Hoàn thành: {total_actions} hành động vá đã thực hiện ===")
    return 0


if __name__ == '__main__':
    sys.exit(main())
