@echo off
REM Build standalone EXE with PyInstaller (onefile)
cd /d %~dp0\app

REM Ensure pyinstaller is installed
py -m pip install pyinstaller -U

REM Build
py -m PyInstaller --onefile --name xprint_server server.py

REM Copy config.json next to EXE so users can edit it
copy /Y config.json dist\config.json >NUL

echo.
echo Build done. Run: dist\xprint_server.exe
pause
