Import-Module "..\lib\module.psm1"

$argument = $args[0]
$manual = $argument -ne "-y"

# ------------------------------------------------------------------------

function ask_input([string]$scriptMessage) {
    $HOST.UI.RawUI.Flushinputbuffer()
    Write-Host ($scriptMessage +" [y/a/n/q]? ") -ForegroundColor Cyan -NoNewline
    
    $input = Read-Host 
    return $input.Trim().SubString(0,1).ToLower()
}

function manual_script([string]$scriptLocation, [string]$scriptMessage) {
    $choice = ask_input $scriptMessage

    if ($choice -eq "y") {
        . $scriptLocation
    }
    elseif ($choice -eq "a") {
        $manual = $false
        . $scriptLocation
    }
    elseif ($choice -eq "q") {
        exit 0
    }
    else {
        Write-Host ("`n" + $scriptMessage + " >>> will not be executed...") -ForegroundColor Magenta
    }
}

function request_script([string]$scriptLocation, [string]$scriptMessage) {
    $HOST.UI.RawUI.Flushinputbuffer()
    
    if ($manual) {
        manual_script $scriptLocation $scriptMessage
    }
    else {
        . $scriptLocation
    }

    Write-Host ""
}

function try_request_script([string]$scriptLocation, [string]$scriptMessage) {
    try {
        request_script $scriptLocation $scriptMessage
    }
    catch {
        $e = $_.Exception
        write_log ("An error occurred during: " + $e.Message)
    }
}

# ------------------------------------------------------------------------

function update_script() { 
    try_request_script "..\maintenance\update.ps1" "Install Windows Update"
}

function install_winget_programs() {
    try_request_script "..\modules\install_winget_programs.ps1" "Install Winget packages"
}

function install_choco() {
    try_request_script "..\modules\install_choco.ps1" "Install Chocolatey"
}

function install_choco_programs() {
    try_request_script "..\modules\install_choco_programs.ps1" "Install Chocolatey packages"
}

function install_scoop() {
    try_request_script "..\modules\install_scoop.ps1" "Install Scoop"
}

function install_scoop_programs() {
    try_request_script "..\modules\install_scoop_programs.ps1" "Install Scoop packages"
}

function install_wsl() {
    try_request_script "..\modules\install_wsl.ps1" "Install WSL"
}

function uninstall_bloatware() {
    try_request_script "..\maintenance\remove_bloatware.ps1" "Uninstall bloatware"
}

function custom_software() {
    try_request_script "..\modules\custom_software.ps1" "Install Custom software"
}

function set_profile() {
    try_request_script "..\modules\set_profile.ps1" "Set profile config"
}

function common_setup() {
    try_request_script "..\maintenance\common_setup.ps1" "Common setup"
}

# ------------------------------------------------------------------------

function check_prerequisites() {
    if (-Not (Get-Command "winget")) {
        Write-Host "`nYou have to install winget first, to run this script.`n" -ForegroundColor Red 
        exit
    }

    if (-Not (is_admin)) {
        Write-Host "`nYou have to run this script as an Administrator.`n" -ForegroundColor Red
        exit
    }
}

function execute() {
    install_winget_programs
    install_scoop
    install_scoop_programs
    install_wsl

    custom_software
    set_profile
    common_setup

    uninstall_bloatware
    update_script
    
    Write-Host "`nIt is recommended to restart your computer now.`n" -ForegroundColor Cyan
}

function main() {
    check_prerequisites
    welcome_message

    $time = [System.Diagnostics.Stopwatch]::StartNew()
    
    execute

    elapsed_time $time
}

# ------------------------------------------------------------------------

main
