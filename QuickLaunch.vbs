@echo off
REM Quick Launch - Aimbot Memory Scanner
REM Place this shortcut on your desktop for quick access

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
if "%SCRIPT_DIR:~-1%"=="\" set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

REM Change to the script directory
cd /d "%SCRIPT_DIR%"

REM Run the main launcher with Admin privileges
rundll32.exe shell32.dll,ShellExec_RunDLL "%cd%\LAUNCH-AIMBOT.bat"
