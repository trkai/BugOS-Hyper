#!/usr/bin/env bash
# patcher_a17.sh - Android 17 framework/services patcher
#
# Bản port từ jar_patcher_a16.sh. Khác biệt so với A16:
#   1. API_LEVEL=37
#   2. giữ smali 2.5.2 (3.0.5 chết khi ghi debug info của dex A17 - xem log)
#   3. FAIL-FAST: nếu một jar không patch được thì DỪNG, không ghi đè jar gốc
#   4. run_patch(): thử lại lần 2 với --debug-info false nếu lần 1 lỗi assemble
#
# CHƯA KIỂM CHỨNG TRÊN ROM ANDROID 17 THẬT. Nếu A17 đổi cấu trúc framework thì
# bước decompile/patch sẽ lỗi và script dừng với thông báo rõ - không tạo ROM hỏng.
work_dir=$(pwd)
WORK_DIR="$work_dir"
BACKUP_DIR="$WORK_DIR/backup"
SCRIPT_DIR="$work_dir/bin/package/COREPATCH"
TOOLS_DIR="$work_dir/bin/apktool"
source "${SCRIPT_DIR}/helper.sh"
# Create backup directory
mkdir -p "$BACKUP_DIR"

# API level for baksmali/smali
API_LEVEL=37

# Dùng smali 2.5.2 (mặc định của repo), KHÔNG dùng 3.0.5.
#
# Bằng chứng từ log build OS4: trên CÙNG framework.jar của Android 17,
#   - smali 3.0.5  -> IndexOutOfBoundsException trong DebugInfoCache.hashCode
#   - smali 2.5.2  -> "Success" (baksmaliv2/smaliv2 trong bin/apktool vá được)
# Nên 3.0.5 không "hiện đại hơn" mà là bản hỏng với dex này. Giữ 2.5.2.
# (run_patch bên dưới vẫn có lần thử 2 với --debug-info false nếu cần.)

# ============================================
# Feature Flags (set by command-line arguments)
# ============================================
FEATURE_DISABLE_SIGNATURE_VERIFICATION=1
FEATURE_DISABLE_SECURE_FLAG=1

# ----------------------------------------------
# Internal helpers (python-powered transformations)
# ----------------------------------------------

insert_line_before_all() {
  local file="$1"
  local pattern="$2"
  local new_line="$3"

  python3 - "$file" "$pattern" "$new_line" << 'PY'
from pathlib import Path
import re
import sys

path = Path(sys.argv[1])
pattern = sys.argv[2]
new_line = sys.argv[3]

if not path.exists():
    sys.exit(4)

lines = path.read_text().splitlines()
matched = False
changed = False

i = 0
while i < len(lines):
    line = lines[i]
    if pattern in line:
        matched = True
        indent = re.match(r"\s*", line).group(0)
        candidate = f"{indent}{new_line}"
        if i > 0 and lines[i - 1].strip() == new_line.strip():
            i += 1
            continue
        lines.insert(i, candidate)
        changed = True
        i += 2
    else:
        i += 1

if not matched:
    sys.exit(3)

if changed:
    path.write_text("\n".join(lines) + "\n")
PY

  local status=$?
  case "$status" in
    0)
      log "Inserted '${new_line}' before lines containing pattern '${pattern##*/}' in $(basename "$file")"
      ;;
    3)
      warn "Pattern '${pattern}' not found in $(basename "$file")"
      ;;
    4)
      warn "File not found: $file"
      ;;
    *)
      err "Failed to insert '${new_line}' in $file (status $status)"
      return 1
      ;;
  esac

  return 0
}

insert_const_before_condition_near_string() {
  local file="$1"
  local search_string="$2"
  local condition_prefix="$3"
  local register="$4"
  local value="$5"

  python3 - "$file" "$search_string" "$condition_prefix" "$register" "$value" << 'PY'
from pathlib import Path
import re
import sys

path = Path(sys.argv[1])
search_string = sys.argv[2]
condition_prefix = sys.argv[3]
register = sys.argv[4]
value = sys.argv[5]

if not path.exists():
    sys.exit(4)

lines = path.read_text().splitlines()
matched = False
changed = False

for idx, line in enumerate(lines):
    if search_string in line:
        matched = True
        start = max(0, idx - 20)
        for j in range(idx - 1, start - 1, -1):
            stripped = lines[j].strip()
            if stripped.startswith(condition_prefix):
                indent = re.match(r"\s*", lines[j]).group(0)
                insert_line = f"{indent}const/4 {register}, 0x{value}"
                if j == 0 or lines[j - 1].strip() != f"const/4 {register}, 0x{value}":
                    lines.insert(j, insert_line)
                    changed = True
                break

if not matched:
    sys.exit(3)

if changed:
    path.write_text("\n".join(lines) + "\n")
PY

  local status=$?
  case "$status" in
    0)
      log "Inserted const for ${register} near condition '${condition_prefix}' in $(basename "$file")"
      ;;
    3)
      warn "Search string '${search_string}' not found in $(basename "$file")"
      ;;
    4)
      warn "File not found: $file"
      ;;
    *)
      err "Failed to patch condition in $file (status $status)"
      return 1
      ;;
  esac

  return 0
}

replace_move_result_after_invoke() {
  local file="$1"
  local invoke_pattern="$2"
  local replacement="$3"

  python3 - "$file" "$invoke_pattern" "$replacement" << 'PY'
from pathlib import Path
import re
import sys

path = Path(sys.argv[1])
invoke_pattern = sys.argv[2]
replacement = sys.argv[3]

if not path.exists():
    sys.exit(4)

lines = path.read_text().splitlines()
matched = False
changed = False

i = 0
while i < len(lines):
    line = lines[i]
    if invoke_pattern in line:
        matched = True
        for j in range(i + 1, min(i + 6, len(lines))):
            target = lines[j].strip()
            if target.startswith('move-result'):
                indent = re.match(r"\s*", lines[j]).group(0)
                desired = f"{indent}{replacement}"
                if target == replacement:
                    break
                if lines[j].strip() == replacement:
                    break
                lines[j] = desired
                changed = True
                break
        i = i + 1
    else:
        i += 1

if not matched:
    sys.exit(3)

if changed:
    path.write_text("\n".join(lines) + "\n")
PY

  local status=$?
  case "$status" in
    0)
      log "Replaced move-result after invoke '${invoke_pattern##*/}' in $(basename "$file")"
      ;;
    3)
      warn "Invoke pattern '${invoke_pattern}' not found in $(basename "$file")"
      ;;
    4)
      warn "File not found: $file"
      ;;
    *)
      err "Failed to replace move-result in $file (status $status)"
      return 1
      ;;
  esac

  return 0
}

