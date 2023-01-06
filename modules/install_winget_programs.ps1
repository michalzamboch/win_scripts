$winget_packakes_path = "..\source\winget_ids.txt"

# ----------------------------------------------------------------

function winget_install($program) {
    winget install --silent --accept-package-agreements --accept-source-agreements --id $program
}

# ----------------------------------------------------------------

foreach ($item in Get-Content $winget_packakes_path) {
    Write-Host ""
    winget_install $item
}