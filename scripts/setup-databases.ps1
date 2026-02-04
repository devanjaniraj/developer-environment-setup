# Professional Developer Environment Setup - Database Setup Script
# This script sets up Docker databases for development

param(
    [switch]$Start = $false,
    [switch]$Stop = $false,
    [switch]$Status = $false,
    [switch]$Restart = $false,
    [switch]$Clean = $false,
    [string]$Service = "all"
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

function Check-Docker {
    $null = Get-Command docker -ErrorAction SilentlyContinue
    if (-not $?) {
        Write-Status "Docker is not installed or not in PATH" "ERROR"
        exit 1
    }

    try {
        docker ps | Out-Null
        return $true
    }
    catch {
        Write-Status "Docker daemon is not running" "ERROR"
        exit 1
    }
}

function Start-Databases {
    Write-Status "Starting Docker databases..." "INFO"

    if ($Service -eq "all" -or $Service -eq "postgres") {
        Write-Status "Starting PostgreSQL..." "INFO"
        docker-compose up -d postgres
        Write-Status "PostgreSQL started on port 5432" "SUCCESS"
    }

    if ($Service -eq "all" -or $Service -eq "mongodb") {
        Write-Status "Starting MongoDB..." "INFO"
        docker-compose up -d mongodb
        Write-Status "MongoDB started on port 27017" "SUCCESS"
    }

    if ($Service -eq "all" -or $Service -eq "redis") {
        Write-Status "Starting Redis..." "INFO"
        docker-compose up -d redis
        Write-Status "Redis started on port 6379" "SUCCESS"
    }

    if ($Service -eq "all" -or $Service -eq "mysql") {
        Write-Status "Starting MySQL..." "INFO"
        docker-compose up -d mysql
        Write-Status "MySQL started on port 3306" "SUCCESS"
    }

    if ($Service -eq "all" -or $Service -eq "elasticsearch") {
        Write-Status "Starting Elasticsearch..." "INFO"
        docker-compose up -d elasticsearch
        Write-Status "Elasticsearch started on port 9200" "SUCCESS"
    }

    Write-Status "Waiting for databases to be ready..." "INFO"
    Start-Sleep -Seconds 5
    Show-DatabaseStatus
}

function Stop-Databases {
    Write-Status "Stopping Docker databases..." "INFO"

    if ($Service -eq "all") {
        docker-compose stop
        Write-Status "All databases stopped" "SUCCESS"
    }
    else {
        docker-compose stop $Service
        Write-Status "$Service stopped" "SUCCESS"
    }
}

function Show-DatabaseStatus {
    Write-Status "Database Status:" "INFO"
    Write-Host ""

    $containers = @(
        @{ Name = "postgres"; Port = "5432"; User = "postgres" }
        @{ Name = "mongodb"; Port = "27017"; User = "admin" }
        @{ Name = "redis"; Port = "6379"; User = "N/A" }
        @{ Name = "mysql"; Port = "3306"; User = "root" }
        @{ Name = "elasticsearch"; Port = "9200"; User = "elastic" }
    )

    foreach ($container in $containers) {
        $status = docker ps --filter "name=$($container.Name)" --format "table {{.Status}}"
        if ($status) {
            Write-Host "✓ $($container.Name.PadRight(15)) | Port: $($container.Port.PadRight(5)) | Status: Running" -ForegroundColor Green
        }
        else {
            Write-Host "✗ $($container.Name.PadRight(15)) | Port: $($container.Port.PadRight(5)) | Status: Stopped" -ForegroundColor Red
        }
    }

    Write-Host ""
    Write-Host "Connection Info:" -ForegroundColor Cyan
    Write-Host "  PostgreSQL: psql -h localhost -U postgres"
    Write-Host "  MongoDB: mongosh mongodb://localhost:27017"
    Write-Host "  Redis: redis-cli -h localhost"
    Write-Host "  MySQL: mysql -h localhost -u root -p"
    Write-Host "  Elasticsearch: curl http://localhost:9200"
}

function Restart-Databases {
    Write-Status "Restarting Docker databases..." "INFO"
    Stop-Databases
    Start-Sleep -Seconds 2
    Start-Databases
}

function Clean-Databases {
    Write-Status "WARNING: This will delete all data in databases!" "ERROR"
    $confirm = Read-Host "Continue? (yes/no)"

    if ($confirm -ne "yes") {
        Write-Status "Cleanup cancelled" "INFO"
        return
    }

    Write-Status "Stopping containers..." "INFO"
    docker-compose down

    Write-Status "Removing volumes..." "INFO"
    docker-compose down -v

    Write-Status "All databases cleaned" "SUCCESS"
}

# Main execution
if (-not (Check-Docker)) {
    exit 1
}

if ($Status) {
    Show-DatabaseStatus
}
elseif ($Start) {
    Start-Databases
}
elseif ($Stop) {
    Stop-Databases
}
elseif ($Restart) {
    Restart-Databases
}
elseif ($Clean) {
    Clean-Databases
}
else {
    Write-Host "Database Setup Script" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Usage: .\setup-databases.ps1 [options]" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -Start     Start all databases"
    Write-Host "  -Stop      Stop all databases"
    Write-Host "  -Status    Show database status"
    Write-Host "  -Restart   Restart all databases"
    Write-Host "  -Clean     Remove all data (WARNING: destructive)"
    Write-Host "  -Service   Specify service (postgres/mongodb/redis/mysql/elasticsearch)"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\setup-databases.ps1 -Start"
    Write-Host "  .\setup-databases.ps1 -Stop -Service postgres"
    Write-Host "  .\setup-databases.ps1 -Status"
}
