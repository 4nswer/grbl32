# Run this script as Administrator (right-click -> Run as Administrator)
# It installs Chocolatey to the default location and then installs make.

Write-Host "Installing Chocolatey..." -ForegroundColor Cyan
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

Write-Host "Installing make..." -ForegroundColor Cyan
choco install make -y

Write-Host ""
Write-Host "Done! make is now installed." -ForegroundColor Green
Write-Host "You can now build grbl32 by running: make GCC_PATH=`"C:\Users\andrewb\AppData\Local\stm32cube\bundles\gnu-tools-for-stm32\14.3.1+st.2\bin`"" -ForegroundColor Yellow
pause
