
# Nuke idiotic default Powershell Aliases
ri alias:ls
ri alias:wget
ri alias:man
ri alias:curl
ri alias:rmdir

# Start Remote Desktop Session in the background
function vrdp() {
  Start-Process -NoNewWindow vagrant.exe rdp @Args
}
