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
  Measure-Command -Expression { 
    vagrant.exe up @Args 2>&1 | Tee vagrant.log | Out-Default
  }
}

# Reload and re-provision with Ansible
function vreansible() {
  Measure-Command -Expression { 
    vagrant.exe reload --provision --provision-with=ansible_local @Args 2>&1 | Tee vagrant.log | Out-Default
  }
}

# Reload / Full Re-provision
function vprov() {
  Measure-Command -Expression { 
    vagrant.exe --debug reload --provision @Args 2>&1 | Tee vagrant.log | Out-Default
  }
}

# Destroy / Rebuild
function vmulligan() {
  if ($args[0] -eq "-f" -or $args[0] -eq "--force") {
	$force, $Args = $Args
    vagrant destroy $force
  } else {
    vagrant destroy
  }
  if ($?) {
    vup @Args
  }
}
