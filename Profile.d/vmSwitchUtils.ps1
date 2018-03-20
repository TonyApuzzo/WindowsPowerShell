# VMSwitch Utils to make moving between networks easier when using Vagrant and Hyper-V

# Create the External Switch to use with Hyper-V and Vagrant
function create-vmswitch() {
  if (-not (Test-Path $env:VAGRANT_NETWORK_BRIDGE)) { $env:VAGRANT_NETWORK_BRIDGE = 'ExternalSwitch' }
  
  if ($env:VAGRANT_NETWORK_BRIDGE -eq 'Default Switch') {
    echo "You're using the 'Default Switch' and thus no changes can be made."
  } else {
    if (Get-VMSwitch -Name $env:VAGRANT_NETWORK_BRIDGE) {
      echo "$env:VAGRANT_NETWORK_BRIDGE Already Exists"
      Get-VMSwitch -Name  $env:VAGRANT_NETWORK_BRIDGE
    } else {
      if (-not (Test-Path env:WIRED_NETADAPTERNAME)) { $env:WIRED_NETADAPTERNAME = 'Ethernet' }
      New-VMSwitch -SwitchName $env:VAGRANT_NETWORK_BRIDGE -NetAdapterName $env:WIRED_NETADAPTERNAME -AllowManagementOS $true
    }
  }
}

# Change ExternalSwitch to Wi-Fi
function set-wifi-vmswitch() {
  if (-not (Test-Path env:VAGRANT_NETWORK_BRIDGE)) { $env:VAGRANT_NETWORK_BRIDGE = 'ExternalSwitch' }
  
  if ($env:VAGRANT_NETWORK_BRIDGE -eq 'Default Switch') {
    echo "You're using the 'Default Switch' and thus no changes can be made."
  } else {
    if (-not (Test-Path env:WIFI_NETADAPTERNAME)) { $env:WIFI_NETADAPTERNAME = 'Wi-Fi' }
    Set-VMSwitch -VMSwitch $(Get-VMSwitch -Name ExternalSwitch) -NetAdapterName $env:WIFI_NETADAPTERNAME
  }
}

# Change ExternalSwitch to Wired
function set-wired-vmswitch() {
  if (-not (Test-Path env:VAGRANT_NETWORK_BRIDGE)) { $env:VAGRANT_NETWORK_BRIDGE = 'ExternalSwitch' }
  
  if ($env:VAGRANT_NETWORK_BRIDGE -eq 'Default Switch') {
    echo "You're using the 'Default Switch' and thus no changes can be made."
  } else {
    if (-not (Test-Path env:WIRED_NETADAPTERNAME)) { $env:WIRED_NETADAPTERNAME = 'Ethernet' }
    Set-VMSwitch -VMSwitch $(Get-VMSwitch -Name ExternalSwitch) -NetAdapterName $env:WIRED_NETADAPTERNAME
  }
}


Function Fix-ExternalSwitch {

  if (-not (Test-Path $env:VAGRANT_NETWORK_BRIDGE)) { $env:VAGRANT_NETWORK_BRIDGE = 'ExternalSwitch' }

  $switchName = $env:VAGRANT_NETWORK_BRIDGE

  if ($switchName -eq 'Default Switch') {
    echo "You're using the 'Default Switch' and thus no changes can be made."
  } else {
    if (Get-VMSwitch -Name $switchName) {
      echo "$env:VAGRANT_NETWORK_BRIDGE Already Exists"
    } else {
      create-vmswitch
    }

    $vmSwitch = Get-VMSwitch -Name $switchName
    $vmSwitchGuid = switch ($vmSwitch.NetAdapterInterfaceGuid) {
      $null { [GUID]::Empty }
      default { $vmSwitch.NetAdapterInterfaceGuid[0] }
    }

    # Find a working Network Adapter that is not bound to the ExternalSwitch
    $nA = Get-NetAdapter -Physical | Where-Object { $_.Status -eq "Up" -and [GUID]($_.InterfaceGuid) -ne $vmSwitchGuid }
    if ($nA) {
      Write-Host "Reconfiguring $switchName to use $($nA[0].Name)"
      Set-VmSwitch -VMSwitch $vmSwitch -NetAdapterName $nA[0].Name -AllowManagementOS $true
    } else {
      Write-Host "Virtual switch already connected or no usable adapter found."
    }
  }
}

