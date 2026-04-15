# Windows 10 Fehlercheck - Anleitung

## Beschreibung

Das PowerShell-Script `Windows10_Fehlercheck.ps1` führt eine umfassende Systemüberprüfung von Windows 10 durch und erstellt automatisch ein detailliertes Protokoll.

## Features

- **DISM (Deployment Image Servicing and Management)**
  - CheckHealth: Schnelle Überprüfung auf Beschädigungen
  - ScanHealth: Detaillierte Analyse des System-Images
  - RestoreHealth: Automatische Reparatur beschädigter Komponenten

- **SFC (System File Checker)**
  - Überprüft alle geschützten Systemdateien
  - Repariert beschädigte Dateien automatisch

- **Festplatten-Status**
  - Zeigt Übersicht aller Volumes
  - Optional: CHKDSK beim nächsten Neustart planen

- **Automatisches Logging**
  - Erstellt detailliertes Protokoll auf dem Desktop
  - Zeitstempel im Dateinamen für bessere Organisation

## Verwendung

### Voraussetzungen

- Windows 10
- Administrator-Rechte
- PowerShell 5.1 oder höher

### Installation & Ausführung

1. **Download**
   - Script herunterladen
   - An beliebiger Stelle speichern (z.B. Desktop oder Downloads)

2. **Ausführung**
   - **Rechtsklick** auf `Windows10_Fehlercheck.ps1`
   - **"Mit PowerShell ausführen"** wählen
   - Oder: **"Als Administrator ausführen"**

3. **Bei Execution Policy Fehlern**

   Falls das Script nicht ausgeführt werden kann:

   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

   Danach Script erneut ausführen.

### Ablauf

Das Script führt folgende Schritte automatisch aus:

1. **Administrator-Check** - Prüft ob Script mit Admin-Rechten läuft
2. **DISM CheckHealth** - Erste schnelle Prüfung (~1-2 Minuten)
3. **DISM ScanHealth** - Detaillierte Analyse (~5-10 Minuten)
4. **DISM RestoreHealth** - Reparatur falls nötig (~10-15 Minuten)
5. **SFC Scan** - System File Check (~10-15 Minuten)
6. **Festplatten-Status** - Übersicht der Volumes
7. **CHKDSK-Abfrage** - Optional: Festplattencheck beim nächsten Neustart

### Geschätzte Dauer

- **Ohne CHKDSK**: 20-40 Minuten
- **Mit CHKDSK**: 20-40 Minuten + zusätzliche Zeit beim nächsten Neustart (30-120 Minuten je nach Festplattengröße)

## Log-Datei

Das Script erstellt automatisch eine Log-Datei auf dem Desktop:

```
Windows_Fehlercheck_YYYY-MM-DD_HH-mm-ss.log
```

Beispiel:
```
Windows_Fehlercheck_2026-04-15_14-30-25.log
```

Die Log-Datei enthält:
- Alle Ausgaben von DISM
- Alle Ausgaben von SFC
- Festplatten-Status
- Zeitstempel der Ausführung

## Ergebnisse interpretieren

### DISM Ergebnisse

- **"No component store corruption detected"** = Alles OK
- **"The component store is repairable"** = Fehler gefunden, Reparatur möglich
- **"Restore completed successfully"** = Reparatur erfolgreich

### SFC Ergebnisse

- **"Windows Resource Protection did not find any integrity violations"** = Alles OK
- **"Windows Resource Protection found corrupt files and successfully repaired them"** = Fehler behoben
- **"Windows Resource Protection found corrupt files but was unable to fix some of them"** = Manuelle Nacharbeit nötig

### Bei hartnäckigen Problemen

1. Log-Datei öffnen und nach "Error" oder "Failed" suchen
2. Ereignisanzeige öffnen: `eventvwr.msc`
3. Unter "Windows-Protokolle" → "System" nach kritischen Fehlern suchen
4. Bei Bedarf Script erneut ausführen nach einem Neustart

## Weitere Tools

Nach dem Script-Durchlauf können folgende Tools hilfreich sein:

- **Windows Memory Diagnostic**: `mdsched.exe` (RAM-Test)
- **Ereignisanzeige**: `eventvwr.msc` (Detaillierte Fehlerprotokolle)
- **Disk Cleanup**: `cleanmgr` (Temporäre Dateien entfernen)
- **Windows Update**: Alle Updates installieren

## Sicherheitshinweise

- Das Script führt **keine** irreversiblen Änderungen durch
- Alle Reparaturen basieren auf Windows-eigenen Backup-Mechanismen
- Kein Datenverlust durch DISM/SFC zu erwarten
- CHKDSK kann in seltenen Fällen Daten in lost+found verschieben

## Häufige Fragen (FAQ)

**Q: Kann ich den PC während des Scans verwenden?**
A: Ja, aber der PC wird langsamer sein. Für beste Ergebnisse: Keine ressourcenintensiven Programme verwenden.

**Q: Muss ich CHKDSK ausführen lassen?**
A: Nur wenn Sie Festplatten-Probleme vermuten (z.B. langsame Zugriffe, Abstürze).

**Q: Das Script hängt - was tun?**
A: DISM und SFC können sehr lange dauern. Warten Sie mindestens 30 Minuten bevor Sie abbrechen.

**Q: Kann ich das Script regelmäßig ausführen?**
A: Ja, monatliche Ausführung zur Wartung ist empfehlenswert.

**Q: Was wenn Fehler nicht behoben werden können?**
A: In diesem Fall könnte eine Windows-Reparaturinstallation oder ein In-Place-Upgrade nötig sein.

## Lizenz

Dieses Script ist Open Source und kann frei verwendet und modifiziert werden.

## Support

Bei Problemen oder Fragen:
- GitHub Issues: https://github.com/dajuly20/usb-cable-colors-kabelfarben-kabelcodes/issues

---

**Erstellt**: April 2026
**Version**: 1.0
