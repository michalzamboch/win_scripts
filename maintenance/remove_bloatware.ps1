$packakes_path = "..\source\bloatware_ids.txt"

# ----------------------------------------------------------------

function winget_uninstall($program) {
    winget uninstall --silent --accept-source-agreements --force --purge --id $program
}

# ----------------------------------------------------------------

if (Get-Command winget) {
    foreach ($item in Get-Content $packakes_path) {
        Write-Host ""
        winget_uninstall "$item"
    }
}
else {
    Write-Host "Need to have installed winget package." -Foregroundcolor Red
}