# Disable-WindowsOptionalFeature -FeatureName Internet-Explorer-Optional-amd64 -Online

$url = "https://kolbi.cz/SetDefaultBrowser.zip"
$output = "C:\SetDefaultBrowser.zip"
$exe = "C:\SetDefaultBrowser\SetDefaultBrowser.exe"

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)
Expand-Archive -Path $output -DestinationPath "C:\" -Force
Start-Process $exe -ArgumentList 'HKLM "Microsoft Edge" delay=1000' -Wait

Remove-Item -Path $output -Force
Remove-Item -Path "C:\SetDefaultBrowser" -Recurse -Force

New-Item -Path HKLM:\Software\Policies\Microsoft\Edge -Force | Out-Null
New-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Edge -Name RestoreOnStartup -Value 0x00000004 -PropertyType DWORD -Force | Out-Null

New-Item -Path HKLM:\Software\Policies\Microsoft\Edge -Name RestoreOnStartupURLs -Force | Out-Null
Set-Itemproperty -Path HKLM:\Software\Policies\Microsoft\Edge\RestoreOnStartupURLs -Name 1 -Value "https://instruqt.com" | Out-Null
