# VMSwitch Utils to make moving between networks easier when using Vagrant and Hyper-V

function create-vmswitch() {

# Network Bridge to Use (Defaults to "ExternalSwitch")
  if (-not (Test-Path env:VAGRANT_NETWORK_BRIDGE)) { $env:VAGRANT_NETWORK_BRIDGE = 'ExternalSwitch' }
  
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
