
# Starship 
if (Get-Command starship) {
  Invoke-Expression (&starship init powershell)
}

Import-Module Terminal-Icons

# Custom aliases
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias -Name empty-trash -Value Clear-RecycleBin
Set-Alias -Name cat -Value Get-Content
Set-Alias -Name lg -Value lazygit

# Find programming folder
function cdp {
  if (Test-Path "~\programming") {
    cd ~\programming
    return
  }
  if (Test-Path "D:\programming") {
    cd D:\programming  
    return
  }
  Write-Host "Could not find programming folder." -ForegroundColor Cyan
}

# Chocolatey
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Scoop completion
if (Get-Command scoop) {
  function sup {scoop update --all; scoop cleanup --cache --all}
  Set-Alias sup-dude sup
  
  Import-Module scoop-completion
}

# Watch Dog
$watchdog_script=
@"
import sys
import time
import logging
from watchdog.observers import Observer
from watchdog.events import LoggingEventHandler

def watch(path):
    logging.basicConfig(level=logging.INFO,
                        format='%(asctime)s - %(message)s',
                        datefmt='%Y-%m-%d %H:%M:%S')
    
    event_handler = LoggingEventHandler()
    observer = Observer()
    observer.schedule(event_handler, path, recursive=True)
    observer.start()
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        print("Stop")
    finally:
        observer.stop()
        observer.join()


watch(sys.argv[1] if len(sys.argv) > 1 else '.')
"@

function watchdog { python3 -c $watchdog_script }
