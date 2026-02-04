# Verify Installation Script
# This script verifies all required tools are installed and working

Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║         Installation Verification Report                      ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

$Results = @()
$Score = 0
$Total = 0

# Test functions
function Test-Tool {
    param([string]$Name, [string]$Command, [string]$Args = "--version")
    
    $Total++
    $Status = "❌ NOT FOUND"
    $Version = ""
    
    try {
        $Output = & $Command $Args.Split() 2>&1
        if ($?) {
            $Status = "✅ WORKING"
            $Version = $Output[0]
            $Score++
        }
    }
    catch { }
    
    $Results += @{
        Tool = $Name
        Status = $Status
        Version = $Version
    }
    
    Write-Host "$Name" -ForegroundColor White -NoNewline
    Write-Host " : $Status" -ForegroundColor $(if ($Status.Contains("✅")) { "Green" } else { "Red" }) -NoNewline
    if ($Version) {
        Write-Host " ($Version)" -ForegroundColor Gray
    } else {
        Write-Host ""
    }
}

# Refresh PATH
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Test all tools
Write-Host "Core Tools:" -ForegroundColor Cyan
Test-Tool "Node.js" "node" "--version"
Test-Tool "npm" "npm" "--version"
Test-Tool "Python" "python" "--version"
Test-Tool "pip" "pip" "--version"
Test-Tool "Git" "git" "--version"
Test-Tool "Docker" "docker" "--version"

# Report
Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                       Summary Report                           ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

$Percentage = [math]::Round(($Score / $Total) * 100)
Write-Host "Health Score: $Percentage% ($Score/$Total)" -ForegroundColor $(if ($Percentage -eq 100) { "Green" } else { "Yellow" })

if ($Percentage -eq 100) {
    Write-Host "`n✅ All tools are installed and working!" -ForegroundColor Green
    Write-Host "You're ready to start developing! 🚀" -ForegroundColor Green
}
elseif ($Percentage -ge 80) {
    Write-Host "`n⚠️  Some tools are missing. See setup guide for details." -ForegroundColor Yellow
}
else {
    Write-Host "`n❌ Multiple tools are missing. Run setup script to install them." -ForegroundColor Red
}

Write-Host ""
