# Get the Profile Directory
$profileDir=(Split-Path -Parent -Path $PROFILE)
# Get the Profile.d Directory
$profileDDir=(Join-Path -Path $profileDir -ChildPath "Profile.d")

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Load Custom Modules
(Get-Item "${profileDDir}\*.psm1").FullName | %{ Import-Module -DisableNameChecking "$_" }

# Source scripts
(Get-Item "${profileDDir}\*.ps1").FullName | %{ . "$_" }
