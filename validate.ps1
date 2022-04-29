# validate.ps1

$WinRMservice = Get-Service WinRM
if ($WinRMservice.Status -eq "Stopped") {
    Write-Host "WinRM Service is in stopped state"
    exit 1
}
Get-NetFirewallProfile | % {
  if ($_.Name -eq "Domain" -and $_.Enabled -eq "True" -or $_.Name -eq "Private" -and $_.Enabled -eq "True" -or $_.Name -eq "Public" -and $_.Enabled -eq "True" ) {
      Write-Host "Windows firewall profiles are enabled"
      exit 1
  }
}