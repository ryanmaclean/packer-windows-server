# Disable automatic start ServerManager
Get-ScheduledTask -TaskName ServerManager | Disable-ScheduledTask -Verbose

# Disable network discovery prompt
netsh advfirewall firewall set rule group="Network Discovery" new enable=No
