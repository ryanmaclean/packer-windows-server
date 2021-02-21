$url = "https://github.com/cedrozor/myrtille/releases/download/v2.9.1/Myrtille_2.9.1_x86_x64_Setup.msi"
$output = "C:\myrtille.msi"
$log = "C:\myrtille.log"

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)
Start-Process C:\Windows\System32\msiexec.exe -ArgumentList "/i $output /l*v $log /quiet" -Wait

Remove-Item -Path $output -Force
Remove-Item -Path $log -Force
