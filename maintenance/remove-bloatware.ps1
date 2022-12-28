$apps_to_delete =
    "*3dbuilder*",
    "*windowscommunicationsapps*",
    "*officehub*",
    "*skypeapp*",
    "*getstarted*",
    "*zunemusic*",
    "*windowsmaps*",
    "*solitairecollection*",
    "*bingfinance*",
    "*zunevideo*",
    "*bingnews*",
    "*onenote*",
    "*people*",
    "*windowsphone*",
    "*bingsports*",
    "*bingweather*",
    "*xboxapp*"

foreach ($item in $apps_to_delete) {
    Get-AppxPackage $item | Remove-AppxPackage
}