force_methods_return_const() {
  local file="$1"
  local method_substring="$2"
  local ret_val="$3"

  if [ -z "$file" ]; then
    warn "force_methods_return_const: skipped empty file path for '${method_substring}'"
    return 0
  fi

  if [ ! -f "$file" ]; then
    warn "force_methods_return_const: file not found $file"
    return 0
  fi

  python3 - "$file" "$method_substring" "$ret_val" << 'PY'
from pathlib import Path
import sys

path = Path(sys.argv[1])
method_key = sys.argv[2]
ret_val = sys.argv[3]

if not path.exists():
    sys.exit(4)

lines = path.read_text().splitlines()
found = 0
modified = 0
const_line = f"const/4 v0, 0x{ret_val}"

i = 0
while i < len(lines):
    stripped = lines[i].lstrip()
    if stripped.startswith('.method') and method_key in stripped:
        if ')V' in stripped:
            i += 1
            continue
        found += 1
        j = i + 1
        while j < len(lines) and not lines[j].lstrip().startswith('.end method'):
            j += 1
        if j >= len(lines):
            break
        body = lines[i:j+1]
        already = (
            len(body) >= 4
            and body[1].strip() == '.registers 8'
            and body[2].strip() == const_line
            and body[3].strip().startswith('return')
        )
        if already:
            i = j + 1
            continue
        stub = [
            lines[i],
            '    .registers 8',
            f'    {const_line}',
            '    return v0',
            '.end method'
        ]
        lines[i:j+1] = stub
        modified += 1
        i = i + len(stub)
    else:
        i += 1

if modified:
    path.write_text('\n'.join(lines) + '\n')

if found == 0:
    sys.exit(3)
PY

  local status=$?
  case "$status" in
    0)
      log "Set return constant 0x${ret_val} for methods containing '${method_substring}' in $(basename "$file")"
      ;;
    3)
      warn "No methods containing '${method_substring}' found in $(basename "$file")"
      ;;
    4)
      warn "File not found: $file"
      ;;
    *)
      err "Failed to rewrite methods '${method_substring}' in $file (status $status)"
      return 1
      ;;
  esac

  return 0
}

# Function to replace an entire method with a custom implementation
replace_entire_method() {
  local method_signature="$1"
  local decompile_dir="$2"
  local new_method_body="$3"
  local specific_class="$4" # Optional: specific class name to search in
  local file

  # If specific class provided, search in that class file
  if [ -n "$specific_class" ]; then
    file=$(find "$decompile_dir" -type f -path "*/${specific_class}.smali" | head -n 1)
    if [ -z "$file" ]; then
      warn "Class file $specific_class.smali not found"
      return 0
    fi
    # Verify method exists in this file
    if ! grep -s -q "\.method.* ${method_signature}" "$file" 2> /dev/null; then
      warn "Method $method_signature not found in $specific_class"
      return 0
    fi
  else
    # Search across all smali files
    file=$(find "$decompile_dir" -type f -name "*.smali" -exec grep -s -l "\.method.* ${method_signature}" {} + 2> /dev/null | head -n 1)
  fi

  [ -z "$file" ] && {
    warn "Method $method_signature not found in decompile directory"
    return 0
  }

  local start
  start=$(grep -n "^[[:space:]]*\.method.* ${method_signature}" "$file" | cut -d: -f1 | head -n1)
  [ -z "$start" ] && {
    warn "Method $method_signature start not found in $(basename "$file")"
    return 0
  }

  local total_lines end=0 i="$start" line
  total_lines=$(wc -l < "$file")
  while [ "$i" -le "$total_lines" ]; do
    line=$(sed -n "${i}p" "$file")
    [[ "$line" == *".end method"* ]] && {
      end="$i"
      break
    }
    i=$((i + 1))
  done

  [ "$end" -eq 0 ] && {
    warn "Method $method_signature end not found in $(basename "$file")"
    return 0
  }

  local method_head
  method_head=$(sed -n "${start}p" "$file")
  method_head_escaped=$(printf "%s\n" "$method_head" | sed 's/\\/\\\\/g')

  # Replace the entire method with the new body
  sed -i "${start},${end}c\\
$method_head_escaped\\
$new_method_body\\
.end method" "$file"

  log "✓ Replaced entire method $method_signature in $(basename "$file")"
  return 0
}

replace_if_block_in_strict_jar_file() {
  local file="$1"

  python3 - "$file" << 'PY'
from pathlib import Path
import re
import sys

path = Path(sys.argv[1])
if not path.exists():
    sys.exit(4)

lines = path.read_text().splitlines()
changed = False

for idx, line in enumerate(lines):
    if 'invoke-virtual {p0, v5}, Landroid/util/jar/StrictJarFile;->findEntry(Ljava/lang/String;)Ljava/util/zip/ZipEntry;' in line:
        # locate if-eqz v6
        if_idx = None
        for j in range(idx + 1, min(idx + 12, len(lines))):
            stripped = lines[j].strip()
            if stripped.startswith('if-eqz v6, :cond_'):
                if_idx = j
                break
        if if_idx is not None:
            del lines[if_idx]
            changed = True
        # adjust label
        for j in range(idx + 1, min(idx + 20, len(lines))):
            stripped = lines[j].strip()
            if re.match(r':cond_[0-9a-zA-Z_]+', stripped):
                indent = re.match(r'\s*', lines[j]).group(0)
                label = stripped
                # ensure a nop directly after label
                if j + 1 < len(lines) and lines[j + 1].strip() == 'nop':
                    break
                lines.insert(j + 1, f'{indent}nop')
                lines[j] = f'{indent}{label}'
                changed = True
                break
        break

if changed:
    path.write_text('\n'.join(lines) + '\n')
PY

  local status=$?
  case "$status" in
    0)
      log "Removed if-eqz guard in $(basename "$file")"
      ;;
    4)
      warn "StrictJarFile.smali not found"
      ;;
    *)
      err "Failed to adjust StrictJarFile (status $status)"
      return 1
      ;;
  esac

  return 0
}

patch_reconcile_clinit() {
  local file="$1"

  python3 - "$file" << 'PY'
from pathlib import Path
import sys

path = Path(sys.argv[1])
if not path.exists():
    sys.exit(4)

lines = path.read_text().splitlines()
changed = False

for idx, line in enumerate(lines):
    if '.method static constructor <clinit>()V' in line:
        for j in range(idx + 1, len(lines)):
            stripped = lines[j].strip()
            if stripped == '.end method':
                break
            if stripped == 'const/4 v0, 0x0':
                lines[j] = lines[j].replace('0x0', '0x1')
                changed = True
                break
        break

if changed:
    path.write_text('\n'.join(lines) + '\n')
PY

  local status=$?
  case "$status" in
    0)
      log "Updated <clinit> constant in $(basename "$file")"
      ;;
    4)
      warn "ReconcilePackageUtils.smali not found"
      ;;
    *)
      err "Failed to patch ReconcilePackageUtils (status $status)"
      return 1
      ;;
  esac

  return 0
}

ensure_const_before_if_for_register() {
  local file="$1"
  local invoke_pattern="$2"
  local condition_prefix="$3"
  local register="$4"
  local value="$5"

  python3 - "$file" "$invoke_pattern" "$condition_prefix" "$register" "$value" << 'PY'
from pathlib import Path
import re
import sys

path = Path(sys.argv[1])
invoke_pattern = sys.argv[2]
condition_prefix = sys.argv[3]
register = sys.argv[4]
value = sys.argv[5]

if not path.exists():
    sys.exit(4)

lines = path.read_text().splitlines()
matched = False
changed = False

for idx, line in enumerate(lines):
    if invoke_pattern in line:
        matched = True
        for j in range(max(0, idx - 1), max(0, idx - 10), -1):
            stripped = lines[j].strip()
            if stripped.startswith(condition_prefix):
                indent = re.match(r'\s*', lines[j]).group(0)
                insert_line = f'{indent}const/4 {register}, 0x{value}'
                if j == 0 or lines[j - 1].strip() != f'const/4 {register}, 0x{value}':
                    lines.insert(j, insert_line)
                    changed = True
                break

if not matched:
    sys.exit(3)

if changed:
    path.write_text('\n'.join(lines) + '\n')
PY

  local status=$?
  case "$status" in
    0)
      log "Forced ${register} to 0x${value} before condition '${condition_prefix}' in $(basename "$file")"
      ;;
    3)
      warn "Invoke pattern '${invoke_pattern}' not found in $(basename "$file")"
      ;;
    4)
      warn "File not found: $file"
      ;;
    *)
      err "Failed to enforce const on ${register} in $file (status $status)"
      return 1
      ;;
  esac

  return 0
}

