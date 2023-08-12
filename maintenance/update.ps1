
if (-Not (Get-Module -ListAvailable -Name "PSWindowsUpdate")) {
    Write-Host "Installing PowerShell Windows Update"
    Install-Module PSWindowsUpdate
}

Write-Host ""
Write-Host "Installing updates..."

Add-WUServiceManager -MicrosoftUpdate
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot

Write-Host "Windows Update is done."
