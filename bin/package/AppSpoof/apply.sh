#!/bin/bash
# ---------------------------------------------------------------------------
# AppSpoof - ham dung chung cho jar_patcher_a15.sh va jar_patcher_a16.sh.
#
# Vi sao tach ra file rieng: a17 da co san ban inline (da test), con a15/a16
# can cung mot logic. De o day mot ban duy nhat de sau nay chi phai sua 1 cho.
#
# Duoc goi trong patch_framework(), ngay sau apply_framework_signature_patches()
# va TRUOC recompile_jar() - nho vay smali cua com.bugos.spoof nam trong
# framework.jar xuat ra.
#
# Tat bang app_spoof=false trong config.env.
# ---------------------------------------------------------------------------

apply_app_spoof() {
  local decompile_dir="$1"

  local flag
  flag=$(grep -m1 '^app_spoof=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
  if [ "$flag" = "false" ]; then
    log "AppSpoof: app_spoof=false - bỏ qua"
    return 0
  fi

  local src_dir="$work_dir/bin/package/AppSpoof/smali/com/bugos/spoof"
  if [ ! -d "$src_dir" ]; then
    warn "AppSpoof: không thấy $src_dir - bỏ qua"
    return 0
  fi

  local smali_root="$decompile_dir/smali"
  [ -d "$smali_root" ] || smali_root=$(find "$decompile_dir" -maxdepth 1 -type d -name "smali*" | sort | head -n 1)
  if [ -z "$smali_root" ] || [ ! -d "$smali_root" ]; then
    warn "AppSpoof: không thấy thư mục smali - bỏ qua"
    return 0
  fi

  mkdir -p "$smali_root/com/bugos/spoof"
  cp -f "$src_dir"/*.smali "$smali_root/com/bugos/spoof/" || {
    warn "AppSpoof: copy class thất bại"
    return 0
  }

  # ---- 1. Build.smali: bỏ final -----------------------------------------
  local build_smali
  build_smali=$(find "$decompile_dir" -type f -path "*/android/os/Build.smali" | head -n 1)
  if [ -n "$build_smali" ]; then
    python3 - "$build_smali" << 'PYEOF'
import re, sys
path = sys.argv[1]
s = open(path, encoding="utf-8").read()

FIELDS = [
    "BRAND", "DEVICE", "MANUFACTURER", "MODEL", "PRODUCT", "FINGERPRINT",
    "BRAND_FOR_ATTESTATION", "DEVICE_FOR_ATTESTATION",
    "MANUFACTURER_FOR_ATTESTATION", "MODEL_FOR_ATTESTATION",
    "PRODUCT_FOR_ATTESTATION",
]
n = 0
for f in FIELDS:
    pat = re.compile(r"^\.field public static final " + re.escape(f) + r":", re.M)
    s, k = pat.subn(".field public static " + f + ":", s)
    n += k

open(path, "w", encoding="utf-8", newline="\n").write(s)
print(f"bo final {n} field")
PYEOF
    log "AppSpoof: Build.smali -> bỏ final (reflection set được)"
  else
    warn "AppSpoof: không thấy android/os/Build.smali - spoof sẽ không có tác dụng"
  fi

  # ---- 2. Instrumentation.newApplication --------------------------------
  local instr
  instr=$(find "$decompile_dir" -type f -path "*/android/app/Instrumentation.smali" | head -n 1)
  if [ -n "$instr" ]; then
    python3 - "$instr" << 'PYEOF'
import re, sys
path = sys.argv[1]
s = open(path, encoding="utf-8").read()
MARK = "bugos_appspoof"

if MARK in s:
    print("da va roi")
    sys.exit(0)

AT = r"invoke-virtual \{([vp]\d+), ([vp]\d+)\}, Landroid/app/Application;->attach\(Landroid/content/Context;\)V"

def add_hook(m):
    ctx = m.group(2)
    return (m.group(0)
            + "\n\n    invoke-static {%s}, Lcom/bugos/spoof/AppSpoof;->apply(Landroid/content/Context;)V"
              "\n\n    # %s" % (ctx, MARK))

pat = re.compile(r"\.method public (?:static )?newApplication\([^\n]*\n(.*?)\.end method", re.S)
total = 0

def fix_method(m):
    global total
    body = m.group(1)
    if "Application;->attach(Landroid/content/Context;)V" not in body:
        return m.group(0)
    new_body, k = re.subn(AT, add_hook, body, count=1)
    if k:
        total += k
    return m.group(0).replace(body, new_body, 1)

s2 = pat.sub(fix_method, s)
open(path, "w", encoding="utf-8", newline="\n").write(s2)
print("va %d newApplication" % total)
PYEOF
    if grep -q "bugos_appspoof" "$instr" 2>/dev/null; then
      log "AppSpoof: Instrumentation.newApplication -> gọi AppSpoof.apply(Context)"
    else
      warn "AppSpoof: KHÔNG vá được newApplication - spoof không chạy"
    fi
  else
    warn "AppSpoof: không thấy android/app/Instrumentation.smali"
  fi

  # ---- 3. SystemProperties.get ------------------------------------------
  local sp
  sp=$(find "$decompile_dir" -type f -path "*/android/os/SystemProperties.smali" | head -n 1)
  if [ -n "$sp" ]; then
    python3 - "$sp" << 'PYEOF'
import re, sys
path = sys.argv[1]
s = open(path, encoding="utf-8").read()

SIGS = [
    "get(Ljava/lang/String;)Ljava/lang/String;",
    "get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;",
]
MARK = "bugos_appspoof_stock"
GUARD = (
    "    invoke-static {p0}, Lcom/bugos/spoof/AppSpoof;->prop(Ljava/lang/String;)Ljava/lang/String;\n"
    "\n"
    "    move-result-object v0\n"
    "\n"
    "    if-eqz v0, :" + MARK + "\n"
    "\n"
    "    return-object v0\n"
    "\n"
    "    :" + MARK + "\n"
)

patched = 0
for sig in SIGS:
    m = re.search(r"\.method [^\n]*" + re.escape(sig) + r"\n(.*?)\.end method", s, re.S)
    if not m:
        print("khong thay method: " + sig)
        continue
    body = m.group(1)
    if MARK in body:
        print("da va roi: " + sig)
        continue

    lm = re.search(r"^(\s*)\.locals (\d+)\s*$", body, re.M)
    rm = re.search(r"^(\s*)\.registers (\d+)\s*$", body, re.M)
    if lm:
        indent, n = lm.group(1), int(lm.group(2))
        if n < 1:
            body = body[:lm.start()] + indent + ".locals 1" + body[lm.end():]
            lm = re.search(r"^(\s*)\.locals (\d+)\s*$", body, re.M)
        anchor_end = lm.end()
    elif rm:
        indent, n = rm.group(1), int(rm.group(2))
        body = body[:rm.start()] + indent + ".registers %d" % (n + 1) + body[rm.end():]
        rm = re.search(r"^(\s*)\.registers (\d+)\s*$", body, re.M)
        anchor_end = rm.end()
    else:
        print("khong thay .locals/.registers: " + sig)
        continue

    body = body[:anchor_end] + "\n\n" + GUARD + body[anchor_end:]
    s = s[:m.start(1)] + body + s[m.end(1):]
    patched += 1

if patched == 0 and MARK not in s:
    sys.exit(1)

open(path, "w", encoding="utf-8", newline="\n").write(s)
print("va %d SystemProperties.get" % patched)
PYEOF
    if grep -q "bugos_appspoof_stock" "$sp" 2>/dev/null; then
      log "AppSpoof: SystemProperties.get -> trả prop giả cho app đã chọn"
    else
      warn "AppSpoof: KHÔNG vá được SystemProperties.get"
    fi
  fi

  log "AppSpoof: đã nhúng com.bugos.spoof.AppSpoof vào framework.jar"
}
