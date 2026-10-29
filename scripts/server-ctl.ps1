<#
.SYNOPSIS
    Kiddora Dedicated Host Server Control CLI (Windows 11 Pro)
    Usage:
      powershell -ExecutionPolicy Bypass -File scripts/server-ctl.ps1 up
      powershell -ExecutionPolicy Bypass -File scripts/server-ctl.ps1 status
      powershell -ExecutionPolicy Bypass -File scripts/server-ctl.ps1 sync
      powershell -ExecutionPolicy Bypass -File scripts/server-ctl.ps1 backup
      powershell -ExecutionPolicy Bypass -File scripts/server-ctl.ps1 down
#>
param(
    [Parameter(Position = 0)]
    [ValidateSet("up", "down", "status", "sync", "backup", "logs")]
    [string]$Command = "status"
)

$ErrorActionPreference = "Stop"
$RootDir = Split-Path -Parent $PSScriptRoot
Set-Location $RootDir

function Get-ServerIPs {
    $lanIp = (Get-NetIPAddress -AddressFamily IPv4 -ErrorAction SilentlyContinue |
        Where-Object { $_.InterfaceAlias -notlike '*Tailscale*' -and $_.InterfaceAlias -notlike '*vEthernet*' -and $_.InterfaceAlias -notlike '*WSL*' -and $_.InterfaceAlias -notlike '*Docker*' -and $_.IPAddress -notlike '127.*' -and $_.IPAddress -notlike '169.254.*' } |
        Select-Object -First 1).IPAddress

    $tsIp = $null
    $tsExe = "C:\Program Files\Tailscale\tailscale.exe"
    if (Test-Path $tsExe) {
        try {
            $tsOut = & $tsExe ip -4 2>$null
            if ($LASTEXITCODE -eq 0 -and $tsOut) { $tsIp = ($tsOut | Select-Object -First 1).Trim() }
        } catch {}
    }
    return @{ LanIP = $lanIp; TailscaleIP = $tsIp }
}

function Show-Endpoints {
    $ips = Get-ServerIPs
    Write-Host "`n================================================================" -ForegroundColor Cyan
    Write-Host "  KIDDORA DEDICATED SERVER ENDPOINTS (macOS Dev -> Windows Host)" -ForegroundColor Cyan
    Write-Host "================================================================" -ForegroundColor Cyan
    $primaryIp = if ($ips.TailscaleIP) { $ips.TailscaleIP } elseif ($ips.LanIP) { $ips.LanIP } else { "127.0.0.1" }
    Write-Host "  LAN IP (Same Wi-Fi)      : $($ips.LanIP)" -ForegroundColor Green
    Write-Host "  Tailscale IP (Anywhere)  : $(if ($ips.TailscaleIP) { $ips.TailscaleIP } else { 'Chua dang nhap Tailscale' })" -ForegroundColor Yellow
    Write-Host "----------------------------------------------------------------"
    Write-Host "  FastAPI Swagger Docs     : http://${primaryIp}:8000/docs"
    Write-Host "  MinIO S3 Console         : http://${primaryIp}:9001  (minioadmin / minioadmin123)"
    Write-Host "  PostgreSQL 16 (DBeaver)  : ${primaryIp}:5432  (DB: kiddora | User: kiddora | Pass: kiddora_secret)"
    Write-Host "  Redis 7                  : ${primaryIp}:6379"
    Write-Host "  LiveKit WebRTC           : ws://${primaryIp}:7880"
    Write-Host "  macOS Flutter Run Cmd    : flutter run --dart-define=API_BASE_URL=http://${primaryIp}:8000" -ForegroundColor Magenta
    Write-Host "================================================================`n" -ForegroundColor Cyan
}

switch ($Command) {
    "up" {
        Write-Host ">> Starting Kiddora 6-service Docker stack..." -ForegroundColor Cyan
        docker compose up -d --build
        Write-Host ">> Running Alembic PostgreSQL migrations..." -ForegroundColor Cyan
        docker compose exec -T api alembic upgrade head
        Write-Host ">> Initializing MinIO bucket 'kiddora-storage'..." -ForegroundColor Cyan
        docker compose exec -T api python -c "from app.modules.storage.router import StorageService; StorageService.ensure_bucket_exists()"
        docker compose ps
        Show-Endpoints
    }
    "down" {
        Write-Host ">> Stopping Kiddora containers (volumes preserved)..." -ForegroundColor Yellow
        docker compose down
    }
    "status" {
        docker compose ps
        Show-Endpoints
    }
    "sync" {
        Write-Host ">> Pulling latest code from Git & updating backend containers..." -ForegroundColor Cyan
        git pull --ff-only
        docker compose up -d --build api worker
        docker compose exec -T api alembic upgrade head
        Show-Endpoints
    }
    "backup" {
        $backupDir = Join-Path $RootDir "backups\postgres"
        New-Item -ItemType Directory -Force $backupDir | Out-Null
        $stamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $outFile = Join-Path $backupDir "kiddora_${stamp}.sql"
        Write-Host ">> Dumping PostgreSQL database to $outFile ..." -ForegroundColor Cyan
        docker compose exec -T db pg_dump -U kiddora kiddora | Out-File -FilePath $outFile -Encoding utf8
        Get-ChildItem $backupDir -Filter "kiddora_*.sql" | Sort-Object LastWriteTime -Descending | Select-Object -Skip 7 | Remove-Item -Force
        Write-Host ">> Backup complete! Retained latest 7 snapshots." -ForegroundColor Green
    }
    "logs" {
        docker compose logs -f --tail=100 api worker
    }
}
