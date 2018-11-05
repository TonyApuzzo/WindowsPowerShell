# Kubernetes Aliases and Completion
# See: https://github.com/tillig/ps-bash-completions
Import-Module PSBashCompletions -ErrorAction SilentlyContinue -ErrorVariable err
if ($err.count -eq 0) {
  $kubectl = Get-Command kubectl -ErrorAction SilentlyContinue
  if ($kubectl) {
    $kubectlCompletions = Get-Item -Path "$env:TEMP\kubectl_completions.sh" -ErrorAction SilentlyContinue
    if ($null -eq $kubectlCompletions) {
      & $kubectl completion bash | Out-File -Encoding ASCII -NoNewline -FilePath "$env:TEMP\kubectl_completions.sh"
      $kubectlCompletions = Get-Item -Path "$env:TEMP\kubectl_completions.sh" -ErrorAction Stop
    }
    Register-BashArgumentCompleter "kubectl" $kubectlCompletions.FullName
  }
}
