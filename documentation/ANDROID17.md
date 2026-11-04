# Android target separation (A16 / A17)

Tài liệu này mô tả cách BugOS tách nhánh theo phiên bản Android **mà không di chuyển
file nào**. Cấu trúc `bin/modfile/OS<n>` + `bin/package/...` được giữ nguyên; việc tách
thực hiện bằng **quy ước đặt tên + cổng chặn build**.

`bin/modfile/OS1` và `OS2` đã bị xoá — chúng chỉ còn dispatcher, không có mod nào bên
trong. Còn lại `OS3` và `OS4`, mỗi cái tự thoát nếu `rom_os` không khớp.

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
| `Xiaomi_NoLowEnd` (prop) | `KernelSU/patch.sh` (KMI theo kernel) |
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

## 5. Root và trạng thái bootloader

ROM **không còn tự giả** trạng thái bootloader. Bộ hook Kaorios (KouseiPatcher) đã bị
gỡ khỏi cây: `KaoriosHook.getSpoofedProperty` không có caller nào trong payload, nên
tầng đó chưa bao giờ đổi được `ro.boot.*`, còn khối SELinux cho `AdvancedPolicyService`
của nó đã hai lần làm máy rơi vào fastboot.

Thay vào đó ROM **có root sẵn** — KernelSU Next 3.4.2, chế độ LKM:

| Việc | File | Ghi chú |
|---|---|---|
| vá kernel | `KernelSU/patch.sh` | `ksud boot-patch-v2` nhúng `kernelsu.ko` vào `boot.img` |
| KMI | tự dò từ chuỗi version kernel | override bằng `config.env: kernelsu_kmi` |
| manager | `product/app/KernelSUNext` | APK 3.4.2, cùng tag với ksud và .ko |

Việc giả trạng thái/attestation chuyển sang module KSU (PIF, keybox, SUSFS) — cài sau
khi flash, không nhúng vào ROM.

Ba tầng prop của BugOS vẫn giữ nguyên và độc lập với root:
`prop_fix_boot_state` (ghi thẳng vùng property từ init), `boot_state_spoof` (vá
`SystemProperties` trong `framework.jar`), `getprop_spoof` (wrapper `getprop`).

**Không khoá bootloader thật.** AVB vẫn tắt (`DISABLE_AVB`) — điều kiện để chạy ROM
mod nội dung `/system`.

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

---

## 7. Chuỗi vá thông báo trên Android 17

Ba thành phần, chạy theo thứ tự cố định:

1. **FCM_NotificationFix** (bước UpdateFile) — vá `services.jar` + `miui-services.jar`,
   engine tự chọn profile Android 16 vì chưa có profile cho SDK 37. Anchor theo tên
   class/method nên vẫn khớp; log in rõ 4/4 vector.
2. **COREPATCH** (bước package) — giải nén lại chính các jar trên và vá chữ ký.
3. **NOTIFICATION_FIX/A17** — `PowerKeeper.apk` + `miui-services.jar` (CN_MODEL,
   IS_INTERNATIONAL_BUILD).

### Vì sao PowerKeeper không dùng apke.jar nữa

Trên A17, `apke.jar b` không dựng lại được `PowerKeeper.apk`. Bản A16 rơi vào nhánh
"giữ nguyên bản gốc", nên **bản vá thông báo không được áp** mà build vẫn báo thành
công. Từ commit `57f1792`, A17 chỉ thay `classes*.dex` bên trong APK
(`bin/tools/apk_dex_patch.py`); mọi entry khác copy nguyên byte nên không còn bước
nào có thể hỏng vì resource.

Dex được ghi `STORED` + canh 4 byte; `resources.arsc` và `.so` cũng được canh lại vì
kích thước dex đổi làm lệch offset của chúng.

### Kiểm tra sau khi flash

```sh
adb shell dumpsys deviceidle | head -5
adb shell settings get global device_provisioned
# app có nhận push khi tắt màn hình không (Zalo/Telegram/Messenger)
```

Nếu vẫn mất thông báo, lấy log và tìm đúng dòng:
- `Fail: ...PowerKeeper.apk` → bước thay dex hỏng, gửi log
- `Cảnh báo: PowerKeeper không tham chiếu IS_INTERNATIONAL_BUILD` → A17 đổi field,
  cần tên field mới
- `Cảnh báo: CN_MODEL chỉ được đọc` → chỗ ghi đã đổi cách
