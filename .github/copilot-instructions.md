# Copilot Instructions

This repository is a reference collection for USB cable color coding and Windows system administration shortcuts. It serves as a practical documentation and automation toolkit for IT management.

## Project Structure & Purpose

The repository combines two main domains:
- **Cable Management**: Color-coded USB cable organization system (`usb-color-codes.md`)
- **Windows Administration**: CPL/MSC command shortcuts and automation (`windows-cpl-pages.md`, PowerShell scripts)

## Key Components

### USB Cable Color System
- `usb-color-codes.md` uses German documentation with emoji-based color coding
- Reference image: `img/USB-Typen-II.jpg` shows visual USB connector types
- Standard: 🟨 Yellow=USB-C, 🟦 Blue=USB-A, 🟪 Purple=USB-Micro, 🟥 Red=USB-Mini
- Generation markers: ⚡3️⃣ for USB 3.0, 🐌2️⃣ for USB 2.0, ❌ for charge-only cables
- Format follows table structure with Farbe/Symbol and Bedeutung columns

### Windows CPL Automation
- `Create-CPL-Shortcuts.ps1` creates Desktop shortcuts for Windows control panel commands
- Uses `WScript.Shell` COM object to generate .lnk files in categorized folders
- Commands are organized by category (System, Security, Display, Network)
- `Create-CPL-Shortcuts.bat` provides simple double-click execution wrapper

## Development Patterns

### Documentation Style
- Mixed German/English content (German for user-facing docs, English for technical comments)
- Emoji prefixes for visual categorization (⚙️ System, 🔐 Security, 🎨 Display, 🌍 Network)
- Table format with pipe separators for structured data

### PowerShell Conventions
- Use `$ErrorActionPreference = "Stop"` for fail-fast behavior
- Sanitize filenames with regex: `$Name -replace '[\\/:*?\"<>|]', ' '`
- Use `cmd.exe /c start` wrapper for reliable .cpl/.msc execution
- Organize commands in hashtables with friendly names as keys

### Build System
- `Makefile` uses pandoc for PDF generation from markdown
- Target files: `readme.md` → `Kabelmanagement_Farblegende.pdf`
- Install target provides Ubuntu/Debian pandoc installation

## File Naming & Organization
- German compound words in filenames (e.g., `Kabelmanagement_Farblegende.pdf`)
- Hyphenated repository name reflects dual language nature
- Scripts maintain .ps1/.bat pair for PowerShell execution flexibility
- Visual assets stored in `img/` directory (e.g., `USB-Typen-II.jpg` for connector reference)

## When Contributing
- Maintain emoji-based categorization system in documentation
- Follow existing German documentation patterns for user-facing content  
- Use English for technical implementation details and comments
- Test PowerShell scripts with `-ExecutionPolicy Bypass` for portability
- Update both markdown tables and PowerShell hashtables when adding new commands

## Build Commands
```bash
make pdf          # Generate PDF from markdown
make install      # Install pandoc dependency
```

## PowerShell Execution
```cmd
Create-CPL-Shortcuts.bat                    # Simple execution
powershell -ExecutionPolicy Bypass -File Create-CPL-Shortcuts.ps1  # Direct execution
```