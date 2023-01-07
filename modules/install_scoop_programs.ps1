$scoop_packakes_path = "..\source\scoop_ids.txt"

# ----------------------------------------------------------------

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
    if (Get-Command scoop){
        install
    }
    else {
        return 1
    }
}

# ----------------------------------------------------------------

main