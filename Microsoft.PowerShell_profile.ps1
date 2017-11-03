# Set My preferred theme colors
. (Join-Path -Path (Split-Path -Parent -Path $PROFILE) -ChildPath $(switch($HOST.UI.RawUI.BackgroundColor.ToString()){'White'{'Set-SolarizedLightColorDefaults.ps1'}'Black'{'Set-SolarizedDarkColorDefaults.ps1'}default{return}}))

# Get the Profile Directory
$profileDir=((Get-Item $PROFILE).Directory.GetDirectories("Profile.d"))[0]

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Load Custom Modules
$profileDir.getFiles("*.psm1").FullName | %{ Import-Module -DisableNameChecking "$_" }

# Source scripts
$profileDir.getFiles("*.ps1").FullName | %{ . "$_" }
