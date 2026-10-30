# fix_overlay_format.py

Đổi placeholder số (`%d`, `%i`, `%f`, `%x`, `%o`) thành `%s` trong `values-vi`
của một overlay RRO, rồi build lại + ký lại.

## Khi nào dùng

Khi app crash với:

```
java.util.IllegalFormatConversionException: d != java.lang.String
```

hoặc `MissingFormatArgumentException: Format specifier '%2$s'` (thiếu tham số).

Nguyên nhân: chuỗi dịch dùng `%d` nhưng code truyền `String` vào `String.format`.
`%s` nhận được cả `int`, `float`, `String` nên không bao giờ ném.

## Không nên chạy hàng loạt

Đổi hết `%d` -> `%s` trong cả bộ là **an toàn về crash** nhưng mất định dạng:
`%02d` mất số 0 đệm, `%.1f` mất phần thập phân. Chỉ sửa đúng chuỗi gây crash.

## Dùng

```bash
# xem trước, không ghi
python3 fix_overlay_format.py <overlay.apk> --dry

# sửa tại chỗ (build lại + ký lại + verify)
python3 fix_overlay_format.py <overlay.apk>
```

Cần `JAVA_HOME` trỏ tới JDK, và `bin/apktool/{apke.jar,apksigner.jar}`.
Keystore `bugos.jks` (mật khẩu `bugos123`) là khoá dùng một lần cho overlay hệ
thống - không phải bí mật, RRO ở `/product/overlay` không cần cùng chữ ký với
app đích.
