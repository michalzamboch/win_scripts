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

# -----------------------------------------------

def line():
    print("----------------------------------------")
    pass

def print_all():
    for item in ls:
        print(item)
    pass

def confirm(x):
    return (x[0] == 'Y' or x[0] == 'y' or x == "")
    
# -----------------------------------------------

def print_all_install_cmds():
    for item in software_to_install:
        print(get_install_command(item))
    pass

def get_install_command(program):
    return "winget install \"%s\"" % program

def install_program(program):
    os.system(get_install_command(program))
    pass

def install_all(ls = software_to_install):
    print("Programms to install:")
    line()
    print_all(software_to_install)
    line()
    print("Do you want to install the following software? [y/n]")
    x = input()
    
    if confirm():
        for item in ls:
            install_program(item)
    else:
        print("Nothing will be installed")
    pass

def clear_screen():
    os.system("cls")

def install_scoop():
    pass

def install_choco():
    pass

def install_win_update():
    pass

def update_system():
    pass

# -----------------------------------------------

clear_screen()
install_all()
install_choco()
install_scoop()

install_win_update()
update_system()