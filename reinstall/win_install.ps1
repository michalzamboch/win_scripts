
$argument = $args[0]
$manual = $argument -ne "-y"

# ------------------------------------------------------------------------

function file_empty([string]$file) {
    return [String]::IsNullOrWhiteSpace((Get-content $file))
}

function print_line() {
    Write-Host "-----------------------------------------------------"
}

function print_all([string]$location) {
    foreach ($line in Get-Content $location) {
        Write-host (" - " + $line)
    }
}

function ask_input([string]$scriptMessage) {
    $HOST.UI.RawUI.Flushinputbuffer()
    Write-Host ($scriptMessage +" [y/a/n/q]? ") -ForegroundColor Cyan -NoNewline
    $input = Read-Host 
    $input = $input.Trim()
    return $input.SubString(0,1).ToLower()
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
    
    if ($manual) {
        manual_script $scriptLocation $scriptMessage
    }
    else {
        . $scriptLocation
    }

    Write-Host ""
}

# ------------------------------------------------------------------------

function update_script() { 
    request_script "..\maintenance\update.ps1" "Install Windows Update"
}

function install_winget_programs() {
    $file = "..\source\winget_ids.txt"
      if (file_empty $file) {
        return 1
    }

    if (Get-Command winget) {
        print_all $file
        request_script "..\modules\install_winget_programs.ps1" "Install Winget packages"
    }
    else {
        Write-Host "`nMissing Winget package manager.`n" -ForegroundColor Yellow
    }
}

function install_choco() {
    request_script "..\modules\install_choco.ps1" "Install Chocolatey"
}

function install_choco_programs() {
    $file = "..\source\choco_ids.txt"
    if (file_empty $file) {
        return 1
    }

    if (Get-Command choco){
        print_all $file
        request_script "..\modules\install_choco_programs.ps1" "Install Chocolatey packages"
    }
    else {
        Write-Host "`nMissing Choco package manager.`n" -ForegroundColor Yellow
    }
}

function install_scoop() {
    request_script "..\modules\install_scoop.ps1" "Install Scoop"
}

function install_scoop_programs() {
    $file = "..\source\scoop_ids.txt"
    if (file_empty $file) {
        return 1
    }

    if (Get-Command scoop){
        print_all $file
        request_script "..\modules\install_scoop_programs.ps1" "Install Scoop packages"
    }
    else {
        Write-Host "`nMissing Scoop package manager.`n" -ForegroundColor Yellow
    }
}

function install_wsl() {
    request_script "..\modules\install_wsl.ps1" "Install WSL"
}

function uninstall_bloatware() {
    request_script "..\maintenance\remove_bloatware.ps1" "Uninstall bloatware"
}

# ------------------------------------------------------------------------

function is_admin() {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

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

function welcome_message() {
    cls

    foreach ($line in Get-Content ".\README.txt") {
        Write-host $line -ForegroundColor Green
    }

    Write-host "Press enter to continue..." -NoNewline
    Read-Host
}

function elapsed_time($time) {
    $currentTime = $time.Elapsed
    $timeMessage = $([string]::Format("`nFull reinstall time: {0:d2}:{1:d2}:{2:d2}", $currentTime.hours, $currentTime.minutes, $currentTime.seconds))
    Write-Host $timeMessage -ForegroundColor Cyan
}

function main() {
    check_prerequisites
    welcome_message

    $time = [System.Diagnostics.Stopwatch]::StartNew()
    update_script
    install_winget_programs

    install_choco
    install_choco_programs
    install_scoop
    install_scoop_programs
    install_wsl

    uninstall_bloatware
    elapsed_time $time
}

# ------------------------------------------------------------------------

main