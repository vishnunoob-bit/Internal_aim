# Aimbot Memory Scanner - FIXED BUILD

✅ **All build issues have been fixed!**

A high-performance C# memory scanning tool for pattern detection and memory manipulation in external processes.

## Features

✅ **Ultra-fast AoB (Array of Bytes) Pattern Scanning**
- Parallel processing for maximum speed
- Wildcard support (`??` for unknown bytes)
- Configurable memory region filtering

✅ **Memory Manipulation**
- Read/Write integer, float, double, long, string values
- Hex pattern support
- Offset-based addressing

✅ **Windows Integration**
- Direct kernel32.dll P/Invoke calls
- VirtualQueryEx for memory enumeration
- ReadProcessMemory/WriteProcessMemory operations

## Requirements

- **Windows 7+**
- **.NET Framework 4.7.2+**
- **Administrator Privileges** (required for process access)
- **Visual Studio 2019+** (for development)

## Quick Start

### Option 1: Visual Studio (Easiest)
1. Open `AimbotScanner.sln` in Visual Studio
2. Press `Ctrl+Shift+B` to build
3. Run with Administrator privileges

### Option 2: Command Line (Admin)
```batch
Build-and-Run.bat
```

### Option 3: PowerShell (Admin)
```powershell
.\Build-and-Run.ps1
```

## Build Fixes Applied

✅ Fixed MSB4057 error (CreateManifestResourceNames target not found)
✅ Fixed MSB4226 error (MSBuild import paths)
✅ Added correct Windows Forms build targets
✅ Proper .csproj configuration

## Project Structure

```
Internal_aim/
├── AimbotScanner.sln              # Visual Studio Solution
├── WindowsFormsApp1/
│   ├── Form1.cs                   # Main UI Form
│   ├── Form1.Designer.cs          # Auto-generated form designer
│   ├── Form1.resx                 # Form resources
│   ├── Program.cs                 # Entry point
│   ├── app.config                 # App configuration
│   └── WindowsFormsApp1.csproj    # Project file (FIXED)
├── CROXY.cs                       # Memory scanning engine
├── Build-and-Run.bat              # Batch build script
├── Build-and-Run.ps1              # PowerShell build script
├── RUN-ME.bat                     # Auto-launch script
├── START-HERE.bat                 # Quick start script
├── README.md                      # This file
├── LICENSE                        # MIT License
└── QUICK-START.md                 # Quick start guide
```

## Usage Example

```csharp
INTERNAL scanner = new INTERNAL();

// Open process
Process proc = Process.GetProcessesByName("HD-Player").FirstOrDefault();
if (scanner.OpenProcess(proc.Id))
{
    // Define pattern (bytes + wildcards)
    string pattern = "FF FF FF FF 00 00 00 00 ?? ?? ?? ?? 00 00 00 00";
    
    // Scan for pattern
    var results = await scanner.AoBScan(pattern, writable: true);
    
    // Write to found addresses
    foreach (long addr in results)
    {
        scanner.WriteMemory(addr.ToString("X"), "int", "12345");
    }
}
```

## Troubleshooting

### Build Succeeds but won't run?
- Ensure you're running as Administrator
- Check that Visual Studio is up to date

### "Process not found"?
- Make sure HD-Player is running
- Check the process name spelling

### Still having issues?
- Clean the solution: `Build → Clean Solution`
- Delete `bin/` and `obj/` folders manually
- Rebuild: `Ctrl+Shift+B`

## Security & Disclaimer

⚠️ **Warning**: This tool is for educational purposes only. Using it on online games or protected software may violate their Terms of Service and applicable laws.

**Only use on:**
- Personal single-player games
- Your own applications
- Educational/research projects

## License

MIT License - See LICENSE file for details

## Support

For issues or questions:
- Check the troubleshooting section above
- Review the QUICK-START.md for step-by-step instructions
