# USB Cable Colors & Windows CPL Shortcuts

Dieses Repository sammelt verschiedene Informationen und Skripte zu USB-Kabelfarben und Windows-Systemsteuerungs-Verknüpfungen.

## Inhalte

- [`usb-color-codes.md`](./usb-color-codes.md)  
  Übersicht und Farbcodes von USB-Kabeln, zur besseren Unterscheidung und Dokumentation.

- [`windows-cpl-pages.md`](./windows-cpl-pages.md)  
  Sammlung von Windows Control Panel (CPL) Befehlen mit Beschreibungen.

- [`Create-CPL-Shortcuts.ps1`](./Create-CPL-Shortcuts.ps1)  
  PowerShell-Skript, das automatisch Verknüpfungen zu den CPL-Befehlen im Ordner *Desktop/CPL* erstellt.

- [`Create-CPL-Shortcuts.bat`](./Create-CPL-Shortcuts.bat)  
  Batch-Datei, die das PowerShell-Skript einfacher aufrufen lässt.

- [`Makefile`](./Makefile)  
  Enthält Befehle zum Erstellen von PDF-Dokumenten aus den Markdown-Dateien.

## Hinweis

Die vorherige `README.md` wurde nach [`details.md`](./details.md) verschoben, um Konflikte zu vermeiden.

---

**[Dieses Repository auf GitHub ansehen](https://github.com/dajuly20/usb-cable-colors-kabelfarben-kabelcodes)**  


**[Download als ZIP z.B. für Windows Clientrechner (main branch)](https://github.com/dajuly20/usb-cable-colors-kabelfarben-kabelcodes/archive/refs/heads/main.zip)**


## Powershell Scripte  

```
  Get-NetAdapter | ForEach-Object { 
      ipconfig /release $_.InterfaceAlias
      ipconfig /renew $_.InterfaceAlias
  }
  Clear-DnsClientCache
  Get-DnsClientServerAddress
```
