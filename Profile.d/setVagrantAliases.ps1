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
  #Write-Host $Args
  $ts = Measure-Command -InputObject $Args -Expression { 
    & vagrant.exe up @_ 2>&1 | %{ "$_" } | Tee vagrant.log | Out-Default
  }
  "Elapsed time {0:mm}:{0:ss}" -f $ts
}

# Reload and re-provision with Ansible
function vreansible() {
  $ts = Measure-Command -InputObject $Args -Expression { 
    & vagrant.exe reload --provision --provision-with=ansible_local @_ 2>&1 | %{ "$_" } | Tee vagrant.log | Out-Default
  }
  "Elapsed time {0:mm}:{0:ss}" -f $ts
}

# Reload / Full Re-provision
function vprov() {
  $ts = Measure-Command -InputObject $Args -Expression { 
    & vagrant.exe reload --provision @_ 2>&1 | %{ "$_" } | Tee vagrant.log | Out-Default
  }
  "Elapsed time {0:mm}:{0:ss}" -f $ts
}
