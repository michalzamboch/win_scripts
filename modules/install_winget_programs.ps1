$winget_packakes_path = "..\resources\winget_ids.txt"

# ----------------------------------------------------------------

function not_empty($file) {
    return -not ([String]::IsNullOrWhiteSpace((Get-content $file)))
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
    if ((Get-Command winget) -and (not_empty $winget_packakes_path)){
        install
    }
    else {
        return 1
    }
}

# ----------------------------------------------------------------

main