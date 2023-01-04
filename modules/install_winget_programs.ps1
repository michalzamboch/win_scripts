
$winget_list_path = "..\source\winget_ids.txt"
$scoop_list_path = "..\source\scoop_ids.txt"

# ----------------------------------------------------------------

$winget_block = {
    foreach ($line in Get-Content $winget_list_path) {
        winget_install $line
    }
}

$scoop_block = {
    foreach ($line in Get-Content $scoop_list_path) {
        scoop_install $line
    }
}

# ----------------------------------------------------------------

function read_programs($list_path) {
    foreach ($line in Get-Content $list_path) {
        $programs += ,$line
    }

    return $programs
}

function print_all($list) {
    foreach ($item in $list) {
        echo ("  " + $item)
    }
}

function winget_install($program) {
    winget install --silent --accept-package-agreements --accept-source-agreements --id $program
}

function scoop_install($program) {
    scoop install $program
}

function winget_install_file($fileName) {
    foreach ($line in Get-Content $fileName) {
        winget_install $line
    }
}

function winget_install_list($list) {
    foreach ($line in $list) {
        winget_install $line
    }
}

function winget_install_all() {

    $HOST.UI.RawUI.Flushinputbuffer()

    $programs_list_path = "..\source\winget_ids.txt"
    $programs = read_programs $programs_list_path
    print_all $programs
    
    $input = Read-Host -Prompt ("Do you want to install following software? [y/n]")
    $first_lettet = $input.SubString(0,1)

    if ($first_lettet -eq "y" -or $first_lettet -eq "Y") {
        install_list $programs
    }
    else {
        echo "Programs will not be installed..."
    }
    
    Write-Host ""
}

function install_all([ScriptBlock]$script, [string]$programs_list_path) {

    $HOST.UI.RawUI.Flushinputbuffer()

    $programs = read_programs $programs_list_path
    print_all $programs
    
    $input = Read-Host -Prompt ("Do you want to install following software? [y/n]")
    $first_lettet = $input.SubString(0,1)

    if ($first_lettet -eq "y" -or $first_lettet -eq "Y") {
        $script.Invoke()
    }
    else {
        echo "Programs will not be installed..."
    }
    
    Write-Host ""
}

# ----------------------------------------------------------------

winget_install_all
