# Professional Developer Environment Setup Script
# This script automates the installation of all development tools

param(
    [switch]$SkipDocker = $false,
    [switch]$SkipExtensions = $false,
    [switch]$Quiet = $false
)

# Colors for output
$Green = 'Green'
$Red = 'Red'
$Yellow = 'Yellow'
$Cyan = 'Cyan'

function Write-Banner {
    param([string]$Message)
    if (-not $Quiet) {
        Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor $Cyan
        Write-Host "║ $($Message.PadRight(64)) ║" -ForegroundColor $Cyan
        Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor $Cyan
    }
}

function Write-Status {
    param([string]$Message, [string]$Status = "INFO")
    if (-not $Quiet) {
        $Color = if ($Status -eq "ERROR") { $Red } elseif ($Status -eq "SUCCESS") { $Green } else { $Cyan }
        Write-Host "[$Status] $Message" -ForegroundColor $Color
    }
}

function Check-Admin {
    $Admin = [Security.Principal.WindowsIdentity]::GetCurrent()
    $AdminRole = [Security.Principal.WindowsBuiltInRole]::Administrator
    $IsAdmin = (New-Object Security.Principal.WindowsPrincipal $Admin).IsInRole($AdminRole)
    return $IsAdmin
}

function Check-Command {
    param([string]$Command)
    $null = Get-Command $Command -ErrorAction SilentlyContinue
    return $?
}

function Download-File {
    param([string]$URL, [string]$OutputPath)
    try {
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri $URL -OutFile $OutputPath
        Write-Status "Downloaded: $OutputPath" "SUCCESS"
        return $true
    }
    catch {
        Write-Status "Failed to download: $URL" "ERROR"
        return $false
    }
}

function Install-NodeJS {
    Write-Banner "Installing Node.js"
    
    if (Check-Command "node") {
        Write-Status "Node.js already installed: $(node -v)" "SUCCESS"
        return
    }
    
    Write-Status "Downloading Node.js v20.11.0..." "INFO"
    $NodeURL = "https://nodejs.org/download/release/v20.11.0/node-v20.11.0-x64.msi"
    $NodePath = "$env:TEMP\node-setup.msi"
    
    if (Download-File $NodeURL $NodePath) {
        Write-Status "Installing Node.js..." "INFO"
        Start-Process -FilePath msiexec.exe -ArgumentList "/i $NodePath /quiet /norestart" -Wait
        Write-Status "Node.js installed successfully" "SUCCESS"
    }
}

function Install-Python {
    Write-Banner "Installing Python"
    
    if (Check-Command "python") {
        Write-Status "Python already installed: $(python --version)" "SUCCESS"
        return
    }
    
    Write-Status "Downloading Python 3.14..." "INFO"
    $PythonURL = "https://www.python.org/ftp/python/3.14.3/python-3.14.3-amd64.exe"
    $PythonPath = "$env:TEMP\python-setup.exe"
    
    if (Download-File $PythonURL $PythonPath) {
        Write-Status "Installing Python..." "INFO"
        Start-Process -FilePath $PythonPath -ArgumentList "/quiet PrependPath=1" -Wait
        Write-Status "Python installed successfully" "SUCCESS"
    }
}

function Install-Git {
    Write-Banner "Installing Git"
    
    if (Check-Command "git") {
        Write-Status "Git already installed: $(git --version)" "SUCCESS"
        return
    }
    
    Write-Status "Downloading Git..." "INFO"
    $GitURL = "https://github.com/git-for-windows/git/releases/download/v2.53.0.windows.1/Git-2.53.0-64-bit.exe"
    $GitPath = "$env:TEMP\git-setup.exe"
    
    if (Download-File $GitURL $GitPath) {
        Write-Status "Installing Git..." "INFO"
        Start-Process -FilePath $GitPath -ArgumentList "/SILENT /NORESTART" -Wait
        Write-Status "Git installed successfully" "SUCCESS"
    }
}

