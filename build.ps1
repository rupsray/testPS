# build.ps1

$WinRMservice = Get-Service WinRM
if ($WinRMservice.Status -eq "Stopped") {
  Winrm quickconfig
  Write-Host "WinRM Service is Running"
}
Get-NetFirewallProfile | % {
	if ($_.Name -eq "Domain" -and $_.Enabled -eq "True" -or $_.Name -eq "Private" -and $_.Enabled -eq "True" -or $_.Name -eq "Public" -and $_.Enabled -eq "True" ) {
	  Set-NetFirewallProfile -Enabled true 		#On EC2 image builder it will be false
	  Write-Host "Windows firewall profiles are disabled"
	}
}