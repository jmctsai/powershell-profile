# Network Utilities
function Get-PubIP { (Invoke-WebRequest http://ifconfig.me/ip).Content }

# Open WinUtil full-release
function winutil {
  irm https://christitus.com/win | iex
}

# Set UNIX-like aliases for the admin command, so sudo <command> will run the command with elevated rights.
Set-Alias -Name su -Value admin

function uptime {
  try {
    # find date/time format
    $dateFormat = [System.Globalization.CultureInfo]::CurrentCulture.DateTimeFormat.ShortDatePattern
    $timeFormat = [System.Globalization.CultureInfo]::CurrentCulture.DateTimeFormat.LongTimePattern

    # check powershell version
    if ($PSVersionTable.PSVersion.Major -eq 5) {
      $lastBoot = (Get-WmiObject win32_operatingsystem).LastBootUpTime
      $bootTime = [System.Management.ManagementDateTimeConverter]::ToDateTime($lastBoot)

      # reformat lastBoot
      $lastBoot = $bootTime.ToString("$dateFormat $timeFormat")
    }
    else {
      # the Get-Uptime cmdlet was introduced in PowerShell 6.0
      $lastBoot = (Get-Uptime -Since).ToString("$dateFormat $timeFormat")
      $bootTime = [System.DateTime]::ParseExact($lastBoot, "$dateFormat $timeFormat", [System.Globalization.CultureInfo]::InvariantCulture)
    }

    # Format the start time
    $formattedBootTime = $bootTime.ToString("dddd, MMMM dd, yyyy HH:mm:ss", [System.Globalization.CultureInfo]::InvariantCulture) + " [$lastBoot]"
    Write-Host "System started on: $formattedBootTime" -ForegroundColor DarkGray

    # calculate uptime
    $uptime = (Get-Date) - $bootTime

    # Uptime in days, hours, minutes, and seconds
    $days = $uptime.Days
    $hours = $uptime.Hours
    $minutes = $uptime.Minutes
    $seconds = $uptime.Seconds

    # Uptime output
    Write-Host ("Uptime: {0} days, {1} hours, {2} minutes, {3} seconds" -f $days, $hours, $minutes, $seconds) -ForegroundColor Blue

  }
  catch {
    Write-Error "An error occurred while retrieving system uptime."
  }
}

function reload-profile {
  & $profile
}

# Shell Aliases
function c { Clear-Host }
function rp { & $profile }

# Enhanced Listing
function la { Get-ChildItem | Format-Table -AutoSize }
function ll { Get-ChildItem -Force | Format-Table -AutoSize }

# Git Aliases
function gst { git status }
function gaa { git add . }
function gcom ($msg) { git commit -m "$msg" }
function gpush { git push }
