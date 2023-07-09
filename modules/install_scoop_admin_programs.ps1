$admin_scoop_packakes_path = "..\configs\packages\scoop_admin.txt"

# ----------------------------------------------------------------

function empty($file) {
    return ([String]::IsNullOrWhiteSpace((Get-content $file)))
}

function print_all([string]$location) {
    foreach ($line in Get-Content $location) {
        Write-host (" - " + $line)
    }
}

function admin_scoop_install($program) {
    scoop install -g $program
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

    if (empty $admin_scoop_packakes_path){
        Write-Host "`nNo admin package to install with scoop package manager.`n" -ForegroundColor Cyan
        return 2
    }

    print_all $admin_scoop_packakes_path
    admin_install
}

# ----------------------------------------------------------------

main
