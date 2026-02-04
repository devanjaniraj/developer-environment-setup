# 🐛 Troubleshooting Guide

Solutions to common problems with your development environment.

## Installation Issues

### Node.js Not Found After Installation

**Problem**: Command not recognized after installing Node.js

**Solutions**:
1. Close all PowerShell windows
2. Open new PowerShell window
3. Try `node -v` again
4. If still failing, restart your computer
5. Check if Node.js is in PATH: `echo $env:PATH`

### Python Not Found

**Problem**: Python command not recognized

**Solutions**:
1. Reinstall Python with "Add Python to PATH" checked
2. Verify: `python --version`
3. May need to restart computer
4. Try `py --version` as alternative

### Git Not Found

**Problem**: Git command not recognized

**Solutions**:
1. Reinstall Git from https://git-scm.com/
2. Ensure it's added to PATH during installation
3. Close and reopen all shells
4. Restart computer

### Docker Won't Start

**Problem**: Docker Desktop won't start or crashes

**Solutions**:
1. Check if Hyper-V is enabled (Windows 10 Pro/Enterprise only)
2. Or enable WSL 2 as Docker backend
3. Restart Docker Desktop
4. Restart your computer
5. Check Docker logs: Settings → Resources → Troubleshoot

---

## Permission Issues

### PowerShell Execution Policy Error

**Problem**: "Cannot be loaded because running scripts is disabled"

**Solution**:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
```

### Run as Administrator

**Problem**: Permission denied for certain operations

**Solution**:
1. Right-click PowerShell
2. Select "Run as administrator"
3. Or use `Start-Process powershell -Verb runas`

---

## Path & Environment Issues

### Command Not Found in New Shell

**Problem**: Just installed something but new shell doesn't see it

**Solution**:
1. Restart PowerShell completely
2. Or restart your computer
3. Check if installation added to PATH

### Multiple Python/Node.js Installations

**Problem**: Wrong version running

**Solution**:
```powershell
where python    # Shows all Python locations
where node      # Shows all Node.js locations

# Use full path if needed
C:\Python311\python.exe --version
```

---

## npm Issues

### npm install fails

**Problem**: npm install command fails

**Solutions**:
```powershell
# Clear npm cache
npm cache clean --force

# Reinstall dependencies
rm -r node_modules package-lock.json
npm install

# Try with verbose output
npm install --verbose

# Use different registry
npm config set registry https://registry.npmjs.org/
```

### Module not found

**Problem**: Module installed but can't be imported

**Solutions**:
```powershell
# Reinstall node_modules
rm -r node_modules
npm install

# Check if module is installed
npm list express

# Verify package.json
type package.json
```

### npm permission errors

**Problem**: EACCES or EPERM errors

**Solutions**:
```powershell
# Run as administrator
# Or use npm ci instead of npm install
npm ci

# Or reinstall npm
npm install -g npm@latest
```

---

## Python Virtual Environment Issues

### venv activation fails

**Problem**: Can't activate virtual environment

**Solutions**:
```powershell
# Check if venv exists
Test-Path venv

# Recreate venv
python -m venv venv

# Activate again
venv\Scripts\activate

# On PowerShell, may need:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
```

### Module not found in venv

**Problem**: Module installed globally but not in venv

**Solution**:
```powershell
# Make sure venv is activated
venv\Scripts\activate

# Reinstall module
pip install module-name

# Verify it's installed
pip list
pip show module-name
```

### pip install fails

**Problem**: pip install command fails

**Solutions**:
```powershell
# Activate venv first
venv\Scripts\activate

# Upgrade pip
python -m pip install --upgrade pip

# Try again
pip install package-name

# Use requirements file
pip install -r requirements.txt

# Check for errors
pip install --verbose package-name
```

---

## Docker Issues

### Docker daemon not running

**Problem**: "Cannot connect to Docker daemon"

**Solution**:
1. Open Docker Desktop
2. Wait for it to fully start (watch taskbar)
3. Try command again
4. If still fails, restart Docker Desktop

### Port already in use

**Problem**: "Port 5432 is already allocated"

**Solutions**:
```powershell
# Find what's using the port
netstat -ano | findstr :5432

# Kill the process (replace PID)
taskkill /PID 1234 /F

# Or change port in docker-compose.yml
# Or stop Docker containers
docker-compose down
```

### Out of disk space

**Problem**: Docker containers won't start due to disk space

**Solutions**:
```powershell
# Clean up Docker resources
docker system prune

# Remove unused volumes
docker volume prune

# Remove unused images
docker image prune

# Full cleanup (aggressive)
docker system prune -a --volumes
```

### Docker-compose command not found

**Problem**: docker-compose not recognized

**Solution**:
```powershell
# Docker Desktop should include docker-compose
# If not, install it:
docker compose --version  # Modern Docker uses docker compose (space not dash)

