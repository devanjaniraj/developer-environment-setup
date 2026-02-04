# System Requirements

Before starting the installation, make sure your system meets these requirements.

## 🖥️ Hardware Requirements

### Minimum
- **Processor**: Intel Core i5 or equivalent (2.4 GHz or higher)
- **RAM**: 8 GB
- **Storage**: 20 GB free space
- **GPU**: Not required

### Recommended
- **Processor**: Intel Core i7 or equivalent (3.0 GHz or higher)
- **RAM**: 16 GB or more
- **Storage**: 50 GB free space (for multiple projects)
- **GPU**: Optional (for machine learning)

## 💾 Disk Space Requirements

| Component | Space |
|-----------|-------|
| Node.js + npm | 500 MB |
| Python + pip | 1.5 GB |
| Git | 300 MB |
| VS Code + Extensions | 3 GB |
| Docker Desktop | 4 GB |
| Databases (Docker) | 5-10 GB |
| Development Projects | 20+ GB |
| **Total** | **~40 GB** |

## 🖨️ OS Requirements

✅ **Supported**
- Windows 10 (build 1909 or later)
- Windows 11

❌ **Not Supported**
- Windows 7
- Windows 8
- Windows 8.1
- Windows XP or earlier

## 🌐 Network Requirements

- **Internet Connection**: Required for downloads (at least 5 Mbps recommended)
- **Firewall**: Must allow downloads from:
  - nodejs.org
  - python.org
  - github.com
  - docker.com
  - registry.npmjs.org

## 🔐 Administrator Rights

Some components require administrator rights:
- Node.js installation
- Python installation
- Git installation
- Docker Desktop installation
- PowerShell execution policy changes

You'll be prompted if needed.

## 🔄 Pre-Installation Checks

Run this PowerShell script to verify your system:

```powershell
# Check Windows Version
[System.Environment]::OSVersion.VersionString

# Check Available Disk Space
(Get-Volume | Where-Object {$_.DriveLetter -eq 'C'}).SizeRemaining / 1GB

# Check RAM
(Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB

# Check Processor
(Get-CimInstance Win32_Processor).Name
```

## 📋 Checklist

Before installation:
- [ ] Windows 10 or 11
- [ ] 8+ GB RAM
- [ ] 20+ GB free disk space
- [ ] Internet connection
- [ ] Administrator access
- [ ] No conflicting software

## ⚠️ Known Incompatibilities

| Software | Issue | Solution |
|----------|-------|----------|
| Older Docker | May conflict | Update to latest version |
| Python 2.x | Outdated | Remove if present |
| Old Node.js | Outdated | Uninstall old version |
| Norton Antivirus | May block | Add exception or update |

## 🆘 Pre-Installation Issues

### Not enough disk space
- Delete temporary files: `Disk Cleanup` utility
- Clear cache: `%temp%` folder
- Uninstall unused software

### Low RAM
- Close unnecessary applications
- Add more RAM
- Use minimal setup (without Docker)

### Antivirus blocking downloads
- Temporarily disable antivirus during setup
- Or add exceptions for downloads
- Re-enable after installation

---

**Ready?** Go to [Installation Guide](./INSTALLATION_GUIDE.md) to get started.
