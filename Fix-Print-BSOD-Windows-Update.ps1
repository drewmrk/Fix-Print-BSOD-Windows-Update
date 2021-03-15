$version = (Get-Item "HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion").GetValue('ReleaseID')

echo "Windows Version" 
echo $version
echo "-----------------"

If ($version -eq 1803 -or $version -eq 1809 -or $version -eq 1909 -or $version -eq 2004) {

  If ($version -eq 1803) {
    echo "Uninstalling KB5000809..."
    wusa /uninstall /kb:50000809 /quiet /norestart
  } Elseif ($version -eq 1809) {
    echo "Uninstalling KB5000822..."
    wusa /uninstall /kb:5000822 /quiet /norestart
  } Elseif ($version -eq 1909) {
    echo "Uninstalling KB5000808..."
    wusa /uninstall /kb:5000808 /quiet /norestart
  } Elseif ($version -eq 2004) {
    echo "Uninstalling KB5000802..."
    wusa /uninstall /kb:5000802 /quiet /norestart
  }

  echo "Pausing Windows updates until 4/15/2021..."
  Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'PauseUpdatesExpiryTime' -Value "2021-04-16T00:00:00Z"

  echo "All done, restarting now!"
  Restart-Computer

} else {
  echo "You do not have an effected version of Windows."
}

pause
