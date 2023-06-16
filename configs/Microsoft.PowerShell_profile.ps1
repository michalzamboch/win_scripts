
# Customized terminal
Invoke-Expression (&starship init powershell)
Import-Module Terminal-Icons

# Custom aliases
function sup {scoop update --all; scoop cleanup --cache --all}

Set-Alias sup-dude sup
Set-Alias -Name ll -Value Get-ChildItem
