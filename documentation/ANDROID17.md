# Target Android: chỉ còn OS4 / Android 17

Tài liệu này mô tả cách BugOS áp mod theo phiên bản Android. Cấu trúc
`bin/modfile/OS<n>` + `bin/package/...` được giữ nguyên; việc tách thực hiện bằng
**quy ước đặt tên + cổng chặn build**.

## Trạng thái hiện tại

Repo **chỉ build OS4 trên Android 17**. Mọi nhánh khác đã bị xoá:

| Đã xoá | Ghi chú |
|---|---|
| `bin/modfile/OS1`, `OS2` | chỉ còn dispatcher, không có mod nào |
| `bin/modfile/OS3` | cùng LauncherMod v7.5F và các mod OS3 |
| `targets/android15.env`, `android16.env` | không còn target tương ứng |
| `COREPATCH/jar_patcher_a13..a16.sh` | chỉ giữ `a17` |
| `NOTIFICATION_FIX/A13..A16/` | chỉ giữ `A17` |
| `gmsservices/maps/A13..A15/` | chỉ giữ `A17` |

`bin/package/COREPATCH/update.sh` **exit 1** nếu Android không phải 17, và
`target_check.sh` chặn build khi thiếu `targets/android<VER>.env`.

---

## 1. Nguyên tắc

1. Mỗi phiên bản Android có một file khai báo: `bin/ddevice/targets/android<VER>.env`.
2. `build.sh` gọi `bin/ddevice/target_check.sh` **ngay sau khi bung ROM**, trước mọi bước mod.
3. Thiếu file khai báo, hoặc thiếu bất kỳ file trong `REQUIRED_FILES` → **dừng build**.
4. Mod dùng chung chỉ được sửa khi đã chạy lại build và thử trên máy thật.

---

## 2. Thêm một phiên bản Android mới (ví dụ A18)

```bash
# 1. Khai báo target
cp bin/ddevice/targets/android17.env bin/ddevice/targets/android18.env
#    sửa TARGET_ANDROID=18, TARGET_SDK=38, TARGET_STATUS=experimental

# 2. Patcher framework (bắt buộc - thiếu là ROM không boot)
cp bin/package/COREPATCH/jar_patcher_a17.sh bin/package/COREPATCH/jar_patcher_a18.sh
#    sửa API_LEVEL=38, đổi nhãn log

# 3. Mở khoá router: bin/package/COREPATCH/update.sh
#    hiện chỉ nhận "17"; thêm nhánh cho 18.

# 4. Bộ notification fix
cp -r bin/package/NOTIFICATION_FIX/A17 bin/package/NOTIFICATION_FIX/A18
#    sửa --api 38 và đường dẫn A17 -> A18 bên trong

# 5. Build thử, đọc log, chỉ đặt TARGET_STATUS=stable khi đã test trên máy thật
```

Không cần sửa `build.sh`, `patchpackage.sh`, `insupdate.sh`, `insfile.sh` — chúng
dispatch theo thư mục.

---

## 3. Thành phần dùng chung vs riêng

| Dùng chung được | Phải riêng theo phiên bản |
|---|---|
| `Fonts`, `MultiLang` (regex `^OS[4-9]`) | `COREPATCH/jar_patcher_a*.sh` |
| `Settings_AdvancedTexture` (prop) | `NOTIFICATION_FIX/A*/` |
| `Xiaomi_NoLowEnd` (prop) | `SukiSU/patch.sh` (KMI theo kernel) |
| `DISABLE_AVB` (vbmeta) | `gmsservices/maps/A*` |
| `Settings_ROMInformation` (APKEditor) | `PRECHINAFIX/patches/*.json` (theo base ROM) |

`Settings_ROMInformation`, `Settings_GoogleShowUpCN`, `System_MultiDisableFeature`,
`Framework_Fix*` nằm ở nhóm "dùng chung nhưng **cần rà lại** khi đổi base ROM":
chúng dựa vào anchor smali hoặc `--api $sdkLevel`, nên có thể trượt. Khi trượt
chúng chỉ bỏ qua (không làm hỏng ROM), nhưng phải đọc log để biết.

---

## 4. Điều kiện tiên quyết để ROM boot được

`COREPATCH` bypass verify chữ ký APK trong `framework.jar`. **Thiếu nó thì mọi APK
đã mod bị từ chối nạp** → Settings có thể biến mất, system_server lỗi dây chuyền.

Điều này càng quan trọng với `PRECHINAFIX`: 5 file nó vá đều **sai chữ ký** sau khi
sửa. Không có COREPATCH là cả bộ de-China không nạp được.

`jar_patcher_a17.sh` là file bắt buộc trong `REQUIRED_FILES`, và router
`COREPATCH/update.sh` exit 1 nếu không phải Android 17.

