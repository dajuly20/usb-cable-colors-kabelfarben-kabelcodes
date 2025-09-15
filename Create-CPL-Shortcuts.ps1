# Creates a "CPL" folder on the current user's Desktop and populates it
# with categorized shortcuts to common Windows Run (Win+R) commands.
# Usage: Right-click this file > "Run with PowerShell"
# Or:   powershell -ExecutionPolicy Bypass -File .\Create-CPL-Shortcuts.ps1

$ErrorActionPreference = "Stop"

# Resolve Desktop path
$desktop = [Environment]::GetFolderPath('Desktop')
$root    = Join-Path $desktop 'CPL'

# Create root folder
New-Item -ItemType Directory -Path $root -Force | Out-Null

# Helper: create shortcut via WScript.Shell
function New-RunShortcut {
    param(
        [Parameter(Mandatory=$true)][string]$Folder,
        [Parameter(Mandatory=$true)][string]$Name,
        [Parameter(Mandatory=$true)][string]$Command
    )
    if (-not (Test-Path $Folder)) {
        New-Item -ItemType Directory -Path $Folder -Force | Out-Null
    }
    # Safe filename (remove invalid chars)
    $fileName = ($Name -replace '[\\/:*?\"<>|]', ' ').Trim()
    $lnkPath  = Join-Path $Folder ($fileName + ' (' + $Command + ').lnk')

    $wsh = New-Object -ComObject WScript.Shell
    $sc  = $wsh.CreateShortcut($lnkPath)

    # Use cmd.exe + start so we can launch .cpl/.msc/aliases reliably
    $sc.TargetPath = $env:ComSpec
    $sc.Arguments  = '/c start "" ' + $Command
    $sc.WorkingDirectory = $env:WINDIR
    # Optional: use a generic Control Panel icon (imageres.dll, -67) or leave default
    # $sc.IconLocation = "$env:SystemRoot\system32\imageres.dll,67"
    $sc.Save()
}

# Categories and commands (friendly name => command as used in Win+R)
$catalog = @{
    '⚙️ Systemsteuerung & Verwaltung' = @{
        'Programme und Features'                        = 'control appwiz.cpl'
        'Systemsteuerung'                               = 'control'
        'Verwaltung'                                    = 'control admintools'
        'Computerverwaltung'                            = 'compmgmt.msc'
        'Netzwerkverbindungen'                          = 'ncpa.cpl'
        'Energieoptionen'                               = 'powercfg.cpl'
        'Aufgabenplanung'                               = 'taskschd.msc'
        'Datenträgerverwaltung'                         = 'diskmgmt.msc'
        'Ereignisanzeige'                               = 'eventvwr'
        'Dienste'                                       = 'services.msc'
        'Systemeigenschaften'                           = 'sysdm.cpl'
    }
    '🔐 Sicherheit & Benutzer' = @{
        'Zertifikate – Lokaler Computer'                = 'certlm.msc'
        'Zertifikate – Aktueller Benutzer'              = 'certmgr.msc'
        'Benutzerkonten'                                = 'netplwiz'
        'Lokale Benutzer und Gruppen'                   = 'lusrmgr.msc'
        'Anmeldeinfos sichern / wiederherstellen'       = 'credwiz'
        'Windows Produktschlüssel ändern'               = 'slui'
    }
    '🎨 Darstellung & Eingabe' = @{
        'Zeichentabelle'                                = 'charmap'
        'Farbverwaltung'                                = 'colorcpl'
        'Bildschirmauflösung'                           = 'desk.cpl'
        'Soundeinstellungen'                            = 'mmsys.cpl'
        'Maus-Einstellungen'                            = 'main.cpl'
        'Tastatureinstellungen'                         = 'control keyboard'
        'Bildschirmtastatur'                            = 'osk'
        'Stift- und Fingereingabe'                      = 'TabletPC.cpl'
    }
    '🌍 Internet & Netzwerk' = @{
        'Internetoptionen'                              = 'inetcpl.cpl'
        'Windows-Firewall'                              = 'firewall.cpl'
        'Firewall – Erweiterte Einstellungen'           = 'wf.msc'
        'Freigegebene Ordner'                           = 'fsmgmt.msc'
        'Ordnerfreigaben erstellen'                     = 'shrpubw'
        'Wählhilfe'                                     = 'dialer'
    }
    '🛠️ Tools & Diagnosen' = @{
        'Eingabeaufforderung'                           = 'cmd'
        'DirectX-Diagnose'                              = 'dxdiag'
        'Leistungsüberwachung'                          = 'perfmon.msc'
        'Registrierungseditor'                          = 'regedit'
        'Systemkonfiguration'                           = 'msconfig'
        'Systeminformationen'                           = 'msinfo32'
        'Speicherdiagnose'                              = 'mdsched'
        'Systemwiederherstellung'                       = 'rstrui'
        'Treiberüberprüfung'                            = 'verifier'
    }
    '🖼️ Programme & Extras' = @{
        'Rechner'                                       = 'calc'
        'Paint'                                         = 'mspaint'
        'Paint (pbrush Alias)'                          = 'pbrush'
        'Editor (Notepad)'                              = 'notepad'
        'WordPad'                                       = 'write'
        'Windows Media Player'                          = 'wmplayer'
        'Task-Manager'                                  = 'taskmgr'
        'Bildschirmlupe'                                = 'magnify'
        'Mobilitätscenter (Notebooks)'                  = 'mblctr'
        'Windows Explorer'                              = 'explorer'
        'Datenträgerbereinigung'                        = 'cleanmgr'
    }
    '📅 Datum & Uhrzeit' = @{
        'Datum und Uhrzeit'                             = 'timedate.cpl'
    }
    'ℹ️ Informationen' = @{
        'Windows-Version'                               = 'winver'
        'WMI-Kontrolle'                                 = 'wmimgmt.msc'
        'Sicherheit und Wartung'                        = 'wscui.cpl'
    }
}

# Build shortcuts
foreach ($category in $catalog.Keys) {
    $folder = Join-Path $root $category
    foreach ($kv in $catalog[$category].GetEnumerator()) {
        $name    = $kv.Key
        $command = $kv.Value
        New-RunShortcut -Folder $folder -Name $name -Command $command
    }
}

Write-Host "CPL-Verknüpfungen wurden erstellt unter: $root" -ForegroundColor Green
