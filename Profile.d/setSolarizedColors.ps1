# Set My preferred theme colors
$colorTheme = (Join-Path -Path $profileDir -ChildPath $(
    switch($HOST.UI.RawUI.BackgroundColor.ToString()){
      'White'{'Set-SolarizedLightColorDefaults.ps1'}
      'Black'{'Set-SolarizedDarkColorDefaults.ps1'}
      default{return}
    }
  ))
if (Test-Path($colorTheme)) {
  . $colorTheme
}
