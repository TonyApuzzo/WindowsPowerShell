# Persistently set environment variables if they are not set

if (-not (Test-Path Env:EDITOR)) {
  # Set the environment for this invocation
  $env:EDITOR = (Get-Command vim.exe | Select-Object -ExpandProperty Source).Replace('\\','/')

  # Persistently set the environment variable
  [System.Environment]::SetEnvironmentVariable('EDITOR', $env:EDITOR, [System.EnvironmentVariableTarget]::User)
}