---

## 5. Root và trạng thái bootloader

ROM **không tự giả** trạng thái bootloader ở tầng hệ thống. Bộ hook Kaorios
(KouseiPatcher) đã bị gỡ khỏi cây: `KaoriosHook.getSpoofedProperty` không có caller
nào trong payload, nên tầng đó chưa bao giờ đổi được `ro.boot.*`, còn khối SELinux
cho `AdvancedPolicyService` của nó đã hai lần làm máy rơi vào fastboot.

ROM **có root sẵn** — SukiSU Ultra 4.3.0-r1, chế độ LKM:

| Việc | File | Ghi chú |
|---|---|---|
| vá kernel | `SukiSU/patch.sh` | `boot-patch-v2` nhúng `kernelsu.ko` vào `boot.img` |
| KMI | tự dò từ chuỗi version kernel | override bằng `config.env: sukisu_kmi` |
| manager | `product/app/SukiSUUltra` | `com.sukisu.ultra` 4.3.0-r1, cùng tag với .ko |

`ksud` chạy trên host mượn của KernelSU-Next 3.4.2 vì SukiSU chỉ phát hành bản
Android (link bionic). Phần sinh capsule của hai bên giống nhau ở đúng hai tag đang
dùng — xem chú thích đầu `bin/package/SukiSU/patch.sh`.

Việc giả trạng thái/attestation chuyển sang module KSU (PIF, keybox, SUSFS) — cài
sau khi flash, không nhúng vào ROM.

**Không khoá bootloader thật.** AVB vẫn tắt (`DISABLE_AVB`) — điều kiện để chạy ROM
mod nội dung `/system`.

---

## 6. Kiểm thử tối thiểu trước khi coi một target là `stable`

- [ ] Build xong không có `[ERROR]` từ `target_check.sh`, `COREPATCH`
- [ ] `getprop ro.build.version.release` đúng phiên bản
- [ ] Settings mở được, logo + OS version đúng
- [ ] Cài 1 app từ CH Play được (chứng minh GMS + signature bypass hoạt động)
- [ ] Nhận được push notification khi màn hình tắt
- [ ] Reboot 2 lần, các mục trên vẫn đúng
- [ ] Rollback: `git reset --hard <tag>` + flash lại bản trước

---

## 7. Chuỗi vá file hệ thống trên Android 17

Ba bước, thứ tự cố định (`build.sh`):

1. **PRECHINAFIX** (trước `insupdate.sh`) — vá 5 file bằng bảng patch method:
   `MiuiSystemUI`, `PowerKeeper`, `Settings`, `miui-services.jar`,
   `miui-framework.jar`. Tổng 69 file / 209 method.
2. **insupdate.sh** — `Settings_ROMInformation` decode lại `Settings.apk` **đã vá**
   rồi mới gắn branding BugOS.
3. **COREPATCH** (trong `patchpackage.sh`) — decompile rồi vá + **ghi đè** 2 jar.
   Vì vậy nó phải chạy SAU PRECHINAFIX, để patch de-China nằm sẵn trong bản được vá
   và COREPATCH chỉ thêm phần bypass chữ ký.

`PRECHINAFIX` dùng cách **thay nguyên thân method** (không chèn byte thô), nên patch
vẫn sống sau khi COREPATCH decompile + build lại jar.

### Vì sao PowerKeeper không dùng apke.jar

Trên A17, `apke.jar b` không dựng lại được `PowerKeeper.apk`. Bản cũ rơi vào nhánh
"giữ nguyên bản gốc", nên bản vá không được áp mà build vẫn báo thành công. Từ
commit `57f1792`, chỉ thay `classes*.dex` bên trong APK
(`bin/tools/apk_dex_patch.py`); mọi entry khác copy nguyên byte.

Dex ghi `STORED` + canh 4 byte; `resources.arsc` và `.so` cũng được canh lại vì kích
thước dex đổi làm lệch offset của chúng. Thiếu canh lề thì PackageManager từ chối
APK trong priv-app (targetSdk ≥ 30) → SystemUI biến mất khỏi danh sách package.

### FCM: đã tắt

`FCM_NotificationFix` đã bị xoá khỏi cây. Vector V4 của nó vá
`BroadcastQueueModernStubImpl.checkApplicationAutoStart` — trùng method với bộ
PRECHINAFIX. Nếu cần bật lại, phải rà lại thứ tự hai bên.

### Kiểm tra sau khi flash

```sh
adb shell dumpsys deviceidle | head -5
adb shell settings get global device_provisioned
# app có nhận push khi tắt màn hình không (Zalo/Telegram/Messenger)
```
