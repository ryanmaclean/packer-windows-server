$password = "Passw0rd!" #TODO - MAKE THIS AN ENV VAR
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$DomainName = "instruqt.local"

net user Administrator $password
net user Administrator /active:yes

Import-Module ADDSDeployment
Install-ADDSForest -CreateDnsDelegation:$false `
    -SafeModeAdministratorPassword:$securePassword `
    -DomainName:$DomainName `
    -InstallDNS:$true `
    -Force:$true `
    -NoDnsOnNetwork `
    -NoRebootOnCompletion
