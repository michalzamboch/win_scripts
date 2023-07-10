Import-Module "..\lib\module.psm1"

welcome_message

$time = [System.Diagnostics.Stopwatch]::StartNew()

.\user_install.ps1
sudo .\admin_install.ps1

elapsed_time $time
