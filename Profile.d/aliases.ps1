
# Nuke idiotic default Powershell Aliases
#ri alias:ls
#ri alias:wget
#ri alias:man
#ri alias:curl
#ri alias:rmdir

# Use git bash to get a listing of files by size in git

function Get-GitBlobSizes() {
  # Inspired by https://stackoverflow.com/a/42544963/2430594
  bash -c @'
    git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | awk '/^blob/ {print substr(\$0,6)}' | sort --numeric-sort --key=2 | cut --complement --characters=13-40 | numfmt --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
'@
}

function Git-Merge-Current-to-All-Branches {
    $srcBranch = git rev-parse --abbrev-ref HEAD
    if (!$?) { Write-Output "Stopped."; return }

    if ($srcBranch -eq "HEAD") {
        Write-Output "Current Branch is not a named branch, aborting."
        return
    }
    $unmergedBranches = git branch --format="%(refname:short)" --no-merge
    foreach ($branch in $unmergedBranches) {
        git checkout $branch
        if (!$?) { Write-Output "Stopped."; return }

        git pull
        if (!$?) { Write-Output "Stopped."; return }

        git merge $srcBranch
        if ($?) {
            Write-Output "Merged $srcBranch into $branch"
        } else {
            Write-Output "Stopped merging due to conflict"
            return
        }
    }
    Write-Output "Finished."
    git checkout $srcBranch
}

# See https://www.nirsoft.net/utils/control_my_monitor.html
# Allowed Values: 1, 3, 4, 12, 15, 17, 18
function Set-DisplayPort() {
    ControlMyMonitor.exe /SetValue "DELL U3011" 60 15
}

function Set-HDMI1() {
    ControlMyMonitor.exe /SetValue "DELL U3011" 60 17
}