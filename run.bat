@echo off
echo Starting XPrint Server (configurable) ...
cd /d %~dp0\app
py server.py
pause
