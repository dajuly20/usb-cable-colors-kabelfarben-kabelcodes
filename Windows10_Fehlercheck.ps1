# Windows 10 System-Fehlercheck Script
# Dieses Script muss als Administrator ausgeführt werden!

# Überprüfe Administrator-Rechte
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Dieses Script muss als Administrator ausgeführt werden!"
    Write-Host "Bitte mit Rechtsklick -> 'Als Administrator ausführen' starten" -ForegroundColor Red
    pause
    exit
}

# Log-Datei erstellen
$LogFile = "$env:USERPROFILE\Desktop\Windows_Fehlercheck_$(Get-Date -Format 'yyyy-MM-dd_HH-mm-ss').log"
Start-Transcript -Path $LogFile

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Windows 10 System-Fehlercheck" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Log-Datei: $LogFile" -ForegroundColor Green
Write-Host ""

# 1. DISM Check
Write-Host "[1/5] DISM CheckHealth wird ausgefuehrt..." -ForegroundColor Yellow
DISM /Online /Cleanup-Image /CheckHealth
Write-Host ""

Write-Host "[2/5] DISM ScanHealth wird ausgefuehrt..." -ForegroundColor Yellow
Write-Host "(Dies kann einige Minuten dauern...)" -ForegroundColor Gray
DISM /Online /Cleanup-Image /ScanHealth
Write-Host ""

Write-Host "[3/5] DISM RestoreHealth wird ausgefuehrt..." -ForegroundColor Yellow
Write-Host "(Dies kann bis zu 15 Minuten dauern...)" -ForegroundColor Gray
DISM /Online /Cleanup-Image /RestoreHealth
Write-Host ""

# 2. System File Checker
Write-Host "[4/5] System File Checker (SFC) wird ausgefuehrt..." -ForegroundColor Yellow
Write-Host "(Dies kann 10-15 Minuten dauern...)" -ForegroundColor Gray
sfc /scannow
Write-Host ""

# 3. Festplatten-Check Status
Write-Host "[5/5] Festplatten-Status wird geprueft..." -ForegroundColor Yellow
Get-Volume | Format-Table -AutoSize
Write-Host ""

# Optional: CHKDSK planen
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Moechten Sie CHKDSK beim naechsten Neustart ausfuehren?" -ForegroundColor Cyan
Write-Host "Dies prueft die Festplatte auf physische Fehler." -ForegroundColor Gray
Write-Host "WARNUNG: Der naechste Neustart wird laenger dauern!" -ForegroundColor Red
$response = Read-Host "CHKDSK planen? (J/N)"

if ($response -eq "J" -or $response -eq "j") {
    Write-Host "CHKDSK wird beim naechsten Neustart ausgefuehrt..." -ForegroundColor Green
    echo Y | chkdsk C: /f /r
} else {
    Write-Host "CHKDSK wurde uebersprungen." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Fehlercheck abgeschlossen!" -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Log-Datei wurde gespeichert unter:" -ForegroundColor Green
Write-Host "$LogFile" -ForegroundColor White
Write-Host ""

# Ereignisanzeige-Hinweis
Write-Host "Tipp: Oeffnen Sie die Ereignisanzeige fuer detaillierte Fehler:" -ForegroundColor Cyan
Write-Host "  eventvwr.msc" -ForegroundColor White
Write-Host ""

Stop-Transcript

Write-Host "Druecken Sie eine Taste zum Beenden..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
