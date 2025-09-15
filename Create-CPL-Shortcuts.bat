@echo off
REM Creates CPL shortcuts by calling the PowerShell script next to this BAT.
REM Double-click this file to run.

setlocal
set SCRIPT=%~dp0Create-CPL-Shortcuts.ps1

if not exist "%SCRIPT%" (
  echo PowerShell-Skript nicht gefunden: "%SCRIPT%"
  echo Bitte stelle sicher, dass Create-CPL-Shortcuts.ps1 im gleichen Ordner liegt.
  pause
  exit /b 1
)

REM Use a per-process ExecutionPolicy to avoid permanent changes
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT%"
if %ERRORLEVEL% NEQ 0 (
  echo Fehler beim Ausfuehren des PowerShell-Skripts. (%ERRORLEVEL%)
  pause
  exit /b %ERRORLEVEL%
)

echo Fertig. Der Ordner "CPL" wurde auf dem Desktop erstellt.
pause
