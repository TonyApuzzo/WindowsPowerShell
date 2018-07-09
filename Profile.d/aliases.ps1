
# Nuke idiotic default Powershell Aliases
ri alias:ls
ri alias:wget
ri alias:man
ri alias:curl
ri alias:rmdir

# Start Remote Desktop Session in the background
function vrdp() {
  Start-Process -NoNewWindow vagrant.exe rdp @Args
}

# Use git bash to get a listing of files by size in git

function Get-GitBlobSizes() {
  # Inspired by https://stackoverflow.com/a/42544963/2430594
  bash -c @'
    git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | awk '/^blob/ {print substr(\$0,6)}' | sort --numeric-sort --key=2 | cut --complement --characters=13-40 | numfmt --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
'@
}
