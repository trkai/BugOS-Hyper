#!/bin/bash
# ---------------------------------------------------------------------------
# BugOS - cho phép chụp màn hình ở cửa sổ có FLAG_SECURE.
#
# Cách làm: ROM HyperOS đã có sẵn hook riêng trong WindowManagerService:
#
#   WindowState.isSecureLocked():
#       if (mWmService.getDisableSecureWindows()) return false;   // <- hook
#       ... kiểm tra FLAG_SECURE ...
#
# Nên chỉ cần cho getDisableSecureWindows() luôn trả true là mọi cửa sổ thành
# "không secure" -> chụp màn hình / quay màn hình được ở app ngân hàng, DRM...
#
# Vì sao không vá thẳng WindowState.isSecureLocked(): đã từng thử và để lại
# hậu quả (xem inject_windowstate_bypass_stub trong jar_patcher_a17.sh). Vá
# đúng cái hook mà Xiaomi tự đặt thì ít rủi ro hơn: không thêm lời gọi mới,
# chỉ đổi giá trị trả về.
#
# Tắt bằng allow_secure_screenshot=false trong config.env.
# ---------------------------------------------------------------------------

apply_no_secure_windows() {
  local decompile_dir="$1"

  local flag
  flag=$(grep -m1 '^allow_secure_screenshot=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
  if [ "$flag" = "false" ]; then
    log "SecureShot: allow_secure_screenshot=false - bỏ qua"
    return 0
  fi

  local wms
  wms=$(find "$decompile_dir" -type f -path "*/com/android/server/wm/WindowManagerService.smali" 2>/dev/null | head -n 1)

  if [ -n "$wms" ]; then
    python3 - "$wms" << 'PYEOF'
import re, sys
path = sys.argv[1]
s = open(path, encoding="utf-8").read()
MARK = "bugos_no_secure"

if MARK in s:
    print("da va roi")
    sys.exit(0)

pat = re.compile(r"\.method [^\n]*getDisableSecureWindows\(\)Z\n(.*?)\.end method", re.S)
m = pat.search(s)
if not m:
    print("khong thay getDisableSecureWindows")
    sys.exit(1)

body = ("    .registers 1\n\n"
        "    # %s\n"
        "    const/4 v0, 0x1\n\n"
        "    return v0\n" % MARK)

s = s[:m.start(1)] + body + s[m.end(1):]
open(path, "w", encoding="utf-8", newline="\n").write(s)
print("va getDisableSecureWindows -> true")
PYEOF
    if grep -q "bugos_no_secure" "$wms" 2>/dev/null; then
      log "SecureShot: WindowManagerService.getDisableSecureWindows() -> true"
      return 0
    fi
    warn "SecureShot: không vá được getDisableSecureWindows - thử WindowState"
  else
    warn "SecureShot: không thấy WindowManagerService.smali - thử WindowState"
  fi

  # Dự phòng: ROM không có hook của Xiaomi -> vá thẳng isSecureLocked().
  local ws
  ws=$(find "$decompile_dir" -type f -path "*/com/android/server/wm/WindowState.smali" 2>/dev/null | head -n 1)
  if [ -z "$ws" ]; then
    warn "SecureShot: không thấy WindowState.smali - bỏ qua"
    return 0
  fi

  python3 - "$ws" << 'PYEOF'
import re, sys
path = sys.argv[1]
s = open(path, encoding="utf-8").read()
MARK = "bugos_no_secure"

if MARK in s:
    print("da va roi")
    sys.exit(0)

pat = re.compile(r"\.method [^\n]*isSecureLocked\(\)Z\n(.*?)\.end method", re.S)
m = pat.search(s)
if not m:
    print("khong thay isSecureLocked")
    sys.exit(1)

body = ("    .registers 1\n\n"
        "    # %s\n"
        "    const/4 v0, 0x0\n\n"
        "    return v0\n" % MARK)

s = s[:m.start(1)] + body + s[m.end(1):]
open(path, "w", encoding="utf-8", newline="\n").write(s)
print("va isSecureLocked -> false")
PYEOF
  if grep -q "bugos_no_secure" "$ws" 2>/dev/null; then
    log "SecureShot: WindowState.isSecureLocked() -> false"
  else
    warn "SecureShot: KHÔNG vá được - chụp màn hình vẫn bị chặn ở app secure"
  fi
}
