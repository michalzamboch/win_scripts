$scoop_packakes_path = "..\resources\scoop_ids.txt"
$admin_scoop_packakes_path = "..\resources\scoop_admin_ids.txt"

# ----------------------------------------------------------------

function empty($file) {
    return ([String]::IsNullOrWhiteSpace((Get-content $file)))
}

function print_all([string]$location) {
    foreach ($line in Get-Content $location) {
        Write-host (" - " + $line)
    }
}

function scoop_install($program) {
    scoop install $program
}

function admin_scoop_install($program) {
    scoop install -g $program
}

function install() {
    foreach ($item in Get-Content $scoop_packakes_path) {
        Write-Host ""
        scoop_install $item
    }
}

function admin_install() {
    foreach ($item in Get-Content $admin_scoop_packakes_path) {
        Write-Host ""
        admin_scoop_install $item
    }
}

function main() {
    if ( -not (Get-Command scoop)){
        Write-Host "`nMissing Scoop package manager.`n" -ForegroundColor Yellow
        return 1
    }

    if (empty $scoop_packakes_path){
        Write-Host "`nNo package to install with scoop package manager.`n" -ForegroundColor Cyan
        return 2
    }
    
    print_all $scoop_packakes_path
    scoop update --all
    install
    
    if (empty $scoop_packakes_path){
        Write-Host "`nNo admin package to install with scoop package manager.`n" -ForegroundColor Cyan
        return 3
    }

    print_all $admin_scoop_packakes_path
    scoop install sudo
    sudo admin_install
}

# ----------------------------------------------------------------

main
