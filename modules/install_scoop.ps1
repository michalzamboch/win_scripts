Import-Module "..\lib\module.psm1"

$buckets = 
    "extras",
    "games",
    "java",
    "nerd-fonts"

# ---------------------------------------------------------

if ((Get-ExecutionPolicy) -eq "Restricted") {
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
}

if (is_admin) {
    iex "& {$(irm get.scoop.sh)} -RunAsAdmin"
}
else {
    irm get.scoop.sh | iex
}

foreach ($item in $buckets) {
    scoop bucket add $item
}

