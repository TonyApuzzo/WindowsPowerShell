# Persistently set Path
function script:updatePath {
  $changed = $false
  $pathArray = [System.Collections.ArrayList][System.Environment]::GetEnvironmentVariable('PATH').split(';')

  $myPaths = "$env:APPDATA\Python\Python36\Scripts",`
             "C:\cloud\win\bin",`
             "C:\local\bin"

  # Add existing directories if missing from PATH
  Foreach ($p in $myPaths) {
    if (! ($pathArray | Where-Object { $_ -eq $p }) -and (Test-Path -Path $p)) {
      $pathArray.add($p)
      $changed = $true
    }
  }

  if ($changed) {
    $newPath = $pathArray -join ";"

    # Set the environment for this invocation
    $env:PATH = $newPath

    # Persistently set the PATH environment variable
    [System.Environment]::SetEnvironmentVariable('PATH', $newPath, [System.EnvironmentVariableTarget]::User)
  }
}

set-psdebug -trace 2
&script:updatePath
set-psdebug -trace 0