# Or use legacy:
pip install docker-compose
```

---

## Git Issues

### Authentication failed

**Problem**: "Fatal: Authentication failed"

**Solutions**:

**For HTTPS**:
1. Use personal access token instead of password
2. GitHub → Settings → Developer settings → Personal access tokens
3. Use token as password when prompting

**For SSH**:
```powershell
# Generate SSH key
ssh-keygen -t ed25519 -C "your-email@example.com"

# Add to SSH agent
ssh-add $env:USERPROFILE\.ssh\id_ed25519

# Add public key to GitHub
# GitHub → Settings → SSH and GPG keys → New SSH key
```

### Working directory not clean

**Problem**: "Your local changes would be overwritten"

**Solution**:
```powershell
# Stash your changes
git stash

# Then try the operation again
git pull

# Retrieve changes later
git stash pop
```

### Wrong branch merged

**Problem**: Accidentally merged wrong branch

**Solution**:
```powershell
# Undo the merge (keep changes)
git reset --soft HEAD~1

# Or undo without keeping changes
git reset --hard HEAD~1

# Force push if already pushed
git push origin main --force
```

### Detached HEAD state

**Problem**: "You are in 'detached HEAD' state"

**Solution**:
```powershell
# Create a branch from current state
git branch temp-branch

# Switch to main branch
git checkout main

# Merge temp-branch if needed
git merge temp-branch
```

---

## VS Code Issues

### VS Code won't open

**Problem**: `code` command not recognized

**Solution**:
1. Reinstall VS Code with "Add to PATH" checked
2. Or restart PowerShell
3. Try full path: `'C:\Users\YourName\AppData\Local\Programs\Microsoft VS Code\Code.exe'`

### Extensions won't install

**Problem**: Extension installation fails

**Solution**:
```powershell
# Clear VS Code cache
rm $env:APPDATA\Code\User\globalStorage -Recurse

# Reinstall VS Code

# Or install from command line
code --install-extension ms-python.python
```

### Terminal integration broken

**Problem**: VS Code terminal doesn't work

**Solution**:
1. Go to VS Code settings
2. Search for "terminal.integrated.shell"
3. Set to: `C:\Windows\System32\cmd.exe` or `C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe`

---

## Common Compilation Errors

### "'g++' is not recognized"

**Problem**: C++ compiler not found

**Solution**:
1. Install MinGW or Visual Studio Build Tools
2. Add to PATH
3. Restart shell

### Missing compiler

**Problem**: "gcc/cc/clang not found"

**Solution**:
1. Install appropriate compiler
2. For Node.js native modules: Install Visual Studio Build Tools
3. For Python C extensions: Install Microsoft C++ Build Tools

---

## Slow Performance

### Slow npm install

**Problem**: npm install takes very long

**Solution**:
```powershell
# Install with no optional dependencies
npm install --no-optional

# Use npm ci instead of npm install
npm ci

# Check network: ping registry.npmjs.org

# Change registry
npm config set registry https://registry.npmmirror.com
```

### Slow Docker

**Problem**: Docker containers are slow

**Solution**:
1. Allocate more resources to Docker
2. Settings → Resources → Memory/CPU
3. Use WSL 2 instead of Hyper-V if possible
4. Use volume mounts wisely (can be slow)

### Slow Python

**Problem**: Python commands slow

**Solution**:
```powershell
# Check what's slow
python -X importtime -c "import module" 2>&1 | tail -20

# Use PyPy for faster execution
# Or optimize imports in startup
```

---

## Diagnostic Commands

### Check System Info

```powershell
# System information
systeminfo

# Check PowerShell version
$PSVersionTable.PSVersion

# Check Windows version
Get-WindowsEdition

# Check Hyper-V enabled
Get-WindowsOptionalFeature -FeatureName Microsoft-Hyper-V
```

### Check Paths

```powershell
# Show all paths
$env:PATH -split ';'

# Check if command exists
Get-Command node

# Where is command
where.exe node
```

### Check Network

```powershell
# Test connectivity
Test-NetConnection www.google.com

# Test specific port
Test-NetConnection localhost -Port 5432

# DNS resolution
nslookup registry.npmjs.org
```

---

## Getting Help

### When Troubleshooting:

1. **Read error message carefully** - Often tells you exactly what's wrong
2. **Search the error** - Usually someone has solved it before
3. **Check documentation** - Official docs have solutions
4. **Ask for help** - GitHub Issues or Discussions
5. **Create minimal example** - Helps others reproduce issue

### Resources

- [Node.js Issues](https://github.com/nodejs/node/issues)
- [npm Issues](https://github.com/npm/cli/issues)
- [Python Issues](https://github.com/python/cpython/issues)
- [Docker Issues](https://github.com/moby/moby/issues)
- [VS Code Issues](https://github.com/microsoft/vscode/issues)

---

## Still Stuck?

1. Check [FAQ.md](./FAQ.md) for common questions
2. Check [ERROR_REFERENCE.md](./ERROR_REFERENCE.md) for error codes
3. Open a [GitHub Issue](https://github.com/devanjaniraj/developer-environment-setup/issues)
4. Start a [GitHub Discussion](https://github.com/devanjaniraj/developer-environment-setup/discussions)

