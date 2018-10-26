# Aliases to make Vagrant life better

# Start Remote Desktop Session in the background
function vrdp() {
  Start-Process -NoNewWindow vagrant.exe rdp @Args
}

# Start Putty Session
function vputty() {
  Start-Process -NoNewWindow vagrant.exe putty @Args
}

# Bring Up Vagrant machine with log
function vup() {
  vagrant.exe up @Args 2>&1 | Tee vagrant.log
}

# Reload and re-provision with Ansible
function vreansible() {
  vagrant.exe reload --provision --provision-with=ansible_local @Args 2>&1 | Tee vagrant.log
}

# Reload / Full Re-provision
function vprov() {
  vagrant.exe reload --provision @Args 2>&1 | Tee vagrant.log
}
