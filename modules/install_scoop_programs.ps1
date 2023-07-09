$scoop_packakes_path = "..\configs\packages\scoop.txt"

# ----------------------------------------------------------------

function empty($file) {
    return ([String]::IsNullOrWhiteSpace((Get-content $file)))
}

function print_all([string]$location) {
    foreach ($line in Get-Content $location) {
        Write-host (" - " + $line)
    }
}

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

    if (empty $scoop_packakes_path){
        Write-Host "`nNo package to install with scoop package manager.`n" -ForegroundColor Cyan
        return 2
    }
    
    print_all $scoop_packakes_path
    scoop update --all
    install
}

# ----------------------------------------------------------------

main