# ----------------------------------------------
# Framework patches (Android 16)
# ----------------------------------------------

# Apply signature verification bypass patches to framework.jar (Android 16)
apply_framework_signature_patches() {
  local decompile_dir="$1"

  log "Applying signature verification patches to framework.jar (Android 16)..."

  local pkg_parser_file
  pkg_parser_file=$(find "$decompile_dir" -type f -path "*/android/content/pm/PackageParser.smali" | head -n1)
  if [ -n "$pkg_parser_file" ]; then
    insert_line_before_all "$pkg_parser_file" "ApkSignatureVerifier;->unsafeGetCertsWithoutVerification" "const/4 v1, 0x1"
    insert_const_before_condition_near_string "$pkg_parser_file" '<manifest> specifies bad sharedUserId name' "if-nez v14, :" "v14" "1"
  else
    warn "PackageParser.smali not found"
  fi

  local pkg_parser_exception_file
  pkg_parser_exception_file=$(find "$decompile_dir" -type f -path "*/android/content/pm/PackageParser\$PackageParserException.smali" | head -n1)
  if [ -n "$pkg_parser_exception_file" ]; then
    insert_line_before_all "$pkg_parser_exception_file" "iput p1, p0, Landroid/content/pm/PackageParser\$PackageParserException;->error:I" "const/4 p1, 0x0"
  else
    warn "PackageParser\$PackageParserException.smali not found"
  fi

  local pkg_signing_details_file
  pkg_signing_details_file=$(find "$decompile_dir" -type f -path "*/android/content/pm/PackageParser\$SigningDetails.smali" | head -n1)
  if [ -n "$pkg_signing_details_file" ]; then
    force_methods_return_const "$pkg_signing_details_file" "checkCapability" "1"
  else
    warn "PackageParser\$SigningDetails.smali not found"
  fi

  local signing_details_file
  signing_details_file=$(find "$decompile_dir" -type f -path "*/android/content/pm/SigningDetails.smali" | head -n1)
  if [ -n "$signing_details_file" ]; then
    force_methods_return_const "$signing_details_file" "checkCapability" "1"
    force_methods_return_const "$signing_details_file" "checkCapabilityRecover" "1"
    force_methods_return_const "$signing_details_file" "hasAncestorOrSelf" "1"
  else
    warn "SigningDetails.smali not found"
  fi

  local apk_sig_scheme_v2_file
  apk_sig_scheme_v2_file=$(find "$decompile_dir" -type f -path "*/android/util/apk/ApkSignatureSchemeV2Verifier.smali" | head -n1)
  if [ -n "$apk_sig_scheme_v2_file" ]; then
    replace_move_result_after_invoke "$apk_sig_scheme_v2_file" "invoke-static {v8, v4}, Ljava/security/MessageDigest;->isEqual([B[B)Z" "const/4 v0, 0x1"
  else
    warn "ApkSignatureSchemeV2Verifier.smali not found"
  fi

  local apk_sig_scheme_v3_file
  apk_sig_scheme_v3_file=$(find "$decompile_dir" -type f -path "*/android/util/apk/ApkSignatureSchemeV3Verifier.smali" | head -n1)
  if [ -n "$apk_sig_scheme_v3_file" ]; then
    replace_move_result_after_invoke "$apk_sig_scheme_v3_file" "invoke-static {v9, v3}, Ljava/security/MessageDigest;->isEqual([B[B)Z" "const/4 v0, 0x1"
  else
    warn "ApkSignatureSchemeV3Verifier.smali not found"
  fi

  local apk_signature_verifier_file
  apk_signature_verifier_file=$(find "$decompile_dir" -type f -path "*/android/util/apk/ApkSignatureVerifier.smali" | head -n1)
  if [ -n "$apk_signature_verifier_file" ]; then
    force_methods_return_const "$apk_signature_verifier_file" "getMinimumSignatureSchemeVersionForTargetSdk" "0"
    insert_line_before_all "$apk_signature_verifier_file" "ApkSignatureVerifier;->verifyV1Signature" "const p3, 0x0"
  else
    warn "ApkSignatureVerifier.smali not found"
  fi

  local apk_signing_block_utils_file
  apk_signing_block_utils_file=$(find "$decompile_dir" -type f -path "*/android/util/apk/ApkSigningBlockUtils.smali" | head -n1)
  if [ -n "$apk_signing_block_utils_file" ]; then
    replace_move_result_after_invoke "$apk_signing_block_utils_file" "invoke-static {v5, v6}, Ljava/security/MessageDigest;->isEqual([B[B)Z" "const/4 v7, 0x1"
  else
    warn "ApkSigningBlockUtils.smali not found"
  fi

  local strict_jar_verifier_file
  strict_jar_verifier_file=$(find "$decompile_dir" -type f -path "*/android/util/jar/StrictJarVerifier.smali" | head -n1)
  if [ -n "$strict_jar_verifier_file" ]; then
    force_methods_return_const "$strict_jar_verifier_file" "verifyMessageDigest" "1"
  else
    warn "StrictJarVerifier.smali not found"
  fi

  local strict_jar_file_file
  strict_jar_file_file=$(find "$decompile_dir" -type f -path "*/android/util/jar/StrictJarFile.smali" | head -n1)
  if [ -n "$strict_jar_file_file" ]; then
    replace_if_block_in_strict_jar_file "$strict_jar_file_file"
  else
    warn "StrictJarFile.smali not found"
  fi

  local parsing_package_utils_file
  parsing_package_utils_file=$(find "$decompile_dir" -type f -path "*/com/android/internal/pm/pkg/parsing/ParsingPackageUtils.smali" | head -n1)
  if [ -n "$parsing_package_utils_file" ]; then
    insert_const_before_condition_near_string "$parsing_package_utils_file" '<manifest> specifies bad sharedUserId name' "if-eqz v4, :" "v4" "0"
  else
    warn "ParsingPackageUtils.smali not found"
  fi

  log "Signature verification patches applied to framework.jar (Android 16)"
}

# Apply disable secure flag patches to framework.jar (Android 16)
apply_framework_disable_secure_flag() {
  local decompile_dir="$1"

  log "Applying disable secure flag patches to framework.jar (Android 16)..."

  # Note: For Android 16, disable secure flag does not require framework.jar patches
  # Only services.jar and miui-services.jar are affected
  log "Disable secure flag: No framework.jar patches required for Android 16"

  log "Disable secure flag patches applied to framework.jar (Android 16)"
}

