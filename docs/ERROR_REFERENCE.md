# 🔍 Error Reference Guide

Complete reference for common error codes and solutions.

## Installation Errors

### ERROR: Setup script not found

**Error Message**: 
```
The term '.\scripts\setup.ps1' is not recognized
```

**Cause**: Script execution policy blocked or incorrect path

**Solution**:
```powershell
# Enable execution policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# Verify script exists
Get-ChildItem scripts\

# Run from correct directory
cd developer-environment-setup
.\scripts\setup.ps1
```

---

### ERROR: Admin rights required

**Error Message**:
```
This script should be run as Administrator
```

**Cause**: Script needs elevated privileges

**Solution**:
1. Right-click PowerShell
2. Select "Run as administrator"
3. Try script again

---

### ERROR: Internet connection failed

**Error Message**:
```
Failed to download: Unable to connect to the remote server
```

**Cause**: Network issue or server unavailable

**Solution**:
```powershell
# Check internet
Test-NetConnection www.google.com

# Check specific server
Test-NetConnection nodejs.org -Port 443

# Try again after waiting
# Or manually download installers
```

---

## Node.js Errors

### ERROR: node: command not found

**Error Message**:
```
node : The term 'node' is not recognized
```

**Cause**: Node.js not installed or not in PATH

**Solutions**:
1. Reinstall Node.js from https://nodejs.org
2. Add to PATH during installation
3. Close and reopen PowerShell
4. Restart computer

---

### ERROR: npm ERR! 404 Not Found

**Error Message**:
```
npm ERR! 404 Not Found - GET https://registry.npmjs.org/package-name
```

**Cause**: Package doesn't exist or typo in name

**Solution**:
```powershell
# Check package name
npm search package-name

# Verify correct spelling
npm install correct-package-name
```

---

### ERROR: npm ERR! code EACCES

**Error Message**:
```
npm ERR! code EACCES
npm ERR! syscall open
npm ERR! path /usr/local/lib/node_modules
```

**Cause**: Permission denied

**Solution**:
```powershell
# Run as administrator
# Or use --no-save-dev flag
npm install package-name --no-save-dev

# Or clear cache
npm cache clean --force
npm install
```

---

### ERROR: npm ERR! code ENOENT

**Error Message**:
```
npm ERR! code ENOENT
npm ERR! syscall open
npm ERR! path C:\path\package.json
```

**Cause**: Missing package.json file

**Solution**:
```powershell
# Create package.json
npm init -y

# Or run from project root
cd my-project
npm install
```

---

## Python Errors

### ERROR: python: command not found

**Error Message**:
```
python : The term 'python' is not recognized
```

**Cause**: Python not installed or not in PATH

**Solution**:
1. Download Python 3.11+ from https://www.python.org
2. **Important**: Check "Add Python to PATH"
3. Complete installation
4. Restart PowerShell and computer

---

### ERROR: ModuleNotFoundError

**Error Message**:
```
ModuleNotFoundError: No module named 'requests'
```

**Cause**: Module not installed or not in current venv

**Solution**:
```powershell
# Activate venv
venv\Scripts\activate

# Install module
pip install requests

# Or install from requirements
pip install -r requirements.txt

# Check if installed
pip show requests
```

---

### ERROR: No module named venv

**Error Message**:
```
No module named venv
```

**Cause**: venv not available (Python missing or broken)

**Solution**:
```powershell
# Check Python version
python --version

# Should be 3.3+, if not reinstall

# Try this to create venv
python -m venv venv

# If still fails, reinstall Python
```

---

## Git Errors

### ERROR: fatal: not a git repository

**Error Message**:
```
fatal: not a git repository (or any of the parent directories): .git
```

**Cause**: Not inside a Git repository

**Solution**:
```powershell
# Initialize git
git init

# Or navigate to repository
cd my-project

# Or clone repository
git clone https://github.com/user/repo.git
```

---

### ERROR: fatal: Authentication failed

**Error Message**:
```
fatal: Authentication failed for 'https://github.com/user/repo.git'
```

**Cause**: Wrong credentials or expired token

**Solution**:

**HTTPS**:
1. Create personal access token on GitHub
2. Use token instead of password
3. GitHub → Settings → Developer settings → Personal access tokens

**SSH**:
```powershell
# Generate SSH key
ssh-keygen -t ed25519

# Add to SSH agent
ssh-add $env:USERPROFILE\.ssh\id_ed25519

# Add public key to GitHub
# GitHub → Settings → SSH and GPG keys
```

---

### ERROR: Your local changes would be overwritten

**Error Message**:
```
error: Your local changes to the following files would be overwritten by merge:
```

**Cause**: Uncommitted changes conflict with pull

**Solution**:
```powershell
# Stash changes
git stash

# Pull changes
git pull

# Apply stashed changes
git stash pop

# Or discard changes
git reset --hard
git pull
```

---

## Docker Errors

### ERROR: Cannot connect to Docker daemon

