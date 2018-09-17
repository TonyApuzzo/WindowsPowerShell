# Persistently set environment variables if they are not set

if (-not (Test-Path env:EDITOR)) {
  # Set the environment for this invocation
  $env:EDITOR = Get-Command notepad++.exe | Select-Object -ExpandProperty Source

  # Persistently set the environment variable
  [System.Environment]::SetEnvironmentVariable('EDITOR', $env:EDITOR, [System.EnvironmentVariableTarget]::User)
}
