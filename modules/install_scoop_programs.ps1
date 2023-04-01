$scoop_packakes_path = "..\resources\scoop_ids.txt"

# ----------------------------------------------------------------

function not_empty($file) {
    return -not ([String]::IsNullOrWhiteSpace((Get-content $file)))
}

function scoop_install($program) {
    scoop install $program
}

function install() {
    scoop update --all
    foreach ($item in Get-Content $scoop_packakes_path) {
        Write-Host ""
        scoop_install $item
    }
}

function main() {
    if ((Get-Command scoop) -and (not_empty $scoop_packakes_path)){
        install
    }
    else {
        return 1
    }
}

# ----------------------------------------------------------------

main