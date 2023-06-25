$scoop_packakes_path = "..\resources\scoop_ids.txt"
$admin_scoop_packakes_path = "..\resources\scoop_admin_ids.txt"

# ----------------------------------------------------------------

function not_empty($file) {
    return -not ([String]::IsNullOrWhiteSpace((Get-content $file)))
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
        return 1
    }
    scoop update --all

    if (not_empty $scoop_packakes_path){
        install
    }
    
    if (not_empty $admin_scoop_packakes_path){
        scoop install sudo
        sudo admin_install
    }
}

# ----------------------------------------------------------------

main
