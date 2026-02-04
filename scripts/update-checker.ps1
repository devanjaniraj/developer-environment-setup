# Update Checker Script
# Checks for updates to installed development tools

Write-Host "🔄 Checking for Updates..." -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

$updates = @()

# Function to compare versions
function Compare-Version {
    param($Current, $Latest)
    try {
        $currentVer = [version]($Current -replace '[^0-9.]', '')
        $latestVer = [version]($Latest -replace '[^0-9.]', '')
        return $latestVer -gt $currentVer
    } catch {
        return $false
    }
}

# Check Node.js updates
Write-Host "Checking Node.js..." -NoNewline
try {
    $currentNode = node -v 2>&1 | Out-String
    $currentNode = $currentNode.Trim() -replace 'v', ''
    $latestNode = (Invoke-WebRequest -Uri "https://nodejs.org/dist/latest/SHASUMS256.txt" -UseBasicParsing).Content -match 'node-v([\d.]+)' | Out-Null; $Matches[1]
    
    if (Compare-Version $currentNode $latestNode) {
        Write-Host " Update Available" -ForegroundColor Yellow
        $updates += [PSCustomObject]@{
            Tool = "Node.js"
            Current = "v$currentNode"
            Latest = "v$latestNode"
            Status = "Update Available"
        }
    } else {
        Write-Host " Up to date" -ForegroundColor Green
        $updates += [PSCustomObject]@{
            Tool = "Node.js"
            Current = "v$currentNode"
            Latest = "v$latestNode"
            Status = "Up to date"
        }
    }
} catch {
    Write-Host " Error checking" -ForegroundColor Red
}

# Check npm updates
Write-Host "Checking npm..." -NoNewline
try {
    $currentNpm = npm -v 2>&1 | Out-String
    $currentNpm = $currentNpm.Trim()
    $latestNpm = (npm view npm version 2>&1) | Out-String
    $latestNpm = $latestNpm.Trim()
    
    if (Compare-Version $currentNpm $latestNpm) {
        Write-Host " Update Available" -ForegroundColor Yellow
        $updates += [PSCustomObject]@{
            Tool = "npm"
            Current = $currentNpm
            Latest = $latestNpm
            Status = "Update Available"
        }
        Write-Host "  → Run: npm install -g npm@latest" -ForegroundColor Gray
    } else {
        Write-Host " Up to date" -ForegroundColor Green
        $updates += [PSCustomObject]@{
            Tool = "npm"
            Current = $currentNpm
            Latest = $latestNpm
            Status = "Up to date"
        }
    }
} catch {
    Write-Host " Error checking" -ForegroundColor Red
}

# Check Python updates
Write-Host "Checking Python..." -NoNewline
try {
    $currentPython = python --version 2>&1 | Out-String
    $currentPython = ($currentPython -replace 'Python ', '').Trim()
    Write-Host " Current: $currentPython" -ForegroundColor Cyan
    Write-Host "  → Check https://www.python.org/downloads/ for latest version" -ForegroundColor Gray
} catch {
    Write-Host " Not installed" -ForegroundColor Red
}

# Check pip updates
Write-Host "Checking pip..." -NoNewline
try {
    $pipCheck = pip list --outdated --format=json 2>&1 | ConvertFrom-Json
    if ($pipCheck.Count -gt 0) {
        Write-Host " $($pipCheck.Count) packages can be updated" -ForegroundColor Yellow
        Write-Host "  → Run: pip install --upgrade pip" -ForegroundColor Gray
        Write-Host "  → Run: pip list --outdated for details" -ForegroundColor Gray
    } else {
        Write-Host " All packages up to date" -ForegroundColor Green
    }
} catch {
    Write-Host " Error checking" -ForegroundColor Red
}

# Check Git updates
Write-Host "Checking Git..." -NoNewline
try {
    $currentGit = git --version 2>&1 | Out-String
    $currentGit = ($currentGit -replace 'git version ', '').Trim()
    Write-Host " Current: $currentGit" -ForegroundColor Cyan
    Write-Host "  → Check https://git-scm.com/downloads for latest version" -ForegroundColor Gray
} catch {
    Write-Host " Not installed" -ForegroundColor Red
}

# Check Docker updates
Write-Host "Checking Docker..." -NoNewline
try {
    $currentDocker = docker --version 2>&1 | Out-String
    Write-Host " $($currentDocker.Trim())" -ForegroundColor Cyan
    Write-Host "  → Docker Desktop auto-updates. Check settings." -ForegroundColor Gray
} catch {
    Write-Host " Not installed" -ForegroundColor Red
}

# Check global npm packages
Write-Host ""
Write-Host "Checking global npm packages..." -ForegroundColor Cyan
try {
    $outdated = npm outdated -g --json 2>&1 | ConvertFrom-Json
    if ($outdated) {
        $outdated.PSObject.Properties | ForEach-Object {
            Write-Host "  • $($_.Name): $($_.Value.current) → $($_.Value.latest)" -ForegroundColor Yellow
        }
        Write-Host "  → Run: npm update -g" -ForegroundColor Gray
    } else {
        Write-Host "  All global packages up to date ✓" -ForegroundColor Green
    }
} catch {
    Write-Host "  Error checking global packages" -ForegroundColor Red
}

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "Update Check Complete!" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "💡 Tips:" -ForegroundColor Yellow
Write-Host "  • Keep your tools updated for security and features"
Write-Host "  • Run this script weekly to stay current"
Write-Host "  • Back up your work before major updates"
Write-Host ""

# Ask if user wants to update npm
$updateNpm = Read-Host "Would you like to update npm now? (y/n)"
if ($updateNpm -eq 'y') {
    Write-Host "Updating npm..." -ForegroundColor Cyan
    npm install -g npm@latest
    Write-Host "npm updated successfully!" -ForegroundColor Green
}

# Ask if user wants to update global packages
$updateGlobal = Read-Host "Would you like to update global npm packages? (y/n)"
if ($updateGlobal -eq 'y') {
    Write-Host "Updating global packages..." -ForegroundColor Cyan
    npm update -g
    Write-Host "Global packages updated!" -ForegroundColor Green
}

Write-Host ""
Write-Host "Done! 🎉" -ForegroundColor Green
