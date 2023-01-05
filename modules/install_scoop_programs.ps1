$scoop_packakes_path = "..\source\scoop_ids.txt"

# ----------------------------------------------------------------

function scoop_install($program) {
    scoop install $program
}

# ----------------------------------------------------------------

scoop update --all
foreach ($item in Get-Content $scoop_packakes_path) {
    scoop_install $item
}