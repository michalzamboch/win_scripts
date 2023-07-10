Import-Module "..\lib\module.psm1"

$scoop_packakes_path = "..\configs\packages\scoop.txt"

# ----------------------------------------------------------------

function scoop_install($program) {
    scoop install $program
}

function install() {
    foreach ($item in Get-Content $scoop_packakes_path) {
        Write-Host ""
        scoop_install $item
    }
}

function main() {
    if ( -not (Get-Command scoop)){
        Write-Host "`nMissing Scoop package manager.`n" -ForegroundColor Yellow
        return 1
    }

    if (file_empty $scoop_packakes_path){
        Write-Host "`nNo package to install with scoop package manager.`n" -ForegroundColor Cyan
        return 2
    }
    
    print_all $scoop_packakes_path
    scoop update --all
    install
}

# ----------------------------------------------------------------

main
