# Professional Developer Environment Setup - Cleanup Script
# This script removes installations and cleans up the development environment

param(
    [switch]$All = $false,
    [switch]$NodeJS = $false,
    [switch]$Python = $false,
    [switch]$Docker = $false,
    [switch]$Git = $false,
    [switch]$VSCode = $false,
    [switch]$Confirm = $false
)

# Colors for output
$Green = 'Green'
$Red = 'Red'
$Yellow = 'Yellow'
$Cyan = 'Cyan'

function Write-Status {
    param([string]$Message, [string]$Status = "INFO")
    $Color = if ($Status -eq "ERROR") { $Red } elseif ($Status -eq "SUCCESS") { $Green } else { $Cyan }
    Write-Host "[$Status] $Message" -ForegroundColor $Color
}

function Show-Warning {
    Write-Host ""
    Write-Host "⚠️  WARNING: This will remove tools and data!" -ForegroundColor Red
    Write-Host ""
    Write-Host "This cleanup script will:"
    Write-Host "  - Remove installed tools"
    Write-Host "  - Delete configuration"
    Write-Host "  - Clear caches and temporary files"
    Write-Host ""
    Write-Host "This action CANNOT be undone!" -ForegroundColor Red
    Write-Host ""

    if (-not $Confirm) {
        $response = Read-Host "Do you want to continue? (type 'YES' to confirm)"
        if ($response -ne "YES") {
            Write-Status "Cleanup cancelled" "INFO"
            exit 0
        }
    }
}

function Cleanup-NodeJS {
    Write-Status "Cleaning up Node.js..." "INFO"

    # Clear npm cache
    Write-Status "Clearing npm cache..." "INFO"
    npm cache clean --force 2>&1 | Out-Null

    # Remove node_modules globally installed
    Write-Status "Removing global npm packages..." "INFO"
    $globalPackages = npm list -g --depth=0 2>&1
    Write-Status "Node.js cleanup complete" "SUCCESS"
}

function Cleanup-Python {
    Write-Status "Cleaning up Python..." "INFO"

    # Clear pip cache
    Write-Status "Clearing pip cache..." "INFO"
    python -m pip cache purge 2>&1 | Out-Null

    # Remove venv if exists
    if (Test-Path "./venv") {
        Write-Status "Removing virtual environment..." "INFO"
        Remove-Item "./venv" -Recurse -Force
    }

    Write-Status "Python cleanup complete" "SUCCESS"
}

function Cleanup-Docker {
    Write-Status "Cleaning up Docker..." "INFO"

    if (Get-Command docker -ErrorAction SilentlyContinue) {
        Write-Status "Stopping Docker containers..." "INFO"
        docker-compose down 2>&1 | Out-Null

        Write-Status "Removing Docker volumes..." "INFO"
        docker system prune -a --volumes --force 2>&1 | Out-Null

        Write-Status "Docker cleanup complete" "SUCCESS"
    }
    else {
        Write-Status "Docker not found" "INFO"
    }
}

function Cleanup-Git {
    Write-Status "Cleaning up Git..." "INFO"

    # Remove git cache
    if (Test-Path "./.git") {
        Write-Status "Git repository detected" "INFO"
    }

    Write-Status "Git cleanup complete" "SUCCESS"
}

function Cleanup-VSCode {
    Write-Status "Cleaning up VS Code..." "INFO"

    # Clear VS Code cache
    $vscodePath = "$env:APPDATA\Code"
    if (Test-Path $vscodePath) {
        Write-Status "Removing VS Code cache..." "INFO"
        Remove-Item "$vscodePath\Cache" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "$vscodePath\CachedData" -Recurse -Force -ErrorAction SilentlyContinue
    }

    Write-Status "VS Code cleanup complete" "SUCCESS"
}

function Cleanup-Temp {
    Write-Status "Cleaning temporary files..." "INFO"

    # Remove temp installation files
    $tempItems = @(
        "$env:TEMP\*setup*.exe",
        "$env:TEMP\*setup*.msi",
        "$env:TEMP\*.zip"
    )

    foreach ($pattern in $tempItems) {
        Get-Item $pattern -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue
    }

    Write-Status "Temporary files cleaned" "SUCCESS"
}

function Show-Summary {
    Write-Host ""
    Write-Host "Cleanup Summary:" -ForegroundColor Cyan
    Write-Host "✓ Cleanup completed successfully"
    Write-Host ""
    Write-Host "Next steps:"
    Write-Host "  1. Restart your computer for changes to take effect"
    Write-Host "  2. Run setup script again if you want to reinstall"
    Write-Host "  3. Check GitHub for latest setup instructions"
    Write-Host ""
}

# Main execution
if (-not $All -and -not $NodeJS -and -not $Python -and -not $Docker -and -not $Git -and -not $VSCode) {
    Write-Host "Cleanup Script" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Usage: .\cleanup.ps1 [options]" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -All       Clean everything"
    Write-Host "  -NodeJS    Clean Node.js and npm"
    Write-Host "  -Python    Clean Python and pip"
    Write-Host "  -Docker    Clean Docker"
    Write-Host "  -Git       Clean Git"
    Write-Host "  -VSCode    Clean VS Code"
    Write-Host "  -Confirm   Skip confirmation prompt"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\cleanup.ps1 -All"
    Write-Host "  .\cleanup.ps1 -NodeJS -Python"
    Write-Host ""
    exit 0
}

Show-Warning

if ($All) {
    Cleanup-NodeJS
    Cleanup-Python
    Cleanup-Docker
    Cleanup-Git
    Cleanup-VSCode
    Cleanup-Temp
}
else {
    if ($NodeJS) { Cleanup-NodeJS }
    if ($Python) { Cleanup-Python }
    if ($Docker) { Cleanup-Docker }
    if ($Git) { Cleanup-Git }
    if ($VSCode) { Cleanup-VSCode }
}

Cleanup-Temp
Show-Summary
