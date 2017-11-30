# Get the common profile file
$commonProfile=(Join-Path -Path (Split-Path -Parent -Path $PROFILE) -ChildPath "Common_Profile.ps1")

# Load The Common Profile
if (Test-Path($commonProfile)) {
  . $commonProfile
}
