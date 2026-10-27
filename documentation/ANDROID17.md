# Android target separation (A16 / A17)

Tài liệu này mô tả cách BugOS tách nhánh theo phiên bản Android **mà không di chuyển
file nào**. Cấu trúc cũ (`bin/modfile/OS1..OS4`, `bin/package/...`) được giữ nguyên;
việc tách thực hiện bằng **quy ước đặt tên + cổng chặn build**.

---

## 1. Nguyên tắc

1. Mỗi phiên bản Android có một file khai báo: `bin/ddevice/targets/android<VER>.env`.
2. `build.sh` gọi `bin/ddevice/target_check.sh` **ngay sau khi bung ROM**, trước mọi bước mod.
3. Thiếu file khai báo, hoặc thiếu bất kỳ file trong `REQUIRED_FILES` → **dừng build**.
4. Mod dùng chung chỉ được sửa khi đã chạy lại build A16 để kiểm tra hồi quy.

---

## 2. Thêm một phiên bản Android mới (ví dụ A18)

```bash
# 1. Tạo file khai báo
cp bin/ddevice/targets/android17.env bin/ddevice/targets/android18.env
#    sửa TARGET_ANDROID=18, TARGET_SDK=38, TARGET_STATUS=experimental

# 2. Tạo patcher framework (bắt buộc - nếu thiếu, ROM sẽ không boot được)
cp bin/package/COREPATCH/jar_patcher_a17.sh bin/package/COREPATCH/jar_patcher_a18.sh
#    sửa API_LEVEL=38, đổi nhãn log

# 3. Thêm nhánh vào router
#    bin/package/COREPATCH/update.sh  -> elif [[ $AndroidVER == "18" ]]

# 4. Tạo bộ notification fix
cp -r bin/package/NOTIFICATION_FIX/A17 bin/package/NOTIFICATION_FIX/A18
#    sửa --api 38 và các đường dẫn A17 -> A18 bên trong

# 5. Build thử, đọc log, chỉ đặt TARGET_STATUS=stable khi đã test trên máy thật
```

Không cần sửa `build.sh`, `patchpackage.sh`, `insupdate.sh`, `insfile.sh`.

---

## 3. Thành phần dùng chung vs riêng

| Dùng chung được (đã kiểm chứng) | Phải riêng theo phiên bản |
|---|---|
| `Fonts` (regex `^OS[3-9]`) | `COREPATCH/jar_patcher_a*.sh` |
| `MultiLang` (regex `^OS[4-9]`) | `NOTIFICATION_FIX/A*/` |
| `Settings_AdvancedTexture` (prop) | `FCM_NotificationFix` (engine chỉ có strategy A16) |
| `Xiaomi_NoLowEnd` (prop) | `KouseiPatcher/toolbox.py` (anchor smali) |
| `Google_DefaultOn` (prop + APKEditor) | `thememanager` OS3/OS4 (APK ThemeManager) |
| `DISABLE_AVB` (vbmeta) | `gmsservices/maps/A*` |
| `Settings_ROMInformation` (APKEditor) | |

`Settings_ROMInformation`, `Settings_GoogleShowUpCN`, `System_MultiDisableFeature`,
`Framework_Fix*` nằm ở nhóm "dùng chung nhưng **chưa kiểm chứng** trên A17" — chúng
dựa vào anchor smali hoặc `--api $sdkLevel`, có thể trượt. Khi trượt chúng chỉ bỏ qua
(không làm hỏng ROM), nhưng phải đọc log để biết.

---

## 4. Điều kiện tiên quyết để ROM boot được

`COREPATCH` bypass verify chữ ký APK trong `framework.jar`. **Thiếu nó thì mọi APK đã
mod bị từ chối nạp** → Settings có thể biến mất, system_server lỗi dây chuyền.

Vì vậy `jar_patcher_a*.sh` là file bắt buộc trong `REQUIRED_FILES`, và router
`COREPATCH/update.sh` **exit 1** nếu không có nhánh cho phiên bản hiện tại (trước đây
nó im lặng bỏ qua — đó là lỗi nguy hiểm nhất đã sửa).

---

## 5. Fake Lock

Ba tầng, bật/tắt bằng `config.env: install_toolbox=true`.

| Tầng | File | Ghi chú |
|---|---|---|
| cmdline `vendor_boot.img` | `KouseiPatcher/fakelock_patch.sh` | có backup + rollback trong script |
| prop | `KouseiPatcher/prop/build.prop` + `cust.prop` | đã dedupe |
| hook framework | `KouseiPatcher/patcher.sh` + `toolbox.py` | fail-fast, có backup/restore |

**Không khoá bootloader thật.** Nó spoof attestation + prop báo cáo. AVB vẫn đang tắt
(`DISABLE_AVB`) — đó là điều kiện để chạy ROM mod nội dung `/system`.

Nếu patch trượt, `patcher.sh` **giữ nguyên jar gốc** và in cảnh báo rõ; ROM vẫn boot,
chỉ là trạng thái lock/integrity là thật.

---

## 6. Kiểm thử tối thiểu trước khi coi một target là `stable`

- [ ] Build xong không có `[ERROR]` từ `target_check.sh`, `COREPATCH`, `FCM`
- [ ] `getprop ro.build.version.release` đúng phiên bản
- [ ] Settings mở được, logo + OS version đúng
- [ ] Cài 1 app từ CH Play được (chứng minh GMS + signature bypass hoạt động)
- [ ] Nhận được push notification khi màn hình tắt
- [ ] `getprop ro.boot.flash.locked` / `ro.boot.verifiedbootstate` đúng như mong đợi
- [ ] Reboot 2 lần, các mục trên vẫn đúng
- [ ] Rollback: `git reset --hard <tag>` + flash lại bản trước

Mốc rollback hiện có: tag `m0-a16-stable-20261027`.
