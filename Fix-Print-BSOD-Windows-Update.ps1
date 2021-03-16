$version = (Get-Item "HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion").GetValue('ReleaseID')

echo "Windows Version" 
echo $version
echo "-----------------"

If ($version -eq 1803 -or $version -eq 1809 -or $version -eq 1909 -or $version -eq 2004 -or $version -eq 2009) {

  echo "Pausing Windows updates until 4/15/2021..."
	Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'PauseUpdatesExpiryTime' -Value "2021-04-16T00:00:00Z"

	If ($version -eq 1803) {
		echo "Uninstalling KB5000809..."
		wusa /uninstall /kb:50000809
	} Elseif ($version -eq 1809) {
		echo "Uninstalling KB5000822..."
		wusa /uninstall /kb:5000822
	} Elseif ($version -eq 1909) {
		echo "Uninstalling KB5000808..."
		wusa /uninstall /kb:5000808
	} Elseif ($version -eq 2004 -or $version -eq 2009) {
		echo "Uninstalling KB5000802..."
		wusa /uninstall /kb:5000802
	}

  echo "Restarting in 10 minutes..."
  Start-Sleep -Seconds 600; Restart-Computer -Force


} else {
	  echo "You do not have an effected version of Windows."
}

pause
