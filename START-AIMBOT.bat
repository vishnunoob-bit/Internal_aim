@echo off
REM Simple One-Click Launcher
REM Just double-click this file to start Aimbot!

REM Get current directory
for /f "delims=" %%A in ('cd') do set "DIR=%%A"

REM Launch with admin rights
powershell -Command "Start-Process cmd -ArgumentList '/c cd /d \"!DIR!\" && LAUNCH-AIMBOT.bat' -Verb RunAs"
