
# Starship 
if (Get-Command starship) {
  Invoke-Expression (&starship init powershell)
}

# Import-Module Terminal-Icons

# Custom aliases
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias -Name empty-trash -Value Clear-RecycleBin
Set-Alias -Name cat -Value Get-Content

# Chocolatey
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Scoop completion
if (Get-Command scoop) {
  function sup {scoop update --all; scoop cleanup --cache --all}
  Set-Alias sup-dude sup
  Import-Module scoop-completion
}
