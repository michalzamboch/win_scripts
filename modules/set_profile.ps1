
$destination = $home + "\Documents\PowerShell"

if ( -not (Test-Path $destination)) {
    mkdir $destination 
}

cp ..\configs\Microsoft.PowerShell_profile.ps1 $destination

