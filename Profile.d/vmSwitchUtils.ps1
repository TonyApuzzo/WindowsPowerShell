# VMSwitch Utils to make moving between networks easier

function create-vmswitch() {
  if (Get-VMSwitch -Name ExternalSwitch) {
    echo "ExternalSwitch Already Exists"
    Get-VMSwitch -Name ExternalSwitch
  } else {
    if (-not (Test-Path env:WIRED_NETADAPTERNAME)) { $env:WIRED_NETADAPTERNAME = 'Ethernet' }
    New-VMSwitch -SwitchName ExternalSwitch -NetAdapterName $env:WIRED_NETADAPTERNAME -AllowManagementOS $true
  }
}

# Change ExternalSwitch to Wi-Fi
function set-wifi-vmswitch() {
  if (-not (Test-Path env:WIFI_NETADAPTERNAME)) { $env:WIFI_NETADAPTERNAME = 'Wi-Fi' }
  Set-VMSwitch -VMSwitch $(Get-VMSwitch -Name ExternalSwitch) -NetAdapterName $env:WIFI_NETADAPTERNAME
}

# Change ExternalSwitch to Wired
function set-wired-vmswitch() {
  if (-not (Test-Path env:WIRED_NETADAPTERNAME)) { $env:WIRED_NETADAPTERNAME = 'Ethernet' }
  Set-VMSwitch -VMSwitch $(Get-VMSwitch -Name ExternalSwitch) -NetAdapterName $env:WIRED_NETADAPTERNAME
}
