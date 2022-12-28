import os
import sys

# Helpful functions -----------------------------------------------

def line():
    print("----------------------------------------")

def print_all(ls):
    for item in ls:
        print(item)

def confirm(x):
    return (x[0] == 'Y' or x[0] == 'y' or x == "")

def confirm_request(what = "following software"):
    print("Do you want to install %s? [y/n]" % what)
    sys.stdout.flush()
    sys.stdin.flush()
    x = input()
    return confirm(x)

def clear_screen():
    os.system("cls")

# Serializing commands -----------------------------------------------

class SimpleSerializer():

    __cmds = []
    name = ""
    __messages = []

    def __init__(self, cmds_list, name):
        self.__cmds = cmds_list
        self.name = name
        pass

    def execute(self):
        print("")
        if self.__messages != []:
            print_all(self.__messages)
        
        if confirm_request(self.name):
            for item in self.__cmds:
                os.system(item)
        else:
            print("%s will not be installed" % self.name)
        pass

    def add_messages(self, messages):
        self.__messages = messages
    
    def print(self):
        print(">>> %s" % self.name)
        for item in self.__cmds:
            print("    " + item)
        print("")
        pass

# Serializing serialized commands -----------------------------------------------

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

# Commands functions -----------------------------------------------

def load_software_ids():
    lines = []
    with open('src/software_ids.txt') as f:
        for x in f:
            tmp = x.strip()
            lines.append(tmp)
    return lines

def get_install_command_id(program_id):
    return "winget install --silent --accept-package-agreements --accept-source-agreements --id \"%s\"" % program_id

def get_all_install_commands(ls):
    result = []
    for cmd in ls:
        result.append(get_install_command_id(cmd))
    return result

def install_program_id(program_id):
    os.system(get_install_command_id(program_id))

def update_system():
    os.system("Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot")

# Loading data -----------------------------------------------

tmp = load_software_ids()
ls = get_all_install_commands(tmp)
all_programs = SimpleSerializer(ls, "All Programs")
all_programs.add_messages(tmp)

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
    "git clone https://github.com/Microsoft/vcpkg.git C:\\dev\\vcpkg",
    "C:\\dev\\vcpkg\\bootstrap-vcpkg.bat -disableMetrics",
    "C:\\dev\\vcpkg\\vcpkg integrate install",
]
vcpkg = SimpleSerializer(ls, "vcpkg")

# Executing script -----------------------------------------------

clear_screen()

main_series = MainSerializer()
main_series.append_all([all_programs, scoop, choco, win_update, wsl, vcpkg])
main_series.execute()
