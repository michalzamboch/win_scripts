$winget_packakes_path = "..\resources\winget_ids.txt"

# ----------------------------------------------------------------

function empty($file) {
    return ([String]::IsNullOrWhiteSpace((Get-content $file)))
}

function winget_install($program) {
    winget install --silent --accept-package-agreements --accept-source-agreements --id $program
}

function install() {
    foreach ($item in Get-Content $winget_packakes_path) {
        Write-Host ""
        winget_install $item
    }
}

function main() {
    if ( -not (Get-Command winget)) {
        Write-Host "`nMissing Winget package manager.`n" -ForegroundColor Yellow
        return 1
    }

    if (empty $winget_packakes_path){
        Write-Host "`nNo package to install with winget package manager.`n" -ForegroundColor Cyan
        return 2
    }
    
    print_all $winget_packakes_path
    install
}

# ----------------------------------------------------------------

main
