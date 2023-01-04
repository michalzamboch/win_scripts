Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
#irm get.scoop.sh | iex
iex "& {$(irm get.scoop.sh)} -RunAsAdmin"

scoop bucket add extras
scoop bucket add games