# Payload Kaorios Toolbox 2.0.6.1

`classes.dex` — payload chính thức của upstream, không sửa byte nào.

| | |
|---|---|
| Nguồn | https://github.com/hzzmonetvn/Kaorios-Toolbox/releases/download/v2.0.6.1/classes.dex |
| Kích thước | 171 100 byte |
| SHA-256 | `953a25a2f7569eb11b107bda591bcbd0ad0d30e0c6d33def51799478ea1e93a9` |
| DEX version | 039 |
| Class | 66 (payload cũ của bản Kousei là 316 smali) |

`patcher.sh` kiểm hash trước khi dùng và baksmali tại chỗ (`jar_temp/kaorios-payload-smali`)
để đưa vào `--payload-smali` của patcher — nhờ vậy bản smali luôn khớp byte với
bản phát hành, không có smali chép tay nào bị lệch.

Muốn đổi payload: tải bản mới, cập nhật `PAYLOAD_SHA` trong `patcher.sh` cùng
bảng trên. Đừng sửa smali rồi baksmali ngược lại.

## Vì sao không sửa smali trực tiếp

Đã kiểm bằng cách baksmali rồi assemble lại chính payload này: 448/450 method ra
byte-identical, 2 method còn lại chỉ lệch 1 index string (bảng string đổi thứ
tự) — tức vòng round-trip trung thực. Nhưng nếu sửa tay thì hash không còn khớp
bản upstream, và mọi so sánh "payload này có đúng bản phát hành không" sẽ mất
giá trị.

## Ghi chú về API

Payload 2.0.6.1 đã bỏ `filterSettingsCall`, `filterSettingsQueryResult`,
`filterSettingValue`, `shouldRemoveSetting` — 4 method mà recipe cũ gọi từ
`SettingsProvider.apk`. Vì vậy **không được vá SettingsProvider** bằng recipe
cũ, sẽ `NoSuchMethodError` trong system_server. Repo này không vá file đó.
