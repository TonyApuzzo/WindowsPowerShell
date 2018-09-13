# Aliases to make Vagrant life better

# Start Remote Desktop Session in the background
function vrdp() {
  Start-Process -NoNewWindow vagrant.exe rdp @Args
}

# Start Putty Session
function vputty() {
  Start-Process -NoNewWindow vagrant.exe putty @Args
}

# Reload and re-provision with Ansible
function vreansible() {
  vagrant.exe reload --provision --provision-with=ansible_local
}
