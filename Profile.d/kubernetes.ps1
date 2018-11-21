# Kubernetes Aliases and Completion
# See: https://github.com/tillig/ps-bash-completions
Import-Module PSBashCompletions -ErrorAction SilentlyContinue -ErrorVariable err
if ($err.count -eq 0) {

  function Get-Completions {
    param ( [String]$Name )
    $command = Get-Command -Name $Name -ErrorAction SilentlyContinue
    if ($command) {
      $commandCompletions = Get-Item -Path "$env:TEMP\${command}_completions.sh" -ErrorAction SilentlyContinue
      if ($null -eq $commandCompletions) {
        ((& $command completion bash) -join "`n") | Set-Content -Encoding ASCII -NoNewline -Path "${env:TEMP}\${command}_completions.sh"
        $commandCompletions = Get-Item -Path "${env:TEMP}\${command}_completions.sh" -ErrorAction Stop
      }
      $commandCompletions.FullName
    }
  }

  foreach ($cmd in "kubectl", "helm") {
    $script = Get-Completions $cmd
    if ($script) {
      Register-BashArgumentCompleter $cmd $script
    }
  }
  
}

function get-k8s-dashboard-token() {
    kubectl -n kube-system describe secret `
        $(kubectl -n kube-system get secret `
        | Select-String '^(admin-user-\w+)' `
        | ForEach-Object { $_.matches.groups[1] } `
        | Select-Object -First 1 -ExpandProperty Value)
}