# ./scripts/chocolatey.ps1
# Install Chocolatey
Write-Output "Installing Chocolatey"
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
