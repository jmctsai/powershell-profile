# Open WinUtil full-release
function winutil {
  irm https://christitus.com/win | iex
}

# Enhanced Listing
function la { Get-ChildItem | Format-Table -AutoSize }
function ll { Get-ChildItem -Force | Format-Table -AutoSize }

# Git Shortcuts
function gst { git status }
function gaa { git add . }
function gcom ($msg) { git commit -m "$msg" }
function gpush { git push }