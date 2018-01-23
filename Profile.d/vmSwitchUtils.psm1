# VMSwitch Utils to make moving between networks easier

# Change ExternalSwitch to Wi-Fi
function set-wifi-vmswitch() {

  Set-VMSwitch -VMSwitch $(Get-VMSwitch -Name ExternalSwitch) -NetAdapterName Wi-Fi

}

# Change ExternalSwitch to Wired
function set-wired-vmswitch() {

  Set-VMSwitch -VMSwitch $(Get-VMSwitch -Name ExternalSwitch) -NetAdapterName Ethernet

}
