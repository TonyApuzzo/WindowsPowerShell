# Minikube Profile

# Use 1/2 the cores for minikube
function get-mk-default-cpus() {
  return [int][Math]::Ceiling((Get-WmiObject -Class "Win32_Processor" -Property ThreadCount).ThreadCount / 2)
}

# Use 1/4 the RAM for minikube
function get-mk-default-memory() {
  return [int][Math]::Ceiling((Get-WmiObject -class "Win32_PhysicalMemoryArray").MaxCapacity / 1024 / 4)
}

# Get a default switch to use
# In this order:
# "Default Switch" -> "nat" -> any external -> any switch
function get-mk-default-vmswitch() {
  $s=(Get-VMSwitch "Default Switch")
  if ($s) {
    return $s
  } else {
    $s=(Get-VMSwitch "nat")
    if ($s) {
      return $s
    } else {
      $s=(Get-VMSwitch -SwitchType "External")[0]
      if ($s) {
        return $s
      } else {
        return (Get-VMSwitch)[0]
      }
    }
  }
}

function minikube-start () {
  # Minikube can only start from the User Profile drive
  # See: https://github.com/kubernetes/minikube/issues/459
  Push-Location "${env:USERPROFILE}\"
  
  try {
    $switch=(&get-mk-default-vmswitch).Name
    $ram=(get-mk-default-memory)
    $cpus=(get-mk-default-cpus)
    $k8sVersion="v1.8.0"
    $vSwitch="ExternalSwitch"
    minikube start --vm-driver=hyperv --hyperv-virtual-switch=$vSwitch --alsologtostderr --cpus=$cpus --memory=$ram --kubernetes-version=$k8sVersion
  }
  finally {
    Pop-Location
  }
}

function minikube-restart () {
  if (minikube stop) {
    if (minikube-start) {
       Write-Verbose "INFO: minikube started"
    }
  } else {
    Write-Error "ERROR: minikube returned a failure stopping"
  }
}

function minikube-up () {
  if (minikube-restart) {
    if (minikube docker-env | Invoke-Expression) {
      Write-Verbose "INFO: Local Docker configured to use minikube"
    }
  }
}
