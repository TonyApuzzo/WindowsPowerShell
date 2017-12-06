# FZF Profile

# Alias fzf to workaround https://github.com/junegunn/fzf/issues/963
function fzf() {
  try {
    $fzf = Get-Command -CommandType Application -ErrorAction Stop fzf
    if (Test-Path Env:\TERM) {
      $saveTERM = $Env:TERM
      $Env:TERM = ''
    }
    & $fzf @Args
  }
  finally {
    if (Test-Path Variable:\saveTERM) {
      $Env:TERM = $saveTERM
    }
  }
}

