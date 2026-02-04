# Health Check and System Monitor Script
# Checks the status of all installed development tools

Write-Host "🏥 Developer Environment Health Check" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

$results = @()

# Function to check command availability
function Test-Command {
    param($Command)
    try {
        Get-Command $Command -ErrorAction Stop | Out-Null
        return $true
    } catch {
        return $false
    }
}

# Function to get version
function Get-ToolVersion {
    param($Command, $Arguments = "--version")
    try {
        $output = & $Command $Arguments 2>&1 | Select-Object -First 1
        return $output.ToString().Trim()
    } catch {
        return "Error getting version"
    }
}

# Check Node.js
Write-Host "Checking Node.js..." -NoNewline
if (Test-Command "node") {
    $nodeVersion = Get-ToolVersion "node" "-v"
    Write-Host " ✓" -ForegroundColor Green
    $results += [PSCustomObject]@{
        Tool = "Node.js"
        Status = "Installed"
        Version = $nodeVersion
    }
} else {
    Write-Host " ✗" -ForegroundColor Red
    $results += [PSCustomObject]@{
        Tool = "Node.js"
        Status = "Not Found"
        Version = "N/A"
    }
}

# Check npm
Write-Host "Checking npm..." -NoNewline
if (Test-Command "npm") {
    $npmVersion = Get-ToolVersion "npm" "-v"
    Write-Host " ✓" -ForegroundColor Green
    $results += [PSCustomObject]@{
        Tool = "npm"
        Status = "Installed"
        Version = $npmVersion
    }
} else {
    Write-Host " ✗" -ForegroundColor Red
    $results += [PSCustomObject]@{
        Tool = "npm"
        Status = "Not Found"
        Version = "N/A"
    }
}

# Check Python
Write-Host "Checking Python..." -NoNewline
if (Test-Command "python") {
    $pythonVersion = Get-ToolVersion "python" "--version"
    Write-Host " ✓" -ForegroundColor Green
    $results += [PSCustomObject]@{
        Tool = "Python"
        Status = "Installed"
        Version = $pythonVersion
    }
} else {
    Write-Host " ✗" -ForegroundColor Red
    $results += [PSCustomObject]@{
        Tool = "Python"
        Status = "Not Found"
        Version = "N/A"
    }
}

# Check pip
Write-Host "Checking pip..." -NoNewline
if (Test-Command "pip") {
    $pipVersion = Get-ToolVersion "pip" "--version"
    Write-Host " ✓" -ForegroundColor Green
    $results += [PSCustomObject]@{
        Tool = "pip"
        Status = "Installed"
        Version = $pipVersion
    }
} else {
    Write-Host " ✗" -ForegroundColor Red
    $results += [PSCustomObject]@{
        Tool = "pip"
        Status = "Not Found"
        Version = "N/A"
    }
}

# Check Git
Write-Host "Checking Git..." -NoNewline
if (Test-Command "git") {
    $gitVersion = Get-ToolVersion "git" "--version"
    Write-Host " ✓" -ForegroundColor Green
    $results += [PSCustomObject]@{
        Tool = "Git"
        Status = "Installed"
        Version = $gitVersion
    }
} else {
    Write-Host " ✗" -ForegroundColor Red
    $results += [PSCustomObject]@{
        Tool = "Git"
        Status = "Not Found"
        Version = "N/A"
    }
}

# Check Docker
Write-Host "Checking Docker..." -NoNewline
if (Test-Command "docker") {
    try {
        $dockerVersion = Get-ToolVersion "docker" "--version"
        $dockerStatus = docker info 2>&1 | Out-Null
        if ($LASTEXITCODE -eq 0) {
            Write-Host " ✓" -ForegroundColor Green
            $results += [PSCustomObject]@{
                Tool = "Docker"
                Status = "Running"
                Version = $dockerVersion
            }
        } else {
            Write-Host " ⚠" -ForegroundColor Yellow
            $results += [PSCustomObject]@{
                Tool = "Docker"
                Status = "Installed but not running"
                Version = $dockerVersion
            }
        }
    } catch {
        Write-Host " ⚠" -ForegroundColor Yellow
        $results += [PSCustomObject]@{
            Tool = "Docker"
            Status = "Error"
            Version = "N/A"
        }
    }
} else {
    Write-Host " ✗" -ForegroundColor Red
    $results += [PSCustomObject]@{
        Tool = "Docker"
        Status = "Not Found"
        Version = "N/A"
    }
}

# Check VS Code
Write-Host "Checking VS Code..." -NoNewline
if (Test-Command "code") {
    $codeVersion = Get-ToolVersion "code" "--version"
    Write-Host " ✓" -ForegroundColor Green
    $results += [PSCustomObject]@{
        Tool = "VS Code"
        Status = "Installed"
        Version = $codeVersion
    }
} else {
    Write-Host " ✗" -ForegroundColor Red
    $results += [PSCustomObject]@{
        Tool = "VS Code"
        Status = "Not Found"
        Version = "N/A"
    }
}

# Check TypeScript
Write-Host "Checking TypeScript..." -NoNewline
if (Test-Command "tsc") {
    $tscVersion = Get-ToolVersion "tsc" "--version"
    Write-Host " ✓" -ForegroundColor Green
    $results += [PSCustomObject]@{
        Tool = "TypeScript"
        Status = "Installed"
        Version = $tscVersion
    }
} else {
    Write-Host " ⚠" -ForegroundColor Yellow
    $results += [PSCustomObject]@{
        Tool = "TypeScript"
        Status = "Not Found (Optional)"
        Version = "N/A"
    }
}

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "Health Check Results:" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
$results | Format-Table -AutoSize

# Summary
$installed = ($results | Where-Object { $_.Status -like "*Installed*" -or $_.Status -eq "Running" }).Count
$total = $results.Count
$percentage = [math]::Round(($installed / $total) * 100, 2)

Write-Host ""
Write-Host "Summary: $installed/$total tools installed ($percentage%)" -ForegroundColor Cyan

if ($percentage -eq 100) {
    Write-Host "✅ Your development environment is fully configured!" -ForegroundColor Green
} elseif ($percentage -ge 75) {
    Write-Host "⚠️  Your development environment is mostly configured." -ForegroundColor Yellow
    Write-Host "   Consider installing missing tools." -ForegroundColor Yellow
} else {
    Write-Host "❌ Your development environment needs attention." -ForegroundColor Red
    Write-Host "   Please run the setup script." -ForegroundColor Red
}

Write-Host ""

# System Information
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "System Information:" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "OS: $([System.Environment]::OSVersion.VersionString)"
Write-Host "PowerShell: $($PSVersionTable.PSVersion)"
Write-Host "CPU: $((Get-WmiObject Win32_Processor).Name)"
Write-Host "RAM: $([math]::Round((Get-WmiObject Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)) GB"
Write-Host "Disk Space: $([math]::Round((Get-PSDrive C).Free / 1GB, 2)) GB free"
Write-Host ""
