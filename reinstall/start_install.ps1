if (-Not (Get-Command "python")) {
    winget install --id Python.Python.3.11
}

python windows-install.py