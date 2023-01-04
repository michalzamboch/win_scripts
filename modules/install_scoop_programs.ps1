$scoop_programs_list = "..\source\scoop_ids.txt"

scoop update --all
foreach ($item in Get-Content $scoop_programs_list) {
    scoop install $item
}