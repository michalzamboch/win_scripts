import os

# -----------------------------------------------

software_to_install = [
    "Peazip",
    "Visual Studio Community 2022",
    "Brave",
    "Discord",
    "Epic Games Launcher",
    "EaseUS Partition Master",
    "NVIDIA GeForce Experience",
    "Enlisted Launcher",
    "balenaEtcher",
    "VLC media player",
    "Total Commander",
    "Sublime Text 4",
    "Steam",
    "Spotify",
    "SourceTree",
    "KeePass Password Safe",
    "Minecraft Launcher",
    "Git",
    "Microsoft Visual Studio Code",
    "Fedora Media Writer",
    "Java 8",
    "HWiNFO"
]

software_to_install_id = [
    "JGraph.Draw",
    "Microsoft.VisualStudio.2022.Community",
    "Brave.Brave",
    "Discord.Discord",
    "EaseUS.PartitionMaster",
    "Fedora.FedoraMediaWriter",
    "Git.Git",
    "REALiX.HWiNFO",
    "JetBrains.IntelliJIDEA.Community",
    "DominikReichl.KeePass",
    "LLVM.LLVM",
    "Microsoft.PowerShell",
    "Microsoft.WindowsTerminal",
    "Safing.Portmaster",
    "Rustlang.Rustup",
    "Atlassian.Sourcetree",
    "Spotify.Spotify",
    "Valve.Steam",
    "Ghisler.TotalCommander",
    "VideoLAN.VLC",
    "Wargaming.GameCenter",
    "WinMerge.WinMerge",
    "Balena.Etcher",
    "Axosoft.GitKraken",
    "MiniTool.PartitionWizard.Free",
    "Oracle.JavaRuntimeEnvironment",
    "Giorgiotani.Peazip",
    "GaijinNetwork.Enlisted",
    "Neovim.Neovim",
    "Microsoft.VisualStudioCode",
    "Oracle.JDK.19",
    "SomePythonThings.WingetUIStore",
    "Oracle.VirtualBox",
    "Nvidia.GeForceExperience",
    "EpicGames.EpicGamesLauncher",
]

# -----------------------------------------------

def line():
    print("----------------------------------------")

def print_all(ls):
    for item in ls:
        print(item)

def confirm(x):
    return (x[0] == 'Y' or x[0] == 'y' or x == "")

def confirm_request(what = "following software"):
    print("Do you want to install %s? [y/n]" % what)
    x = input()
    return confirm(x)
    
# -----------------------------------------------

def print_all_install_cmds(ls):
    for item in ls:
        print(get_install_command(item))

def get_install_command(program):
    return "winget install --silent \"%s\"" % program

def get_install_command_id(program_id):
    return "winget install --silent --id \"%s\"" % program_id

def install_program(program):
    os.system(get_install_command(program))

def install_program_id(program_id):
    os.system(get_install_command_id(program_id))

def install_all_id(ls):
    print("Programms to install:")
    line()
    print_all(ls)
    print_all_install_cmds(ls)
    line()
    
    if confirm_request():
        for item in ls:
            print(item)
    else:
        print("Nothing will be installed")
    pass

def clear_screen():
    os.system("cls")

def install_scoop():
    if confirm_request("scoop"):
        os.system("Set-ExecutionPolicy RemoteSigned -Scope CurrentUser")
        os.system("irm get.scoop.sh | iex")
        os.system("scoop bucket add extras")
    else:
        print("Scoop will not be installed")

def install_choco():
    if confirm_request("Chocolatey"):
        os.system("Set-ExecutionPolicy Bypass -Scope Process")
        os.system("Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))")
    else:
        print("Chocolatey will not be installed")

def install_win_update():
    if confirm_request("Windows Update Powershell"):
        os.system("Install-Module PSWindowsUpdate")
        os.system("Add-WUServiceManager -MicrosoftUpdate")
    else:
        print("Windows Update Powershell will not be installed")

def update_system():
    os.system("Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot")

def install_wsl():
    if confirm_request("WSL"):
        os.system("dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart")
        os.system("dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart")
        os.system("wsl --install")
        os.system("winget install --id Canonical.Ubuntu.2204")
    else:
        print("WSL will not be installed")

# -----------------------------------------------

clear_screen()
install_all_id(software_to_install_id)

install_choco()
install_scoop()
install_win_update()
install_wsl()
