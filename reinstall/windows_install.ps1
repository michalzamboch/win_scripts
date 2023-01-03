function read_programs() {
    
    foreach ($line in Get-Content .\src\software_ids.txt) {
        $programs += ,$line
    }

    return $programs
}

function print_all($list) {
    foreach ($item in $list) {
        $line = "  " + $item
        echo $line
    }
}

function winget_install($fileName) {
    foreach ($line in Get-Content $fileName) {
        winget install --silent --accept-package-agreements --accept-source-agreements --id $line
    }
}

function install_list($list) {
    foreach ($line in $list) {
        winget install --silent --accept-package-agreements --accept-source-agreements --id $line
    }
}

function winget_install_all() {

    $HOST.UI.RawUI.Flushinputbuffer()

    $programs = read_programs
    print_all $programs
    
    $input = Read-Host -Prompt ("Do you want to install following software? [y/n]")
    $first_lettet = $input.SubString(0,1)

    if ($first_lettet -eq "y" -or $first_lettet -eq "Y") {
        install_list $programs
    }
    else {
        echo "Programs will not be installed..."
    }
}

# ------------------------------------------------------------------------

function request_script([string]$scriptLocation, [string]$scriptName) {

    $HOST.UI.RawUI.Flushinputbuffer()
    $input = Read-Host -Prompt ("Do you want to install "+ $scriptName +" ? [y/n]")
    
    $first_lettet = $input.SubString(0,1)
    if ($first_lettet -eq "y" -or $first_lettet -eq "Y") {
        . $scriptLocation
    }
    else {
        echo ($scriptName + " will not be installed...")
    }
}

# ------------------------------------------------------------------------

function install_script_prerequisites() {
    winget install --silent --accept-package-agreements --accept-source-agreements --id Python.Python.3.11
}

function update_script() {
    request_script "..\maintenance\update.ps1" "Windows Update"
}

function install_all_programs() {
    python windows_install.py
}

function install_choco() {
    request_script "..\modules\install_choco.ps1" "Chocolatey"
}

function install_scoop() {
    request_script "..\modules\install_scoop.ps1" "Scoop"
}

function install_scoop_programs() {
    request_script "..\modules\install_scoop_programs.ps1" "Scoop packages"
}

function install_wsl() {
    request_script "..\modules\install_wsl.ps1" "WSL"
}

function test_script() {
    request_script "..\test.ps1" "TEST"
}

function main() {
    update_script
    winget_install_all

    install_chocolate
    install_scoop
    install_scoop_programs
    install_wsl
}

# ------------------------------------------------------------------------

winget_install_all