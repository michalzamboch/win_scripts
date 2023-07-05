$choco_packakes_path = "..\configs\packages\choco.txt"

# ----------------------------------------------------------------

function empty($file) {
    return ([String]::IsNullOrWhiteSpace((Get-content $file)))
}

function choco_install($program) {
    choco install $program
}

function install() {
    foreach ($item in Get-Content $choco_packakes_path) {
        Write-Host ""
        choco_install $item
    }
}

function print_all([string]$location) {
    foreach ($line in Get-Content $location) {
        Write-host (" - " + $line)
    }
}

function main() {
    if ( -not (Get-Command choco)) {
        Write-Host "`nMissing Choco package manager.`n" -ForegroundColor Yellow
        return 1
    }

    if (empty $choco_packakes_path){
        Write-Host "`nNo package to install with choco package manager.`n" -ForegroundColor Cyan
        return 2
    }
    
    print_all $choco_packakes_path
    install
}

# ----------------------------------------------------------------

main
