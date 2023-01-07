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

function main() {
    if (-Not (Get-Commnad Import-Module)) {
        Write-Host "Need to have installed Import-Module package." -Foregroundcolor Red
        exit
    }

    Import-Module Appx

    foreach ($item in $apps_to_delete) {
        Get-AppxPackage $item | Remove-AppxPackage
    }
}
