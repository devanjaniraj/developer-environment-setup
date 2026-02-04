# 📦 Complete Installation Guide

This guide provides step-by-step instructions to set up your complete development environment.

## Table of Contents
1. [System Requirements](#system-requirements)
2. [Automated Setup (Recommended)](#automated-setup-recommended)
3. [Manual Installation](#manual-installation)
4. [Verification](#verification)
5. [Troubleshooting](#troubleshooting)

---

## System Requirements

### Minimum Requirements
- **OS**: Windows 10 (Build 2004+) or Windows 11
- **RAM**: 8 GB (16 GB recommended)
- **Disk Space**: 10 GB free
- **CPU**: Dual-core processor (4+ cores recommended)
- **Internet**: Stable connection (for downloads)
- **Admin Rights**: Required for installation

### Optional Requirements
- Docker Desktop (requires Hyper-V or WSL 2)
- VS Code (highly recommended)

---

## Automated Setup (Recommended)

### Step 1: Clone the Repository

Open PowerShell and run:

```powershell
git clone https://github.com/devanjaniraj/developer-environment-setup.git
cd developer-environment-setup
```

### Step 2: Enable Execution Policy

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
```

### Step 3: Run Setup Script

```powershell
.\scripts\setup.ps1
```

Or with options:

```powershell
# Skip Docker installation
.\scripts\setup.ps1 -SkipDocker

# Skip VS Code extensions
.\scripts\setup.ps1 -SkipExtensions

# Quiet mode (no output)
.\scripts\setup.ps1 -Quiet
```

### Step 4: Restart PowerShell

Close and reopen PowerShell to apply all environment changes.

### Step 5: Verify Installation

```powershell
.\scripts\verify-installation.ps1
```

---

## Manual Installation

If the automated script fails, follow these steps manually:

### 1. Install Node.js

1. Visit https://nodejs.org/ (LTS version)
2. Download the Windows installer (64-bit)
3. Run the installer
4. Check "Add to PATH" during installation
5. Complete installation

Verify:
```powershell
node --version
npm --version
```

### 2. Install Python

1. Visit https://www.python.org/downloads/
2. Download Python 3.11 or later
3. Run the installer
4. **Important**: Check "Add Python to PATH" ✓
5. Click "Install Now"

Verify:
```powershell
python --version
pip --version
```

### 3. Install Git

1. Visit https://git-scm.com/download/win
2. Download the latest version (64-bit)
3. Run the installer
4. Keep default options
5. Click through installation

Verify:
```powershell
git --version
```

### 4. Install Docker Desktop

1. Visit https://www.docker.com/products/docker-desktop
2. Download Docker Desktop for Windows
3. Run the installer
4. Choose installation type (Hyper-V or WSL 2)
5. Complete installation
6. Restart computer

Verify:
```powershell
docker --version
docker run hello-world
```

### 5. Install VS Code

1. Visit https://code.visualstudio.com/
2. Download for Windows (64-bit)
3. Run the installer
4. Check "Add to PATH" ✓
5. Complete installation

Verify:
```powershell
code --version
```

### 6. Install VS Code Extensions

Option A - Automated:
```powershell
.\scripts\setup.ps1 -SkipExtensions:$false
```

Option B - Manual:
```powershell
code --install-extension ms-python.python
code --install-extension ms-vscode.cpptools
code --install-extension ms-vscode-remote.remote-containers
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension GitHub.copilot
code --install-extension ms-azuretools.vscode-docker
```

---

## Configuration

### Configure Git User

```powershell
git config --global user.name "Your Name"
git config --global user.email "Kanjanikumar52@gmail.com"
git config --global core.editor "code --wait"
```

### Configure Python Virtual Environment

```powershell
# Create virtual environment
python -m venv venv

# Activate it
venv\Scripts\activate

# Deactivate when done
deactivate
```

### Start Docker Databases

```powershell
cd developer-environment-setup
docker-compose up -d
```

---

## Verification

### Quick Verification

```powershell
node -v      # Should show v20.11+
npm -v       # Should show 10.5+
python -v    # Should show 3.11+
git -v       # Should show 2.40+
docker -v    # Should show 29.0+
```

### Comprehensive Verification

Run the verification script:
```powershell
.\scripts\verify-installation.ps1
```

---

## Common Issues

### Issue: Command Not Found

**Solution**:
1. Close all PowerShell windows
2. Open new PowerShell window
3. Restart your computer
4. Try command again

### Issue: PowerShell Execution Policy Error

**Solution**:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
```

### Issue: Docker Won't Start

**Solution**:
1. Make sure Docker Desktop is running
2. Check if Hyper-V is enabled
3. Restart Docker Desktop
4. Restart your computer

### Issue: npm install fails

**Solution**:
```powershell
npm cache clean --force
npm install
```

---

## Next Steps

1. **Create a Project**: See [QUICK_START.md](./QUICK_START.md)
2. **Learn Node.js**: See [NODEJS_SETUP.md](./NODEJS_SETUP.md)
3. **Learn Python**: See [PYTHON_SETUP.md](./PYTHON_SETUP.md)
4. **Configure Docker**: See [DOCKER_SETUP.md](./DOCKER_SETUP.md)
5. **Setup Git**: See [GIT_SETUP.md](./GIT_SETUP.md)

---

## Support

- 📖 Check [FAQ.md](./FAQ.md) for common questions
- 🐛 See [TROUBLESHOOTING.md](./TROUBLESHOOTING.md) for issues
- 🔍 Check [ERROR_REFERENCE.md](./ERROR_REFERENCE.md) for error codes
- 💬 Open a [GitHub Issue](https://github.com/devanjaniraj/developer-environment-setup/issues)