# ---------------------------------------------------------------------------
# Bổ sung cho Android 17, đối chiếu với LSPosed/CorePatch (đã lên SDK 37):
#   https://github.com/LSPosed/CorePatch
#
# CorePatch hook theo tên method nên chạy được nhiều đời Android; patcher của
# repo vá theo anchor smali nên dễ lệch. Hai chỗ CorePatch có mà bản A16 không có:
#
#   1. android.content.pm.SigningDetails.hasCommonAncestor(SigningDetails)
#      - từ Android 11, dùng cho SharedUser. Đã kiểm tra trên framework.jar OS4:
#        A17 VẪN có hasAncestorOrSelf (nên patch cũ không sai), nhưng CorePatch
#        hook thêm hasCommonAncestor nên vá luôn cho đủ.
#   2. com.android.server.pm.ScanPackageUtils.assertMinSignatureSchemeIsValid
#      - từ Android 13, chạy lúc quét package. Không vá thì APK ký scheme cũ
#        vẫn bị từ chối dù đã bypass verify.
#
# Cả hai đều an toàn khi không tìm thấy: helper chỉ warn rồi bỏ qua.
# ---------------------------------------------------------------------------
# Vá mọi chỗ gọi MessageDigest.isEqual trong file: đổi "move-result vN" ngay sau
# đó thành "const/4 vN, 0x1" - GIỮ NGUYÊN số thanh ghi.
#
# Vì sao không dùng replace_move_result_after_invoke: helper đó khớp theo chuỗi
# invoke CỐ ĐỊNH (kèm số thanh ghi) và thay bằng const/4 CỐ ĐỊNH. Trên Android 17:
#   ApkSignatureSchemeV2Verifier : invoke {v8, v4} -> move-result v0    (khớp)
#   ApkSignatureSchemeV3Verifier : invoke {v5, v4} -> move-result v11   (KHÔNG khớp
#       vì anchor cũ là {v9, v3}; và nếu khớp thì const/4 v0 cũng sai, phải là v11)
#   ApkSigningBlockUtils         : invoke {v5, v6} -> move-result v7    (khớp)
patch_isequal_true() {
  local file="$1"
  [ -f "$file" ] || { warn "A17 extra: không thấy $file"; return 0; }
  python3 - "$file" << 'PYEOF'
import re, sys
from pathlib import Path
p = Path(sys.argv[1])
lines = p.read_text().splitlines()
changed = 0
i = 0
while i < len(lines):
    if 'Ljava/security/MessageDigest;->isEqual([B[B)Z' in lines[i]:
        for j in range(i + 1, min(i + 6, len(lines))):
            m = re.match(r'^(\s*)move-result\s+([vp]\d+)\s*$', lines[j])
            if m:
                lines[j] = f"{m.group(1)}const/4 {m.group(2)}, 0x1"
                changed += 1
                i = j
                break
    i += 1
if changed:
    p.write_text("\n".join(lines) + "\n")
print(f"isequal sites patched: {changed}")
PYEOF
}

apply_a17_extra_framework() {
  local decompile_dir="$1"
  local f v

  # 1) MessageDigest.isEqual -> luôn true, giữ nguyên thanh ghi
  for v in ApkSignatureSchemeV2Verifier ApkSignatureSchemeV3Verifier ApkSigningBlockUtils; do
    f=$(find "$decompile_dir" -type f -name "$v.smali" 2>/dev/null | head -n 1)
    if [ -n "$f" ]; then
      log "A17 extra: $v -> isEqual true (register-preserving)"
      patch_isequal_true "$f"
    else
      warn "A17 extra: không thấy $v.smali"
    fi
  done

  # 2) SharedUser path (CorePatch hook từ Android 11)
  f=$(find "$decompile_dir" -type f -name "SigningDetails.smali" 2>/dev/null | head -n 1)
  if [ -z "$f" ]; then
    warn "A17 extra: không thấy android/content/pm/SigningDetails.smali"
    return 0
  fi
  force_methods_return_const "$f" "hasCommonAncestor" "1"
  log "A17 extra: SigningDetails.hasCommonAncestor -> 1 (CorePatch parity)"
}

# Màn hình không sáng khi có thông báo.
#
# Log thật trên máy (logcat):
#   E/Java_Reflection: java.lang.reflect.InvocationTargetException
#     at com.xiaomi.reflect.RefMethod.invoke(RefMethod.java:78)
#     at NotificationManagerServiceImpl.buzzBeepBlinkForNotification(:289)
#     at NotificationManagerService$Stub.buzzBeepBlinkForNotification(:8152)
#   Caused by: java.lang.SecurityException: Disallowed call for uid 10292
#     at NotificationManagerService.checkCallerIsSystem(NotificationManagerService.java:13469)
#
# uid 10292 = android.uid.systemui. NotificationManagerServiceImpl (MIUI) gọi
# ngược vào phương thức AOSP buzzBeepBlinkForNotification bằng reflection, và
# phương thức đó chỉ cho SYSTEM_UID/PHONE_UID:
#   checkCallerIsSystem() -> isCallerSystemOrPhone()
# SystemUI không phải 2 uid đó nên bị ném SecurityException -> phần "buzz/beep/
# blink" (kèm bật màn hình) không chạy. Vì vậy push vẫn tới nhưng màn hình không
# sáng.
#
# Bản ROM đã có sẵn isCallerSystemOrSystemUi(): nó chấp nhận SystemUI qua quyền
# android.permission.STATUS_BAR_SERVICE (đã kiểm tra trên máy: granted=true).
# Chỉ cần cho checkCallerIsSystem dùng hàm đó.
#
# Chỉ sửa BÊN TRONG phương thức checkCallerIsSystem: chuỗi isCallerSystemOrPhone
# còn xuất hiện ở nhiều phương thức khác, thay toàn file sẽ đổi cả những chỗ
# không liên quan.
patch_notification_wake() {
  local decompile_dir="$1"
  local f
  f=$(find "$decompile_dir" -type f -name "NotificationManagerService.smali" 2>/dev/null | head -n 1)
  if [ -z "$f" ]; then
    warn "A17 extra: không thấy NotificationManagerService.smali - bỏ qua vá wake"
    return 0
  fi
  python3 - "$f" << 'PYEOF'
import re, sys
from pathlib import Path
p = Path(sys.argv[1])
s = p.read_text()
m = re.search(r'(\.method [^\n]*checkCallerIsSystem\(\)V.*?\.end method)', s, re.S)
if not m:
    print("khong thay checkCallerIsSystem()V")
    sys.exit(1)
body = m.group(1)
if 'isCallerSystemOrPhone()Z' not in body:
    print("checkCallerIsSystem khong goi isCallerSystemOrPhone - da va roi?")
    sys.exit(1)
body2 = body.replace(
    'Lcom/android/server/notification/NotificationManagerService;->isCallerSystemOrPhone()Z',
    'Lcom/android/server/notification/NotificationManagerService;->isCallerSystemOrSystemUi()Z')
s = s[:m.start(1)] + body2 + s[m.end(1):]
p.write_text(s)
print("da doi checkCallerIsSystem -> isCallerSystemOrSystemUi")
PYEOF
  if grep -A6 '\.method [^\n]*checkCallerIsSystem()V' "$f" 2>/dev/null | grep -q 'isCallerSystemOrSystemUi'; then
    log "A17 extra: NotificationManagerService.checkCallerIsSystem -> chấp nhận SystemUI (bật màn hình khi có thông báo)"
  else
    warn "A17 extra: không vá được checkCallerIsSystem"
  fi
}

apply_a17_extra_services() {
  local decompile_dir="$1"
  local f
  f=$(find "$decompile_dir" -type f -name "ScanPackageUtils.smali" 2>/dev/null | head -n 1)
  if [ -z "$f" ]; then
    warn "A17 extra: không thấy com/android/server/pm/ScanPackageUtils.smali"
  else
    patch_return_void_methods_all "assertMinSignatureSchemeIsValid" "$decompile_dir"
    log "A17 extra: ScanPackageUtils.assertMinSignatureSchemeIsValid -> return-void (CorePatch parity)"
  fi

  patch_notification_wake "$decompile_dir"
}

