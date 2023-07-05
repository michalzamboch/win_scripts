
$buckets = 
    "extras",
    "games",
    "java",
    "nerd-fonts"

function is_admin() {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

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

