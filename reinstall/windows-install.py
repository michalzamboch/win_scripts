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

def clear_screen():
    os.system("cls")

# -----------------------------------------------

class SimpleSerializer():

    __cmds = []
    name = ""

    def __init__(self, cmds_list, name):
        self.__cmds = cmds_list
        self.name = name
        pass

    def execute(self):
        print("")
        if confirm_request(self.name):
            for item in self.__cmds:
                os.system(item)
        else:
            print("%s will not be installed" % self.name)
        pass
    
    def print(self):
        print(">>> %s" % self.name)
        for item in self.__cmds:
            print(item)
        print("")
        pass

# -----------------------------------------------

class MainSerializer:

    __series = []
    
    def __init__(self):
        pass

    def append(self, item: SimpleSerializer):
        self.__series.append(item)
        pass

    def append_all(self, items: list):
        for item in items:
            self.append(item)
        pass
    
    def execute(self):
        for item in self.__series:
            item.execute()
        pass
    
    def print_all(self):
        for item in self.__series:
            item.print()
        pass

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

def update_system():
    os.system("Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot")

# -----------------------------------------------

ls = [
    "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser",
    "irm get.scoop.sh | iex",
    "scoop bucket add extras"
]
scoop = SimpleSerializer(ls, "Scoop")

ls = [
    "Set-ExecutionPolicy Bypass -Scope Process",
    "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
]
choco = SimpleSerializer(ls, "Chocolatey")

ls = [
    "Install-Module PSWindowsUpdate",
    "Add-WUServiceManager -MicrosoftUpdate"
]
win_update = SimpleSerializer(ls, "PowerShell Windows Update")

ls = [
    "dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart",
    "dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart",
    "wsl --install",
    "winget install --id Canonical.Ubuntu.2204"
]
wsl = SimpleSerializer(ls, "WSL")

ls = [
    "pushd",
    "cd C:",
    "mkdir dev",
    "cd dev",
    "git clone https://github.com/Microsoft/vcpkg.git",
    ".\vcpkg\bootstrap-vcpkg.bat",
    "vcpkg integrate install",
    "popd"
]
vcpkg = SimpleSerializer(ls, "vcpkg")

# -----------------------------------------------

clear_screen()

install_all_id(software_to_install_id)

main_series = MainSerializer()
main_series.append_all([scoop, choco, win_update, wsl, vcpkg])
main_series.print_all()
