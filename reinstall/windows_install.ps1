
$argument = $args[0]
$manual = $argument -ne "-y"

# ------------------------------------------------------------------------

function print_line() {
    Write-Host "-----------------------------------------------------"
}

function print_all([string]$location) {
    foreach ($line in Get-Content $location) {
        Write-host (" - " + $line)
    }
}

function request_script([string]$scriptLocation, [string]$scriptName) {

    $choice = ""
    
    if ($manual) {
        $HOST.UI.RawUI.Flushinputbuffer()
        Write-Host ("Do you want to install "+ $scriptName +" [y/n]? ") -ForegroundColor Blue -NoNewline
        $input = Read-Host 
        $choice = $input.SubString(0,1)
    }

    if ($choice -eq "y" -or $choice -eq "Y") {
        . $scriptLocation
    }
    elseif ($choice -eq "q") {
        exit 0
    }
    else {
        echo ($scriptName + " will not be installed...")
    }

    Write-Host ""
}

# ------------------------------------------------------------------------

function update_script() { 
    request_script "..\maintenance\update.ps1" "Windows Update"
}

function install_winget_programs() {
    print_all "..\source\winget_ids.txt"
    request_script "..\modules\install_winget_programs.ps1" "Winget packages"
}

function install_choco() {
    request_script "..\modules\install_choco.ps1" "Chocolatey"
}

function install_scoop() {
    request_script "..\modules\install_scoop.ps1" "Scoop"
}

function install_scoop_programs() {
    print_all "..\source\scoop_ids.txt"
    request_script "..\modules\install_scoop_programs.ps1" "Scoop packages"
}

function install_wsl() {
    request_script "..\modules\install_wsl.ps1" "WSL"
}

# ------------------------------------------------------------------------

function is_admin() {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function check_prerequisites() {
    if (-Not (Get-Command "winget")) {
        Write-Host ""
        Write-Host "You have to install winget first, to run this script." -ForegroundColor Red 
        Write-Host ""
        exit
    }

    if (-Not (is_admin)) {
        Write-Host ""
        Write-Host "You have to run this script as an Administrator." -ForegroundColor Red
        Write-Host ""
        exit
    }
}

function welcome_message() {
    cls

    foreach ($line in Get-Content ".\README.txt") {
        Write-host $line -ForegroundColor Green
    }

    Write-host "Press enter to continue..."
    Read-Host
}

function main() {
    check_prerequisites
    welcome_message

    update_script
    install_winget_programs

    install_choco
    install_scoop
    install_scoop_programs
    install_wsl
}

# ------------------------------------------------------------------------

main