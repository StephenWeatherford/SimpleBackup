@echo off
set "extensions=*.dorico,*.pdf"
set "ps1Path=%USERPROFILE%\repos\SimpleBackup\SimpleBackup.ps1"

if not exist "%ps1Path%" (
    echo ERROR: Could not find PowerShell script at "%ps1Path%"
    pause
    exit /b 1
)

powershell -ExecutionPolicy Bypass -File "%ps1Path%" "%CD%" "%extensions%"
rem pause