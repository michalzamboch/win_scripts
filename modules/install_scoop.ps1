
function is_admin() {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time

if (is_admin) {
    iex "& {$(irm get.scoop.sh)} -RunAsAdmin"
}
else {
    irm get.scoop.sh | iex
}

scoop bucket add extras
scoop bucket add games