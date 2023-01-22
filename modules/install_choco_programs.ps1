$choco_packakes_path = "..\source\choco_ids.txt"

# ----------------------------------------------------------------

function not_empty($file) {
    return -not ([String]::IsNullOrWhiteSpace((Get-content $file)))
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

function main() {
    if ((Get-Command choco) -and (not_empty $choco_packakes_path)){
        install
    }
    else {
        return 1
    }
}

# ----------------------------------------------------------------

main