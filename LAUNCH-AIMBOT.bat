@echo off
REM Aimbot Memory Scanner - Direct Launch
REM This script builds and runs the application automatically

setlocal enabledelayedexpansion

color 0B
echo.
echo ========================================
echo   Aimbot Memory Scanner
echo   Direct Launch v2.0
echo ========================================
echo.

REM Check if running as Administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: This script must be run as Administrator!
    echo.
    echo SOLUTION:
    echo 1. Right-click on LAUNCH-AIMBOT.bat
    echo 2. Select "Run as Administrator"
    echo.
    pause
    exit /b 1
)

echo [OK] Running with Administrator privileges
echo.

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
if "!SCRIPT_DIR:~-1!"=="\" set "SCRIPT_DIR=!SCRIPT_DIR:~0,-1!"

echo [*] Current directory: !SCRIPT_DIR!
echo [*] Checking for AimbotScanner.sln...
echo.

REM Change to the script directory
cd /d "!SCRIPT_DIR!"

if %errorLevel% neq 0 (
    echo ERROR: Failed to change directory!
    echo Directory: !SCRIPT_DIR!
    echo.
    pause
    exit /b 1
)

REM Check for solution file
if NOT exist "AimbotScanner.sln" (
    echo ERROR: AimbotScanner.sln not found!
    echo Expected: !SCRIPT_DIR!\AimbotScanner.sln
    echo.
    echo Make sure you're running this from the correct repository folder.
    echo.
    pause
    exit /b 1
)

echo [OK] Found AimbotScanner.sln
echo [*] Searching for Visual Studio...
echo.

if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019" (
    set "VS_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2019"
    echo [OK] Visual Studio 2019 found
) else if exist "C:\Program Files\Microsoft Visual Studio\2022" (
    set "VS_PATH=C:\Program Files\Microsoft Visual Studio\2022"
    echo [OK] Visual Studio 2022 found (64-bit)
) else if exist "C:\Program Files (x86)\Microsoft Visual Studio\2022" (
    set "VS_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2022"
    echo [OK] Visual Studio 2022 found (32-bit)
) else (
    echo ERROR: Visual Studio not found!
    echo.
    echo SOLUTION:
    echo 1. Download Visual Studio Community 2022
    echo 2. Visit: https://visualstudio.microsoft.com/downloads/
    echo 3. Install with ".NET desktop development" workload
    echo 4. Restart your PC
    echo 5. Run this script again
    echo.
    pause
    exit /b 1
)

echo [*] Looking for MSBuild.exe...
echo.

for /f "delims=" %%A in ('dir /s /b "!VS_PATH!\MSBuild.exe" 2^>nul ^| findstr /r ".*MSBuild.exe$" ') do (
    set "MSBUILD=%%A"
    goto :found_msbuild
)

echo ERROR: MSBuild.exe not found!
echo VS Path: !VS_PATH!
echo.
pause
exit /b 1

:found_msbuild
echo [OK] MSBuild found: !MSBUILD!
echo.
echo [*] Building solution in Release mode...
echo.

"!MSBUILD!" "AimbotScanner.sln" /p:Configuration=Release /p:Platform="Any CPU" /m

if %errorLevel% neq 0 (
    echo.
    echo ========================================
    echo   BUILD FAILED
    echo ========================================
    echo.
    echo ERROR CODE: %errorLevel%
    echo.
    echo SOLUTIONS:
    echo 1. Delete these folders and try again:
    echo    - bin/
    echo    - obj/
    echo    - WindowsFormsApp1/bin/
    echo    - WindowsFormsApp1/obj/
    echo.
    echo 2. If still failing:
    echo    - Close all instances of Visual Studio
    echo    - Delete .vs/ hidden folder
    echo    - Try again
    echo.
    echo 3. Last resort:
    echo    - Open Visual Studio manually
    echo    - Open AimbotScanner.sln
    echo    - Press Ctrl+Shift+B to build
    echo.
    pause
    exit /b 1
)

echo.
echo [OK] Build completed successfully!
echo.
echo [*] Looking for executable...
echo.

if exist "WindowsFormsApp1\bin\Release\WindowsFormsApp1.exe" (
    set "EXE_PATH=!SCRIPT_DIR!\WindowsFormsApp1\bin\Release\WindowsFormsApp1.exe"
) else (
    echo ERROR: Executable not found!
    echo Expected: !SCRIPT_DIR!\WindowsFormsApp1\bin\Release\WindowsFormsApp1.exe
    echo.
    echo The build completed but the .exe was not created.
    echo Try building manually in Visual Studio.
    echo.
    pause
    exit /b 1
)

echo [OK] Executable found!
echo.
echo [*] Launching Aimbot Memory Scanner...
echo.

start "Aimbot Memory Scanner" "!EXE_PATH!"

if %errorLevel% neq 0 (
    echo ERROR: Failed to launch application!
    echo Path: !EXE_PATH!
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================
echo   SUCCESS!
echo   Aimbot is launching...
echo ========================================
echo.
echo Window will close in 5 seconds...
echo.

timeout /t 5 /nobreak
exit /b 0
