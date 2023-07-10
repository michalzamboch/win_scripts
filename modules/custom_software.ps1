# Astro Vim
# https://github.com/AstroNvim/AstroNvim

if (Get-Command nvim) {
  if (Test-Path $env:LOCALAPPDATA\nvim) {
    Rename-Item -Path $env:LOCALAPPDATA\nvim -NewName $env:LOCALAPPDATA\nvim.bak
  }

  if (Test-Path $env:LOCALAPPDATA\nvim-data) {
    Rename-Item -Path $env:LOCALAPPDATA\nvim-data -NewName $env:LOCALAPPDATA\nvim-data.bak
  }

  git clone --depth 1 https://github.com/AstroNvim/AstroNvim $env:LOCALAPPDATA\nvim
}
