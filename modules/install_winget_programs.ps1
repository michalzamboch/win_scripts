function read_programs() {
    foreach ($line in Get-Content ..\reinstall\src\software_ids.txt) {
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

winget_install_all