function Install-Docker {
    if ($SkipDocker) {
        Write-Status "Skipping Docker installation" "INFO"
        return
    }
    
    Write-Banner "Installing Docker Desktop"
    
    if (Check-Command "docker") {
        Write-Status "Docker already installed: $(docker --version)" "SUCCESS"
        return
    }
    
    Write-Status "Docker Desktop requires manual installation from https://www.docker.com/products/docker-desktop" "INFO"
}

function Install-VSCode {
    Write-Banner "Installing VS Code"
    
    if (Check-Command "code") {
        Write-Status "VS Code already installed" "SUCCESS"
        return
    }
    
    Write-Status "Downloading VS Code..." "INFO"
    $VSCodeURL = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"
    $VSCodePath = "$env:TEMP\vscode-setup.exe"
    
    if (Download-File $VSCodeURL $VSCodePath) {
        Write-Status "Installing VS Code..." "INFO"
        Start-Process -FilePath $VSCodePath -ArgumentList "/SILENT /NORESTART" -Wait
        Write-Status "VS Code installed successfully" "SUCCESS"
    }
}

function Install-VSCodeExtensions {
    if ($SkipExtensions) {
        Write-Status "Skipping VS Code extensions" "INFO"
        return
    }
    
    Write-Banner "Installing VS Code Extensions"
    
    $Extensions = @(
        "ms-python.python",
        "ms-vscode.cpptools",
        "ms-vscode-remote.remote-containers",
        "ms-vscode-remote.remote-ssh",
        "ms-vscode.powershell",
        "dbaeumer.vscode-eslint",
        "esbenp.prettier-vscode",
        "GitHub.copilot",
        "ms-azuretools.vscode-docker",
        "GitLab.gitlab-workflow"
    )
    
    foreach ($Extension in $Extensions) {
        Write-Status "Installing $Extension..." "INFO"
        code --install-extension $Extension --force 2>&1 | Out-Null
    }
    
    Write-Status "VS Code extensions installed" "SUCCESS"
}

function Configure-ExecutionPolicy {
    Write-Banner "Configuring PowerShell Execution Policy"
    
    try {
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
        Write-Status "Execution policy updated" "SUCCESS"
    }
    catch {
        Write-Status "Could not update execution policy (may require admin)" "ERROR"
    }
}

function Configure-Git {
    Write-Banner "Configuring Git"
    
    Write-Status "Setting Git configuration..." "INFO"
    
    git config --global user.name "Developer" 2>&1 | Out-Null
    git config --global user.email "developer@example.com" 2>&1 | Out-Null
    git config --global core.editor "code --wait" 2>&1 | Out-Null
    git config --global pull.rebase true 2>&1 | Out-Null
    git config --global init.defaultBranch main 2>&1 | Out-Null
    
    Write-Status "Git configured" "SUCCESS"
    Write-Status "⚠️  UPDATE YOUR EMAIL: git config --global user.email 'your-real-email@example.com'" "INFO"
}

function Verify-Installation {
    Write-Banner "Verifying Installation"
    
    $Tools = @(
        @{Name = "Node.js"; Command = "node"; Args = "--version"},
        @{Name = "npm"; Command = "npm"; Args = "--version"},
        @{Name = "Python"; Command = "python"; Args = "--version"},
        @{Name = "Git"; Command = "git"; Args = "--version"}
    )
    
    foreach ($Tool in $Tools) {
        if (Check-Command $Tool.Command) {
            $Version = & $Tool.Command $Tool.Args 2>&1
            Write-Status "$($Tool.Name): $Version" "SUCCESS"
        }
        else {
            Write-Status "$($Tool.Name): NOT FOUND" "ERROR"
        }
    }
}

# Main execution
function Main {
    Write-Banner "Professional Developer Environment Setup"
    
    # Check admin rights
    if (-not (Check-Admin)) {
        Write-Status "This script should be run as Administrator for best results" "ERROR"
    }
    
    # Install components
    Configure-ExecutionPolicy
    Install-NodeJS
    Install-Python
    Install-Git
    Install-Docker
    Install-VSCode
    Install-VSCodeExtensions
    Configure-Git
    
    # Verify
    Verify-Installation
    
    Write-Banner "Setup Complete!"
    Write-Status "Please restart PowerShell for all changes to take effect" "INFO"
}

# Run main function
Main
