# Remove Microsoft Edge - Created by notmodderx
# Ensure script runs as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Run this script as Administrator!" -ForegroundColor Red
    exit 1
}

Write-Host "🔧 Removing Microsoft Edge..." -ForegroundColor Yellow

# Stop and remove Edge processes
Stop-Process -Name "msedge" -Force -ErrorAction SilentlyContinue
Stop-Process -Name "MicrosoftEdgeUpdate" -Force -ErrorAction SilentlyContinue

# Uninstall Edge (if installed via setup)
$EdgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\*.*"
if (Test-Path $EdgePath) {
    Start-Process -FilePath "$EdgePath\Installer\setup.exe" -ArgumentList "--uninstall --system-level --force-uninstall" -NoNewWindow -Wait
    Write-Host "✅ Edge Uninstalled!"
} else {
    Write-Host "❌ Edge not found via Installer."
}

# Remove Edge Appx Packages
Write-Host "📦 Removing Edge Appx Packages..."
$EdgePackages = Get-AppxPackage -AllUsers | Where-Object { $_.PackageFullName -like "*microsoftedge*" }
foreach ($package in $EdgePackages) {
    Remove-AppxPackage -Package $package.PackageFullName -AllUsers -ErrorAction SilentlyContinue
}

# Delete Edge-related directories
Write-Host "🗑️ Deleting Edge files..."
$EdgeDirs = @(
    "C:\Program Files (x86)\Microsoft\Edge",
    "C:\Program Files\Microsoft\Edge",
    "C:\ProgramData\Microsoft\Edge",
    "$env:LOCALAPPDATA\Microsoft\Edge",
    "C:\Windows\SystemApps\Microsoft.MicrosoftEdge*"
)
foreach ($dir in $EdgeDirs) {
    if (Test-Path $dir) {
        Remove-Item -Path $dir -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# Remove Edge Scheduled Tasks
Write-Host "🗓️ Removing Edge Scheduled Tasks..."
$EdgeTasks = Get-ScheduledTask | Where-Object { $_.TaskName -like "*MicrosoftEdge*" }
foreach ($task in $EdgeTasks) {
    Unregister-ScheduledTask -TaskName $task.TaskName -Confirm:$false
}

# Remove Edge Services
Write-Host "🛑 Removing Edge Services..."
$EdgeServices = @("edgeupdate", "edgeupdatem")
foreach ($service in $EdgeServices) {
    sc.exe delete $service
}

# Block Edge via Registry (Prevents Reinstallation)
Write-Host "🛡️ Blocking Edge from reinstalling..."
reg add "HKLM\SOFTWARE\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "AutoUpdateCheckPeriodMinutes" /t REG_DWORD /d 0 /f

Write-Host "✅ Microsoft Edge has been completely removed and blocked from reinstalling!" -ForegroundColor Green
Write-Host "🔄 Restart your computer to finalize the changes." -ForegroundColor Yellow
