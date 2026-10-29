#Requires -Version 5.1
<#
.SYNOPSIS
    Kiddora Dedicated Windows 11 Pro Host Server Setup (Requires Administrator)
    1. Switches Network Profile to Private
    2. Configures Zero-Trust Windows Firewall Rules (LAN + Tailscale 100.64.0.0/10 only)
    3. Installs & Starts Official Microsoft Win32-OpenSSH Server (sshd)
    4. Enables VirtualMachinePlatform + WSL 2 Kernel Platform for Docker Desktop
#>

$ErrorActionPreference = "Stop"
$LogFile = Join-Path $PSScriptRoot ".server-admin-setup.log"

function Write-Step($msg) {
    $line = "[$(Get-Date -Format 'HH:mm:ss')] $msg"
    Write-Host $line -ForegroundColor Cyan
    Add-Content -Path $LogFile -Value $line -Encoding UTF8
}

# Self-elevate if not running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "Requesting Administrator privileges via Windows UAC..." -ForegroundColor Yellow
    $proc = Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Wait -PassThru
    exit $proc.ExitCode
}

Set-Content -Path $LogFile -Value "=== Kiddora Windows Server Admin Setup Started ===" -Encoding UTF8

try {
    # 1. Switch active network profiles from Public -> Private
    Write-Step "1/4 Configuring Network Category -> Private..."
    Get-NetConnectionProfile | Where-Object { $_.NetworkCategory -ne 'DomainAuthenticated' } | ForEach-Object {
        Set-NetConnectionProfile -InterfaceIndex $_.InterfaceIndex -NetworkCategory Private
        Write-Step "  -> Interface '$($_.InterfaceAlias)' set to Private."
    }

    # 2. Configure Zero-Trust Firewall Rules (Scoped strictly to Private LAN + Tailscale CGNAT)
    Write-Step "2/4 Configuring Zero-Trust Windows Defender Firewall Rules..."
    $TrustedSubnets = @("LocalSubnet", "192.168.0.0/16", "10.0.0.0/8", "172.16.0.0/12", "100.64.0.0/10")

    Get-NetFirewallRule -DisplayName "Kiddora - *" -ErrorAction SilentlyContinue | Remove-NetFirewallRule

    New-NetFirewallRule -DisplayName "Kiddora - FastAPI Server (TCP 8000)" `
        -Direction Inbound -Action Allow -Protocol TCP -LocalPort 8000 `
        -RemoteAddress $TrustedSubnets -Profile Private,Domain | Out-Null

    New-NetFirewallRule -DisplayName "Kiddora - MinIO S3 & Console (TCP 9000-9001)" `
        -Direction Inbound -Action Allow -Protocol TCP -LocalPort 9000,9001 `
        -RemoteAddress $TrustedSubnets -Profile Private,Domain | Out-Null

    New-NetFirewallRule -DisplayName "Kiddora - LiveKit WebRTC TCP (7880-7881)" `
        -Direction Inbound -Action Allow -Protocol TCP -LocalPort 7880,7881 `
        -RemoteAddress $TrustedSubnets -Profile Private,Domain | Out-Null

    New-NetFirewallRule -DisplayName "Kiddora - LiveKit WebRTC UDP (7882)" `
        -Direction Inbound -Action Allow -Protocol UDP -LocalPort 7882 `
        -RemoteAddress $TrustedSubnets -Profile Private,Domain | Out-Null

    New-NetFirewallRule -DisplayName "Kiddora - PostgreSQL & Redis Dev (TCP 5432,6379)" `
        -Direction Inbound -Action Allow -Protocol TCP -LocalPort 5432,6379 `
        -RemoteAddress $TrustedSubnets -Profile Private,Domain | Out-Null

    New-NetFirewallRule -DisplayName "Kiddora - OpenSSH Remote Dev (TCP 22)" `
        -Direction Inbound -Action Allow -Protocol TCP -LocalPort 22 `
        -RemoteAddress $TrustedSubnets -Profile Private,Domain | Out-Null

    Write-Step "  -> Added 6 Zero-Trust Inbound Firewall rules (LAN + Tailscale only)."

    # 3. Install & Start Official Microsoft Win32-OpenSSH Server
    Write-Step "3/4 Installing and starting Microsoft OpenSSH Server (sshd)..."
    $sshdSvc = Get-Service -Name sshd -ErrorAction SilentlyContinue
    if (-not $sshdSvc) {
        $sshMsi = Join-Path $env:TEMP "OpenSSH-Win64-v10.0.0.0.msi"
        if (-not (Test-Path $sshMsi)) {
            Write-Step "  -> Downloading official OpenSSH-Win64-v10.0.0.0.msi..."
            & curl.exe -fL "https://github.com/PowerShell/Win32-OpenSSH/releases/download/10.0.0.0p2-Preview/OpenSSH-Win64-v10.0.0.0.msi" -o $sshMsi
        }
        $msiProc = Start-Process msiexec.exe -ArgumentList "/i `"$sshMsi`" ADDLOCAL=Client,Server /qn /norestart" -Wait -PassThru
        Write-Step "  -> Installed Win32-OpenSSH MSI (ExitCode: $($msiProc.ExitCode))."
    }
    Set-Service -Name sshd -StartupType Automatic
    Start-Service -Name sshd
    Write-Step "  -> OpenSSH Server (sshd) is RUNNING and set to Automatic startup."

    # 4. Enable Hypervisor Features & Install WSL 2 MSIX Package
    Write-Step "4/4 Enabling Windows Hypervisor & WSL 2 Platform for Docker Desktop..."
    $dism1 = Start-Process dism.exe -ArgumentList "/online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart" -NoNewWindow -Wait -PassThru
    Write-Step "  -> Feature Microsoft-Windows-Subsystem-Linux ExitCode: $($dism1.ExitCode)"

    $dism2 = Start-Process dism.exe -ArgumentList "/online /enable-feature /featurename:VirtualMachinePlatform /all /norestart" -NoNewWindow -Wait -PassThru
    Write-Step "  -> Feature VirtualMachinePlatform ExitCode: $($dism2.ExitCode)"

    $wslMsix = Join-Path $env:TEMP "Microsoft.WSL_2.7.14.0.msixbundle"
    if (-not (Test-Path $wslMsix)) {
        Write-Step "  -> Downloading official Microsoft.WSL 2.7.14 MSIX bundle..."
        & curl.exe -fL "https://github.com/microsoft/WSL/releases/download/2.7.14/Microsoft.WSL_2.7.14.0_x64_ARM64.msixbundle" -o $wslMsix
    }
    Add-AppxPackage -Path $wslMsix
    Write-Step "  -> Installed Microsoft.WSL 2.7.14 package. Reboot Windows once to activate VirtualMachinePlatform."

    Write-Step "=== ALL ADMIN SETUP STEPS COMPLETED SUCCESSFULLY ==="
    exit 0
} catch {
    Write-Step "ERROR: $($_.Exception.Message)"
    exit 1
}
