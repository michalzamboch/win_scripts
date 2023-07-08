
function file_empty([string]$file) {
    return [String]::IsNullOrWhiteSpace((Get-content $file))
}

function print_line() {
    Write-Host "-----------------------------------------------------"
}

function write_log ([string] $message) {
    $LogFilePath = ".\log.txt"

    "$([datetime]::Now) : $message" | Out-File -FilePath $LogFilePath -append;
    Write-host $([datetime]::Now) $message -ForegroundColor Red
}

function admin_scripts() {
    ..\maintenance\update.ps1
    ..\modules\install_choco.ps1
    ..\modules\install_choco_programs.ps1
    ..\modules\install_wsl.ps1
}

function user_scripts() {
    ..\modules\install_winget_programs.ps1
    ..\modules\install_scoop.ps1
    ..\modules\install_scoop_programs.ps1
    ..\maintenance\remove_bloatware.ps1
    ..\modules\custom_software.ps1
    ..\modules\set_profile.ps1
    ..\maintenance\common_setup.ps1
}

user_scripts

scoop install sudo
sudo admin_scripts
