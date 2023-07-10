function file_empty([string]$file) {
    return [String]::IsNullOrWhiteSpace((Get-content $file))
}

function print_line() {
    Write-Host "-----------------------------------------------------"
}

function print_all([string]$location) {
    foreach ($line in Get-Content $location) {
        Write-host (" - " + $line)
    }
}

function write_log ([string] $message) {
    $LogFilePath = "..\log.txt"

    "$([datetime]::Now) : $message" | Out-File -FilePath $LogFilePath -append;
    Write-host $([datetime]::Now) $message -ForegroundColor Red
}

function welcome_message() {
    cls

    foreach ($line in Get-Content "..\reinstall\README.txt") {
        Write-host $line -ForegroundColor Green
    }

    Write-host "Press enter to continue..." -NoNewline
    Read-Host
}

function is_admin() {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function elapsed_time($time) {
    $currentTime = $time.Elapsed
    $timeMessage = $([string]::Format("`nFull install time: {0:d2}:{1:d2}:{2:d2}", $currentTime.hours, $currentTime.minutes, $currentTime.seconds))
    Write-Host $timeMessage -ForegroundColor Cyan
}