# ---------------------------------------------------------------------------
# Giả trạng thái bootloader ở tầng Java (android.os.SystemProperties).
#
# VÌ SAO PHẢI LÀM Ở ĐÂY, KHÔNG PHẢI Ở CMDLINE/BUILD.PROP:
#   Đã kiểm chứng trên máy thật (annibale, OS4.0.5.0.XPKCNXM):
#     /proc/cmdline  có "androidboot.verifiedbootstate=green" (vá vendor_boot)
#     getprop        vẫn trả "orange"
#   Nguyên nhân: bootloader truyền androidboot.verifiedbootstate và
#   androidboot.vbmeta.device_state qua BOOTCONFIG, không qua cmdline. init áp
#   bootconfig TRƯỚC cmdline, mà ro.* là prop ghi-một-lần -> giá trị của mình
#   đến sau nên bị bỏ. build.prop cũng thua vì lý do y hệt.
#   Hệ quả: chỉ prop nào bootloader KHÔNG đặt thì mới giả được (ví dụ
#   ro.boot.realme.lockstate=1 có mặt trên máy, chứng minh phần nối build.prop
#   vẫn chạy đúng).
#
#   Play Store và VNeID đều đọc prop này từ tầng Java, nên hook vào
#   SystemProperties.get() chặn được cả hai. Hook chỉ khớp đúng 6 key dưới đây,
#   mọi key khác đi tiếp xuống native như cũ, nên fs_mgr/init (đọc bằng native)
#   không bị ảnh hưởng.
#
# Bật/tắt bằng boot_state_spoof trong config.env (mặc định bật).
apply_boot_state_spoof() {
  local decompile_dir="$1"

  local spoof
  spoof=$(grep -m1 '^boot_state_spoof=' "$work_dir/config.env" 2>/dev/null | cut -d= -f2 | tr -d ' \r\n')
  if [ "$spoof" = "false" ]; then
    log "BootStateSpoof: boot_state_spoof=false - bỏ qua"
    return 0
  fi

  local sp
  sp=$(find "$decompile_dir" -type f -name "SystemProperties.smali" 2>/dev/null | head -n 1)
  if [ -z "$sp" ]; then
    warn "BootStateSpoof: không thấy android/os/SystemProperties.smali - bỏ qua"
    return 0
  fi

  # Chọn thư mục smali để đặt class mới (ưu tiên classes.dex)
  local smali_root="$decompile_dir/smali"
  [ -d "$smali_root" ] || smali_root=$(find "$decompile_dir" -maxdepth 1 -type d -name "smali*" | sort | head -n 1)
  if [ -z "$smali_root" ] || [ ! -d "$smali_root" ]; then
    warn "BootStateSpoof: không thấy thư mục smali - bỏ qua"
    return 0
  fi

  mkdir -p "$smali_root/com/bugos/spoof"
  cat > "$smali_root/com/bugos/spoof/BootState.smali" << 'SMALIEOF'
.class public final Lcom/bugos/spoof/BootState;
.super Ljava/lang/Object;
.source "BootState.java"


# static fields
.field private static final MAP:Ljava/util/HashMap;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/bugos/spoof/BootState;->MAP:Ljava/util/HashMap;

    const-string v1, "ro.boot.verifiedbootstate"

    const-string v2, "green"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "ro.boot.vbmeta.device_state"

    const-string v2, "locked"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "ro.secureboot.lockstate"

    const-string v2, "locked"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "vendor.boot.verifiedbootstate"

    const-string v2, "green"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "vendor.boot.vbmeta.device_state"

    const-string v2, "locked"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "ro.boot.flash.locked"

    const-string v2, "1"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method


.method public static map(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    sget-object v0, Lcom/bugos/spoof/BootState;->MAP:Ljava/util/HashMap;

    invoke-virtual {v0, p0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method
SMALIEOF

  python3 - "$sp" << 'PYEOF'
import re, sys
from pathlib import Path

path = Path(sys.argv[1])
s = path.read_text()

SIGS = [
    "get(Ljava/lang/String;)Ljava/lang/String;",
    "get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;",
]
MARK = "bugos_bootstate_orig"
GUARD = (
    "    invoke-static {p0}, Lcom/bugos/spoof/BootState;->map(Ljava/lang/String;)Ljava/lang/String;\n"
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

    # cần ít nhất 1 thanh ghi local (v0)
    lm = re.search(r"^(\s*)\.locals (\d+)\s*$", body, re.M)
    rm = re.search(r"^(\s*)\.registers (\d+)\s*$", body, re.M)
    if lm:
        indent, n = lm.group(1), int(lm.group(2))
        if n < 1:
            body = body[:lm.start()] + f"{indent}.locals 1" + body[lm.end():]
            lm = re.search(r"^(\s*)\.locals (\d+)\s*$", body, re.M)
        anchor_end = lm.end()
    elif rm:
        indent, n = rm.group(1), int(rm.group(2))
        body = body[:rm.start()] + f"{indent}.registers {n + 1}" + body[rm.end():]
        rm = re.search(r"^(\s*)\.registers (\d+)\s*$", body, re.M)
        anchor_end = rm.end()
    else:
        print("khong thay .locals/.registers: " + sig)
        continue

    body = body[:anchor_end] + "\n\n" + GUARD + body[anchor_end:]
    s = s[:m.start(1)] + body + s[m.end(1):]
    patched += 1

if patched == 0:
    if MARK in s:
        print("da va truoc do - bo qua")
        sys.exit(0)
    sys.exit(1)
path.write_text(s)
print(f"da va {patched} method")
PYEOF

  if grep -q "$MARK" "$sp" 2>/dev/null; then
    log "BootStateSpoof: SystemProperties.get -> green/locked cho 6 prop boot (chỉ tầng Java)"
  else
    warn "BootStateSpoof: KHÔNG vá được SystemProperties - prop vẫn là giá trị thật"
  fi
}

# ===========================================================================
# APP SPOOF - đổi Build props theo TỪNG app (Google Photos, game FPS cao...)
#
# Cơ chế: mỗi tiến trình app tự có bản Build riêng sau khi zygote fork, nên chỉ
# cần set lại các field static trong tiến trình đó là app thấy máy khác - không
# ảnh hưởng app khác hay system_server.
#
#   1. Build.smali: bỏ "final" ở 11 field để reflection set được.
#   2. Instrumentation.newApplication: sau Application.attach(Context) gọi
#      AppSpoof.apply(context) -> đọc config, set Build.*, nạp map prop.
#   3. SystemProperties.get: trả giá trị spoof cho các key ro.product.* /
#      ro.build.fingerprint, để app đọc prop trực tiếp cũng thấy giá trị giả.
#
# Config: Settings.Global "bugos_app_spoof" (base64 JSON) hoặc file mặc định
# /system/etc/bugos/app-spoof.json do bin/package/AppSpoof/patch.sh đóng vào.
# Tắt: app_spoof=false trong config.env.
# ===========================================================================
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

# Main framework patching function (Android 16)
patch_framework() {
  local framework_path="$work_dir/build/baserom/images/system/system/framework/framework.jar"

  if [ ! -f "$framework_path" ]; then
    err "framework.jar not found at $framework_path"
    return 1
  fi

  log "Starting Android 17 framework.jar patch"
  local decompile_dir
  decompile_dir=$(decompile_jar "$framework_path") || return 1

  # Apply feature-specific patches based on flags
  apply_framework_signature_patches "$decompile_dir"
  apply_a17_extra_framework "$decompile_dir"
  apply_boot_state_spoof "$decompile_dir"
  apply_app_spoof "$decompile_dir"

  # Apply invoke-custom patches (common to all features)
  # modify_invoke_custom_methods "$decompile_dir"

  recompile_jar "$framework_path" > /dev/null

  rm -rf "$decompile_dir" "$WORK_DIR/framework"

  if [ ! -f "framework_patched.jar" ]; then
    err "Critical Error: framework_patched.jar was not created."
    return 1
  fi
  log "Completed framework.jar patching"
}

# ----------------------------------------------
# Services patches (Android 16)
# ----------------------------------------------

# Apply signature verification bypass patches to services.jar (Android 16)
apply_services_signature_patches() {
  local decompile_dir="$1"

  log "Applying signature verification patches to services.jar (Android 16)..."

  # Resolve smali files across classes*/ to handle layout differences in CI
  resolve_smali_file() {
    # $1: relative path like com/android/server/pm/PackageManagerServiceUtils.smali
    local rel="$1"
    local cand
    for d in "$decompile_dir/classes" "$decompile_dir/classes2" "$decompile_dir/classes3" "$decompile_dir/classes4"; do
      cand="$d/$rel"
      [ -f "$cand" ] && {
        printf "%s\n" "$cand"
        return 0
      }
    done
    # fallback to find to be safe
    find "$decompile_dir" -type f -path "*/$rel" | head -n1
  }

  local pms_utils_file
  pms_utils_file=$(resolve_smali_file "com/android/server/pm/PackageManagerServiceUtils.smali")
  local install_package_helper_file
  install_package_helper_file=$(resolve_smali_file "com/android/server/pm/InstallPackageHelper.smali")
  local reconcile_package_utils_file
  reconcile_package_utils_file=$(resolve_smali_file "com/android/server/pm/ReconcilePackageUtils.smali")

  # checkDowngrade → return-void (all overloads)
  if [ -n "$pms_utils_file" ] && [ -f "$pms_utils_file" ]; then
    patch_return_void_methods_all "checkDowngrade" "$decompile_dir"
    force_methods_return_const "$pms_utils_file" "verifySignatures" "0"
    # force_methods_return_const "$pms_utils_file" "compareSignatures" "0"
    force_methods_return_const "$pms_utils_file" "matchSignaturesCompat" "1"
  else
    warn "PackageManagerServiceUtils.smali not found"
  fi

  # shouldCheckUpgradeKeySetLocked may live outside PMS utils on some builds – try to pin first, then fallback to search
  local should_check_file
  should_check_file=$(resolve_smali_file "com/android/server/pm/KeySetManagerService.smali")
  if [ -n "$should_check_file" ] && [ -f "$should_check_file" ]; then
    force_methods_return_const "$should_check_file" "shouldCheckUpgradeKeySetLocked" "0"
  else
    method_file=$(find_smali_method_file "$decompile_dir" "shouldCheckUpgradeKeySetLocked")
    if [ -n "$method_file" ]; then
      force_methods_return_const "$method_file" "shouldCheckUpgradeKeySetLocked" "0"
    else
      warn "shouldCheckUpgradeKeySetLocked not found"
    fi
  fi

  # Apply shared-user guard in known file path (InstallPackageHelper)
  local invoke_pattern="invoke-interface {p5}, Lcom/android/server/pm/pkg/AndroidPackage;->isLeavingSharedUser()Z"
  if [ -n "$install_package_helper_file" ] && [ -f "$install_package_helper_file" ]; then
    ensure_const_before_if_for_register "$install_package_helper_file" "$invoke_pattern" "if-eqz v3, :" "v3" "1"
  else
    # Fallback to repo-wide search if layout differs
    local fallback_file
    fallback_file=$(grep -s -rl --include='*.smali' "$invoke_pattern" "$decompile_dir" 2> /dev/null | head -n1)
    if [ -n "$fallback_file" ]; then
      ensure_const_before_if_for_register "$fallback_file" "$invoke_pattern" "if-eqz v3, :" "v3" "1"
    else
      warn "InstallPackageHelper.smali not found and pattern not located"
    fi
  fi

  if [ -n "$reconcile_package_utils_file" ] && [ -f "$reconcile_package_utils_file" ]; then
    patch_reconcile_clinit "$reconcile_package_utils_file"
  else
    warn "ReconcilePackageUtils.smali not found"
  fi

  # modify_invoke_custom_methods "$decompile_dir"

  # Emit robust verification logs for CI (avoid brittle hardcoded file paths)
  log "[VERIFY] services: locating isLeavingSharedUser invoke (context)"
  grep -s -R -n --include='*.smali' \
    'invoke-interface {p5}, Lcom/android/server/pm/pkg/AndroidPackage;->isLeavingSharedUser()Z' \
    "$decompile_dir" | head -n 1 || true

  log "[VERIFY] services: verifySignatures/compareSignatures/matchSignaturesCompat presence"
  grep -s -R -n --include='*.smali' '^[[:space:]]*\\.method.* verifySignatures' "$decompile_dir" | head -n 1 || true
  grep -s -R -n --include='*.smali' '^[[:space:]]*\\.method.* compareSignatures' "$decompile_dir" | head -n 1 || true
  grep -s -R -n --include='*.smali' '^[[:space:]]*\\.method.* matchSignaturesCompat' "$decompile_dir" | head -n 1 || true

  log "[VERIFY] services: checkDowngrade methods now return-void"
  grep -s -R -n --include='*.smali' '^[[:space:]]*\.method.*checkDowngrade' "$decompile_dir" | head -n 5 || true

  log "[VERIFY] services: ReconcilePackageUtils <clinit> toggle lines"
  local rpu_file
  rpu_file=$(find "$decompile_dir" -type f -path "*/com/android/server/pm/ReconcilePackageUtils.smali" | head -n1)
  if [ -n "$rpu_file" ]; then
    grep -n '^[[:space:]]*\\.method static constructor <clinit>()V' "$rpu_file" || true
    grep -n 'const/4 v0, 0x[01]' "$rpu_file" | head -n 5 || true
  fi

  log "Signature verification patches applied to services.jar (Android 16)"
}

# Apply disable secure flag patches to services.jar (Android 16)
apply_services_disable_secure_flag() {
  local decompile_dir="$1"

  log "Applying disable secure flag patches to services.jar (Android 16)..."

  # Android 16: Patch WindowState.isSecureLocked()
  log "Patching WindowState.isSecureLocked()..."
  local method_body="    .registers 6\n\n    const/4 v0, 0x0\n\n    return v0"
  replace_entire_method "isSecureLocked()Z" "$decompile_dir" "$method_body" "com/android/server/wm/WindowState"

  log "Disable secure flag patches applied to services.jar (Android 16)"
}

# ---------------------------------------------------------------------------
# Lưới an toàn: chèn WindowState.isBypassSecureFlag() nếu services.jar thiếu.
#
# Triệu chứng trên máy (05/11): bấm chụp màn hình -> đơ một nhịp -> soft reboot.
#   FATAL EXCEPTION IN SYSTEM PROCESS: binder:...
#   java.lang.NoSuchMethodError: No static method isBypassSecureFlag()Z in
#     class Lcom/android/server/wm/WindowState;
#     at WindowManagerServiceImpl.notAllowCaptureDisplay(...)
#     at WindowManagerService.captureDisplay(...)
#
# NGUỒN GỐC THẬT (đính chính so với kết luận đầu tiên): lời gọi đó do CHÍNH
# patch của mình chèn vào - NOTIFICATION_FIX/A17/patch_miui_services_a17.py,
# hàm patch_window_manager_secure_flag. Method này KHÔNG hề tồn tại trong
# services.jar (đã quét cả 4 dex), nên patch đó tạo ra một lời gọi chết.
# Patch ấy đã bị bỏ hẳn; xem commit ngay sau aab1ed2.
#
# Vì sao vẫn giữ stub: nó chỉ được chèn khi method chưa có, trả false =
# "không bỏ qua cờ secure" (đúng hành vi mặc định). Nếu sau này ai bật lại
# patch kia, hoặc ROM nền khác có jar gọi method này, system_server không chết
# vì một dòng lệnh thiếu. Không có caller thì nó là một method thừa vô hại.
inject_windowstate_bypass_stub() {
  local decompile_dir="$1"
  local f
  f=$(find "$decompile_dir" -path "*/com/android/server/wm/WindowState.smali" 2>/dev/null | head -n 1)
  if [ -z "$f" ]; then
    warn "WindowState.smali không thấy trong $decompile_dir - bỏ qua stub"
    return 0
  fi
  if grep -q "isBypassSecureFlag" "$f"; then
    log "WindowState.isBypassSecureFlag đã có - không chèn"
    return 0
  fi
  cat >> "$f" << 'SMALI'

# BugOS: stub phòng hờ cho WindowState.isBypassSecureFlag().
# Xem bin/package/COREPATCH/jar_patcher_a17.sh
.method public static isBypassSecureFlag()Z
    .registers 1

    const/4 v0, 0x0

    return v0
.end method
SMALI
  log "Đã chèn WindowState.isBypassSecureFlag() -> false (phòng hờ, không còn caller)"
}

# Main services patching function (Android 16)
patch_services() {
  local services_path="$work_dir/build/baserom/images/system/system/framework/services.jar"

  # Allow using a pre-existing decompile dir for verification/patching
  local external_dir_flag=0
  local external_dir=""
  if [ -n "${SERVICES_DECOMPILE_DIR:-}" ] && [ -d "${SERVICES_DECOMPILE_DIR}" ]; then
    external_dir_flag=1
    external_dir="${SERVICES_DECOMPILE_DIR}"
  elif [ -d "${WORK_DIR}/services_decompile" ]; then
    external_dir_flag=1
    external_dir="${WORK_DIR}/services_decompile"
  fi

  if [ $external_dir_flag -eq 0 ] && [ ! -f "$services_path" ]; then
    err "services.jar not found at $services_path and no SERVICES_DECOMPILE_DIR provided"
    return 1
  fi

  log "Starting Android 17 services.jar patch"
  local decompile_dir
  if [ $external_dir_flag -eq 1 ]; then
    log "Using existing services decompile dir: $external_dir"
    decompile_dir="$external_dir"
  else
    decompile_dir=$(decompile_jar "$services_path") || return 1
  fi

  # Apply feature-specific patches based on flags
  apply_services_signature_patches "$decompile_dir"
  apply_a17_extra_services "$decompile_dir"
  inject_windowstate_bypass_stub "$decompile_dir"
  #apply_services_disable_secure_flag "$decompile_dir"

  # Apply invoke-custom patches (common to all features)
  # modify_invoke_custom_methods "$decompile_dir"

  if [ $external_dir_flag -eq 0 ]; then
    recompile_jar "$services_path" > /dev/null

    rm -rf "$decompile_dir" "$WORK_DIR/services"
    log "Completed services.jar patching"
  else
    log "Verification completed on existing services decompile dir (no rebuild)"
  fi
}

# ----------------------------------------------
# MIUI services patches (Android 16)
# ----------------------------------------------

# Apply signature verification bypass patches to miui-services.jar (Android 16)
apply_miui_services_signature_patches() {
  local decompile_dir="$1"

  log "Applying signature verification patches to miui-services.jar (Android 16)..."

  # According to the miui-services guide: force specific methods to return-void
  patch_return_void_methods_all "verifyIsolationViolation" "$decompile_dir"
  patch_return_void_methods_all "canBeUpdate" "$decompile_dir"

  # Targeted verification that won't hang
  log "[VERIFY] miui-services: verifyIsolationViolation/canBeUpdate return-void"
  grep -s -R -n --include='*.smali' '^[[:space:]]*\.method.*verifyIsolationViolation' "$decompile_dir" | head -n 5 || true
  grep -s -R -n --include='*.smali' '^[[:space:]]*\.method.*canBeUpdate' "$decompile_dir" | head -n 5 || true

  log "Signature verification patches applied to miui-services.jar (Android 16)"
}

# Apply disable secure flag patches to miui-services.jar (Android 16)
apply_miui_services_disable_secure_flag() {
  local decompile_dir="$1"

  log "Applying disable secure flag patches to miui-services.jar (Android 16)..."

  # Android 16: Patch WindowManagerServiceImpl.notAllowCaptureDisplay()
  log "Patching WindowManagerServiceImpl.notAllowCaptureDisplay()..."
  local method_body="    .registers 9\n\n    const/4 v0, 0x0\n\n    return v0"
  replace_entire_method "notAllowCaptureDisplay(Lcom/android/server/wm/RootWindowContainer;I)Z" "$decompile_dir" "$method_body" "com/android/server/wm/WindowManagerServiceImpl"

  log "Disable secure flag patches applied to miui-services.jar (Android 16)"
}

# Apply Gboard patches
apply_miui_services_gboard() {
  local decompile_dir="$1"
  local expr='s/com.baidu.input_mi/com.google.android.inputmethod.latin/g'

  # sed_all_smali: quét cả smali/, smali_classes2/, ... - xem apk_ops.sh.
  # Bản cũ chỉ trỏ smali/ nên AppBehaviorService (nằm ở dex khác, hoặc đã bị
  # gỡ khỏi bản ROM này) in "sed: can't read" và patch mất tác dụng.
  sed_all_smali "$decompile_dir" "$expr" "com/android/server/devicepolicy/DevicePolicyManagerServiceStubImpl.smali"
  sed_all_smali "$decompile_dir" "$expr" "com/android/server/input/InputManagerServiceStubImpl.smali"
  sed_all_smali "$decompile_dir" "$expr" "com/android/server/inputmethod/InputMethodManagerServiceImpl.smali"
  sed_all_smali "$decompile_dir" "$expr" "com/android/server/wm/ActivityTaskSupervisorImpl.smali"
  sed_all_smali "$decompile_dir" "$expr" "com/android/server/wm/MiuiSplitInputMethodImpl.smali"
  sed_all_smali "$decompile_dir" "$expr" "com/miui/server/security/AppBehaviorService.smali"

  echo "Gboard patches applied to miui-services.jar"
}

# Apply ContentExtension patches
apply_miui_services_contentextension() {
  local decompile_dir="$1"
  replace_line_contains_in_smali_method "IS_INTERNATIONAL_BUILD" "updateContentCatcherWhitelist()V" "    const/4 v0, 0x0" "$decompile_dir/smali/com/android/server/am/ProcessPolicy.smali"
  echo "ContentExtension patches applied to miui-services.jar"
}

# Apply floating
apply_miui_services_floating() {
  local decompile_dir="$1"
  for i in "$decompile_dir/"*"/com/android/server/wm/MiuiFreeFormStackDisplayStrategy.smali"; do
    patch_method_in_file "getMaxMiuiFreeFormStackCount(Ljava/lang/String;Lcom/android/server/wm/MiuiFreeFormActivityStack;)I" 6 "$i"
  done
}

# Main miui-services patching function (Android 16)
patch_miui_services() {
  local miui_services_path="$work_dir/build/baserom/images/system_ext/framework/miui-services.jar"

  # Support external decompile dir like services
  local external_dir_flag=0
  local external_dir=""
  if [ -n "${MIUI_SERVICES_DECOMPILE_DIR:-}" ] && [ -d "${MIUI_SERVICES_DECOMPILE_DIR}" ]; then
    external_dir_flag=1
    external_dir="${MIUI_SERVICES_DECOMPILE_DIR}"
  elif [ -d "${WORK_DIR}/miui-services_decompile" ]; then
    external_dir_flag=1
    external_dir="${WORK_DIR}/miui-services_decompile"
  fi

  if [ $external_dir_flag -eq 0 ] && [ ! -f "$miui_services_path" ]; then
    err "miui-services.jar not found at $miui_services_path and no MIUI_SERVICES_DECOMPILE_DIR provided"
    return 1
  fi

  log "Starting Android 17 miui-services.jar patch"
  local decompile_dir
  if [ $external_dir_flag -eq 1 ]; then
    log "Using existing miui-services decompile dir: $external_dir"
    decompile_dir="$external_dir"
  else
    decompile_dir=$(decompile_jar "$miui_services_path") || return 1
  fi

  # Apply feature-specific patches based on flags
  apply_miui_services_signature_patches "$decompile_dir"
  apply_miui_services_floating "$decompile_dir"
  apply_miui_services_gboard "$decompile_dir"
  apply_miui_services_contentextension "$decompile_dir"

  # Apply invoke-custom patches (common to all features)
  # modify_invoke_custom_methods "$decompile_dir"

  if [ $external_dir_flag -eq 0 ]; then
    recompile_jar "$miui_services_path" > /dev/null

    rm -rf "$decompile_dir" "$WORK_DIR/miui-services"
    log "Completed miui-services.jar patching"
  else
    log "Verification completed on existing miui-services decompile dir (no rebuild)"
  fi
}

# ============================================
# Feature-specific patch functions for miui-framework.jar
# ============================================

# Apply Gboard patches
apply_miui_framework_gboard() {
  local decompile_dir="$1"
  local expr='s/com.baidu.input_mi/com.google.android.inputmethod.latin/g'

  # sed_all_smali: quét cả smali/, smali_classes2/, ... - xem apk_ops.sh
  sed_all_smali "$decompile_dir" "$expr" "android/inputmethodservice/InputMethodServiceInjector.smali"
  sed_all_smali "$decompile_dir" "$expr" "android/view/inputmethod/InputMethodManagerStubImpl.smali"
  sed_all_smali "$decompile_dir" "$expr" "com/android/internal/os/AnrEnhanceImpl.smali"
  sed_all_smali "$decompile_dir" "$expr" "miui/util/HapticFeedbackUtil.smali"

  echo "Gboard patches applied to miui-framework.jar"
}

# Main miui-framework patching function
patch_miui_framework() {
  local miui_framework_path="$work_dir/build/baserom/images/system_ext/framework/miui-framework.jar"

  # Support external decompile dir like framework
  local external_dir_flag=0
  local external_dir=""
  if [ -n "${MIUI_FRAMEWORK_DECOMPILE_DIR:-}" ] && [ -d "${MIUI_FRAMEWORK_DECOMPILE_DIR}" ]; then
    external_dir_flag=1
    external_dir="${MIUI_FRAMEWORK_DECOMPILE_DIR}"
  elif [ -d "${WORK_DIR}/miui-framework_decompile" ]; then
    external_dir_flag=1
    external_dir="${WORK_DIR}/miui-framework_decompile"
  fi

  if [ $external_dir_flag -eq 0 ] && [ ! -f "$miui_framework_path" ]; then
    err "miui-framework.jar not found at $miui_framework_path and no MIUI_FRAMEWORK_DECOMPILE_DIR provided"
    return 1
  fi

  log "Starting Android 17 miui-framework.jar patch"
  local decompile_dir
  if [ $external_dir_flag -eq 1 ]; then
    log "Using existing miui-framework decompile dir: $external_dir"
    decompile_dir="$external_dir"
  else
    decompile_dir=$(decompile_jar "$miui_framework_path") || return 1
  fi

  # Apply Gboard
  apply_miui_framework_gboard "$decompile_dir"

  # Apply invoke-custom patches (common to all features)
  # modify_invoke_custom_methods "$decompile_dir"

  if [ $external_dir_flag -eq 0 ]; then
    recompile_jar "$miui_framework_path" > /dev/null

    rm -rf "$decompile_dir" "$WORK_DIR/miui-framework"
    log "Completed miui-framework.jar patching"
  else
    log "Verification completed on existing miui-framework decompile dir (no rebuild)"
  fi
}

# Main function
# Initialize environment and check tools
FEATURE_DISABLE_SIGNATURE_VERIFICATION=1
FEATURE_DISABLE_SECURE_FLAG=1
init_env
ensure_tools || exit 1

# Patch requested JARs
# FAIL-FAST: mỗi bước phải tạo ra <name>_patched.jar hợp lệ, nếu không thì dừng
# ngay - tuyệt đối không ghi đè jar gốc bằng một jar thiếu patch.
require_patched() {
  local jar="$1" marker="$2"
  if [ ! -s "$jar" ]; then
    err "Không tạo được $jar - dừng (giữ nguyên jar gốc)"
    return 1
  fi
  if ! unzip -t "$jar" >/dev/null 2>&1; then
    err "$jar bị hỏng (không phải ZIP hợp lệ) - dừng"
    return 1
  fi
  if [ -n "$marker" ] && ! grep -aqm1 "$marker" "$jar" 2>/dev/null; then
    err "$jar thiếu class '$marker' - cấu trúc A17 có thể đã đổi, dừng"
    return 1
  fi
  log "$jar OK"
}

# smali 3.0.5 có thể chết khi GHI debug info của dex Android 17:
#   IndexOutOfBoundsException: toIndex = N  (dexlib2 DebugInfoCache.hashCode)
# Lần 1 giữ nguyên debug info; nếu assemble lỗi thì baksmali lại với
# --debug-info false rồi patch lại từ đầu. Mất .line trong stack trace của
# framework, nhưng đổi lấy việc ROM có signature bypass.
run_patch() {
  local fn="$1" base="$2"
  if $fn; then
    return 0
  fi
  warn "$base: patch lần 1 thất bại -> thử lại với --debug-info false"
  export BAKSMALI_OPTS="--debug-info false"
  rm -rf "$WORK_DIR/${base}_decompile"
  rm -f "$WORK_DIR/${base}_patched.jar" "${base}_patched.jar"
  if $fn; then
    warn "$base: patch thành công ở lần 2 (không có debug info)"
    return 0
  fi
  return 1
}

run_patch patch_framework      "framework"      || { err "patch_framework thất bại"; exit 1; }
require_patched "framework_patched.jar" "PackageParser" || exit 1

run_patch patch_services       "services"       || { err "patch_services thất bại"; exit 1; }
require_patched "services_patched.jar" "SystemServer" || exit 1

run_patch patch_miui_services  "miui-services"  || { err "patch_miui_services thất bại"; exit 1; }
require_patched "miui-services_patched.jar" "" || exit 1

run_patch patch_miui_framework "miui-framework" || { err "patch_miui_framework thất bại"; exit 1; }
require_patched "miui-framework_patched.jar" "" || exit 1

# Add patched JARs
mv -f "framework_patched.jar" "$work_dir/build/baserom/images/system/system/framework/framework.jar"
mv -f "services_patched.jar" "$work_dir/build/baserom/images/system/system/framework/services.jar"
mv -f "miui-services_patched.jar" "$work_dir/build/baserom/images/system_ext/framework/miui-services.jar"
mv -f "miui-framework_patched.jar" "$work_dir/build/baserom/images/system_ext/framework/miui-framework.jar"
