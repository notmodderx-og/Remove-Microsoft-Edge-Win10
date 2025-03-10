# Remove Microsoft Edge - Created by notmodderx
# Run as Admin Check
$admin = [bool]([System.Security.Principal.WindowsPrincipal]([System.Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $admin) {
    Write-Host "Please run this script as Administrator!" -ForegroundColor Red
    Pause
    Exit
}

Write-Host "Uninstalling Microsoft Edge..." -ForegroundColor Yellow

# Find Edge version
$EdgePath = "C:\Program Files (x86)\Microsoft\Edge\Application"
$EdgeVersion = Get-ChildItem -Path $EdgePath | Where-Object { $_.PSIsContainer } | Select-Object -Last 1 -ExpandProperty Name
$InstallerPath = "$EdgePath\$EdgeVersion\Installer\setup.exe"

# Uninstall Edge
if (Test-Path $InstallerPath) {
    Start-Process -FilePath $InstallerPath -ArgumentList "--uninstall --system-level --verbose-logging --force-uninstall" -NoNewWindow -Wait
    Write-Host "Microsoft Edge has been removed!" -ForegroundColor Green
} else {
    Write-Host "Microsoft Edge is not installed!" -ForegroundColor Cyan
}

Write-Host "Blocking Edge from reinstalling..." -ForegroundColor Yellow

# Block Edge Updates via Registry
$RegistryPath = "HKLM:\SOFTWARE\Microsoft\EdgeUpdate"
if (!(Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}
Set-ItemProperty -Path $RegistryPath -Name "DoNotUpdateToEdgeWithChromium" -Type DWord -Value 1

Write-Host "Edge updates have been blocked!" -ForegroundColor Green

Write-Host "Edge has been removed and blocked successfully!" -ForegroundColor Magenta
Pause
