Import-Module "..\lib\module.psm1"

$choco_packakes_path = "..\configs\packages\choco.txt"

# ----------------------------------------------------------------

function choco_install($program) {
    choco install $program
}

function install() {
    foreach ($item in Get-Content $choco_packakes_path) {
        Write-Host ""
        choco_install $item
    }
}

function main() {
    if ( -not (Get-Command choco)) {
        Write-Host "`nMissing Choco package manager.`n" -ForegroundColor Yellow
        return 1
    }

    if (file_empty $choco_packakes_path){
        Write-Host "`nNo package to install with choco package manager.`n" -ForegroundColor Cyan
        return 2
    }
    
    print_all $choco_packakes_path
    install
}

# ----------------------------------------------------------------

main
