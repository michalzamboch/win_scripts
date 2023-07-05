# Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot | Out-File "C:\($env.computername-Get-Date -f yyyy-MM-dd)-MSUpdates.log" -Force

if (-Not (Get-Module -ListAvailable -Name "PSWindowsUpdate")) {
    Write-Host "Installing PowerShell Windows Update"
    Install-Module PSWindowsUpdate
}

Add-WUServiceManager -MicrosoftUpdate

Write-Host ""
Write-Host "Installing updates..."
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot
Write-Host "Windows Update is done."
