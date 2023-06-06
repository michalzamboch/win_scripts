# Import-Module 'C:\dev\vcpkg\scripts\posh-vcpkg'

# Customized terminal
Invoke-Expression (&starship init powershell)
Import-Module Terminal-Icons

# Custom aliases
Set-Alias -Name ll -Value Get-ChildItem
