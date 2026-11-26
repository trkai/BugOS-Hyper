@echo off
chcp 65001 >nul 2>&1
setlocal EnableExtensions EnableDelayedExpansion
cd /d "%~dp0"
mode con: cols=92 lines=34 >nul 2>&1
color 0B
title Classic ROM Installer

set "FASTBOOT=META-INF\fastboot"
set "ZSTD=META-INF\zstd"
set "DEVICE_FILE=META-INF\Data\DeviceCode"
set "BAR==========================================================================================="

echo(!BAR!
echo   CLASSIC ROM INSTALLER
echo(!BAR!
echo.
echo   [i] Đọc kỹ trước khi flash  /  Read before flashing
echo.
echo    1. Cần bootloader ĐÃ MỞ KHÓA. Nếu chưa, đóng cửa sổ này ngay.
echo    2. Chọn sai sẽ MẤT TOÀN BỘ DỮ LIỆU. Hãy chắc chắn.
echo    3. ROM MIỄN PHÍ. Nếu thấy ai bán / thu tiền cài, liên hệ Admin.
echo    4. Không chịu trách nhiệm nếu máy brick hoặc mất dữ liệu.
echo    5. Kiểm tra kỹ bản ROM phải đúng model thiết bị.
echo.
echo   Đã đọc và đồng ý? Nhấn phím bất kỳ để tiếp tục.
echo   (Đóng cửa sổ nếu chưa sẵn sàng.)
pause >nul 2>&1

echo(!BAR!
echo   CHỌN CHẾ ĐỘ FLASH  /  FLASH MODE
echo.
echo    [Y] Xóa sạch dữ liệu  - Clean flash  (format userdata)
echo    [N] Giữ lại dữ liệu   - Dirty flash  (keep data)
echo(!BAR!
set "CHOICE="
set /p "CHOICE=   Nhập lựa chọn [Y/N]: "
if /I "!CHOICE!"=="y" (set "CHOICE=y") else (set "CHOICE=n")
echo    -^> Chế độ đã chọn: !CHOICE!

echo(!BAR!
echo   KIỂM TRA THIẾT BỊ  /  DEVICE CHECK
echo.
echo   Đưa thiết bị vào FASTBOOT MODE.
echo   Nếu không nhận, cài driver rồi chạy lại.
echo(!BAR!
title Classic ROM Installer - Device check

if not exist "%DEVICE_FILE%" (
    color 0E
    echo   [X] Thiếu file: %DEVICE_FILE%
    pause
    exit /b 1
)
if not exist "%FASTBOOT%" if not exist "%FASTBOOT%.exe" (
    color 0E
    echo   [X] Thiếu fastboot: %FASTBOOT%
    pause
    exit /b 1
)
if not exist "%ZSTD%" if not exist "%ZSTD%.exe" (
    color 0E
    echo   [X] Thiếu zstd: %ZSTD%
    pause
    exit /b 1
)

set "DEVICE_ROM="
set /p "DEVICE_ROM=" <"%DEVICE_FILE%"

set "DEVICE_REAL="
set "SLOTS="
for /f "tokens=2" %%a in ('!FASTBOOT! getvar product 2^>^&1 ^| findstr /l /b /c:"product:"') do set "DEVICE_REAL=%%a"
for /f "tokens=2" %%a in ('!FASTBOOT! getvar slot-count 2^>^&1 ^| findstr /l /b /c:"slot-count:"') do set "SLOTS=%%a"

if "!SLOTS!"=="2" (set "FLASH_MODE=AB") else (set "FLASH_MODE=A")
if "!DEVICE_REAL!"=="mars" set "DEVICE_REAL=star"

echo(!DEVICE_REAL! | findstr /b /c:"!DEVICE_ROM!" >nul 2>&1
if errorlevel 1 (
    color 0E
    echo   [X] SAI MÃ THIẾT BỊ  /  DEVICE CODE MISMATCH
    echo       Thiết bị: !DEVICE_REAL!   ^|   ROM này: !DEVICE_ROM!
    pause
    exit /b 1
)

echo   [OK] Thiết bị : !DEVICE_REAL!
echo   [OK] ROM      : !DEVICE_ROM!
echo   [OK] Slot     : !FLASH_MODE!
echo   [OK] Chế độ   : !CHOICE!

echo(!BAR!
echo   TIẾN TRÌNH  /  PROGRESS
set /a TOTAL=0
for %%F in (*.img.zst) do set /a TOTAL+=1
for %%F in ("images\*") do (
    set "PART=%%~nF"
    if /I "!PART!"=="cust" (
        set /a TOTAL+=1
    ) else if /I "!PART!"=="preloader_raw" (
        set /a TOTAL+=4
    ) else if /I "!PART:~0,6!"=="vbmeta" (
        if "!FLASH_MODE!"=="AB" (set /a TOTAL+=2) else (set /a TOTAL+=1)
    ) else if "!FLASH_MODE!"=="AB" (
        set /a TOTAL+=2
    ) else (
        set /a TOTAL+=1
    )
)
if exist "super.img" set /a TOTAL+=1
if /I "!CHOICE!"=="y" set /a TOTAL+=3
if "!FLASH_MODE!"=="AB" set /a TOTAL+=1
set /a TOTAL+=1
set /a DONE=0
call :PROGRESS !DONE! !TOTAL!

echo(!BAR!
echo   GIẢI NÉN IMAGE  /  EXTRACTING
for %%F in (*.img.zst) do (
    set "NAME=%%~nF"
    set "NAME=!NAME:.img=!"
    del /q "!NAME!.img" >nul 2>&1
    echo    - !NAME!
    !ZSTD! -d "%%F" -o "!NAME!.img"
    set /a DONE+=1
    call :PROGRESS !DONE! !TOTAL!
)

echo(!BAR!
echo   FLASH ROM
title Classic ROM Installer - Flashing
for %%F in ("images\*") do (
    set "PART=%%~nF"
    set "URL=%%F"
    if /I "!PART!"=="cust" (
        !FASTBOOT! flash !PART! "!URL!" >nul 2>&1
        echo    - cust  [ok]
        set /a DONE+=1
        call :PROGRESS !DONE! !TOTAL!
    ) else if /I "!PART!"=="preloader_raw" (
        !FASTBOOT! flash preloader_a "!URL!" >nul 2>&1
        !FASTBOOT! flash preloader_b "!URL!" >nul 2>&1
        !FASTBOOT! flash preloader1 "!URL!" >nul 2>&1
        !FASTBOOT! flash preloader2 "!URL!" >nul 2>&1
        echo    - preloader a/b/1/2  [ok]
        set /a DONE+=4
        call :PROGRESS !DONE! !TOTAL!
    ) else if "!FLASH_MODE!"=="AB" (
        !FASTBOOT! flash !PART!_a "!URL!"
        !FASTBOOT! flash !PART!_b "!URL!"
        set /a DONE+=2
        call :PROGRESS !DONE! !TOTAL!
    ) else (
        !FASTBOOT! flash !PART! "!URL!"
        set /a DONE+=1
        call :PROGRESS !DONE! !TOTAL!
    )
)

if exist "super.img" (
    echo    - super
    !FASTBOOT! flash super super.img
    del /q "super.img" >nul 2>&1
    set /a DONE+=1
    call :PROGRESS !DONE! !TOTAL!
)

if /I "!CHOICE!"=="y" (
    echo(!BAR!
    echo   FORMAT DATA
    !FASTBOOT! erase frp >nul 2>&1
    !FASTBOOT! erase userdata >nul 2>&1
    !FASTBOOT! erase metadata >nul 2>&1
    echo    - frp / userdata / metadata  [ok]
    set /a DONE+=3
    call :PROGRESS !DONE! !TOTAL!
)

echo(!BAR!
echo   HOÀN TẤT  /  ALL DONE
echo   Thiết bị sẽ tự khởi động lại. Vui lòng đợi 10-15 phút.
if "!FLASH_MODE!"=="AB" (
    !FASTBOOT! set_active a >nul 2>&1
    set /a DONE+=1
    call :PROGRESS !DONE! !TOTAL!
)
!FASTBOOT! reboot
set /a DONE+=1
call :PROGRESS !DONE! !TOTAL!
echo(!BAR!
title Classic ROM Installer - Done
pause
endlocal
exit /b 0

:PROGRESS
setlocal EnableDelayedExpansion
set "CUR=%~1"
set "TOT=%~2"
if %TOT% LEQ 0 set "TOT=1"
set /a PCT=CUR*100/TOT
set /a FILLED=PCT/5
set "FILL="
set "EMPTY="
for /L %%n in (1,1,%FILLED%) do set "FILL=!FILL!#"
set /a REST=20-%FILLED%
for /L %%n in (1,1,%REST%) do set "EMPTY=!EMPTY!."
echo(  [!FILL!!EMPTY!] !PCT!%%
endlocal
exit /b 0