**Error Message**:
```
error during connect: This error may indicate that the docker daemon is not running
```

**Cause**: Docker Desktop not running

**Solution**:
1. Open Docker Desktop
2. Wait for it to start (watch taskbar)
3. Try command again
4. If failing, restart Docker Desktop

---

### ERROR: Port is already allocated

**Error Message**:
```
Error response from daemon: driver failed programming external connectivity on endpoint
```

**Cause**: Port already in use

**Solution**:
```powershell
# Find process using port
netstat -ano | findstr :5432

# Kill process (replace PID)
taskkill /PID 1234 /F

# Or change port in docker-compose.yml
# Or stop conflicting container
docker-compose down
```

---

### ERROR: insufficient space on device

**Error Message**:
```
docker: Error response from daemon: "write error: insufficient space on device"
```

**Cause**: Out of disk space

**Solution**:
```powershell
# Clean up Docker
docker system prune

# Remove volumes
docker volume prune

# Remove images
docker image prune

# Full cleanup
docker system prune -a --volumes
```

---

### ERROR: docker-compose command not found

**Error Message**:
```
docker-compose : The term 'docker-compose' is not recognized
```

**Cause**: docker-compose not installed

**Solution**:
```powershell
# Modern Docker uses docker compose (space, not dash)
docker compose --version

# Or install separately
pip install docker-compose

# Or update Docker Desktop
```

---

## VS Code Errors

### ERROR: code: The term 'code' is not recognized

**Error Message**:
```
code : The term 'code' is not recognized
```

**Cause**: VS Code not in PATH

**Solution**:
1. Reinstall VS Code
2. Check "Add to PATH" during installation
3. Close and reopen PowerShell
4. Or use full path

---

### ERROR: Extension installation failed

**Error Message**:
```
Error: ENOENT: no such file or directory
```

**Cause**: VS Code corrupted or permission issue

**Solution**:
```powershell
# Clear VS Code cache
rm -r $env:APPDATA\Code\User\globalStorage

# Uninstall and reinstall VS Code

# Or try installing extension from command line
code --install-extension ms-python.python
```

---

## Network Errors

### ERROR: Connection refused

**Error Message**:
```
connect ECONNREFUSED 127.0.0.1:5432
```

**Cause**: Service not running on port

**Solution**:
```powershell
# Check if Docker running
docker ps

# Start Docker services
docker-compose up -d

# Verify service is listening
Test-NetConnection localhost -Port 5432
```

---

### ERROR: DNS resolution failed

**Error Message**:
```
getaddrinfo ENOTFOUND registry.npmjs.org
```

**Cause**: Network or DNS issue

**Solution**:
```powershell
# Check internet
Test-NetConnection www.google.com

# Test DNS
nslookup registry.npmjs.org

# Change npm registry
npm config set registry https://registry.npmjs.org/

# Or use different registry
npm config set registry https://registry.npmmirror.com
```

---

## Compilation Errors

### ERROR: cc: command not found

**Error Message**:
```
fatal error: 'node.h' file not found
compilation terminated.
```

**Cause**: C++ compiler missing

**Solution**:
```powershell
# Install Visual Studio Build Tools
# Or install with npm
npm install --global windows-build-tools

# Then try npm install again
npm install
```

---

## Memory Errors

### ERROR: JavaScript heap out of memory

**Error Message**:
```
FATAL ERROR: CALL_AND_RETRY_LAST Allocation failed
```

**Cause**: Process needs more memory

**Solution**:
```powershell
# Increase heap size
node --max-old-space-size=4096 script.js

# Or for npm install
npm install --max_old_space_size=4096
```

---

## File Permission Errors

### ERROR: Permission denied

**Error Message**:
```
Error: EACCES: permission denied, open 'file.txt'
```

**Cause**: File permission issue

**Solution**:
```powershell
# Check file permissions
get-acl file.txt

# Run as administrator
# Or recreate file with proper permissions
```

---

## Configuration Errors

### ERROR: .env file not loaded

**Error Message**: App crashes or environment variables undefined

**Cause**: .env file not loaded in code

**Solution**:
```javascript
// Add to top of file
require('dotenv').config();
// or
import dotenv from 'dotenv';
dotenv.config();
```

---

## General Debugging

### Get More Details

```powershell
# Enable verbose output
npm install --verbose

# Or
pip install -v package-name

# Or
docker-compose logs -f
```

### Check System

```powershell
# System info
systeminfo

# PowerShell version
$PSVersionTable.PSVersion

# Check PATH
$env:PATH -split ';'
```

### Search for Solution

1. Copy exact error message
2. Search on Google
3. Search on Stack Overflow
4. Check official documentation
5. Open GitHub issue

---

## Still Stuck?

1. Run diagnostic commands above
2. Check [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)
3. Check [FAQ.md](./FAQ.md)
4. Open [GitHub Issue](https://github.com/devanjaniraj/developer-environment-setup/issues)
5. Start [GitHub Discussion](https://github.com/devanjaniraj/developer-environment-setup/discussions)

