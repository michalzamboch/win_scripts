
function winget_install($fileName){
    foreach ($line in Get-Content $fileName) {
        winget install --silent --accept-package-agreements --accept-source-agreements --id $line
    }
}

function request_script($scriptLocation, $name) {

    Write-Output ("Do you want to install "+ $name +" ? [y/n]")
    $input = Read-Host #-Prompt ("Do you want to install "+ $name +" ? [y/n]")
    
    $first_lettet = $input.SubString(0,1)
    if ($first_lettet -eq "y" -or $first_lettet -eq "Y") {
        $scriptLocation
    }
    else {
        Write-Output ($name + " will not be installed...")
    }

    #$HOST.UI.RawUI.Flushinputbuffer()
}

function update_script() {
    request_script("..\maintenance\update.ps1", "Windows Update")
}

# ------------------------------------------------------------------------

request_script("..\maintenance\update.ps1", "Windows Update")