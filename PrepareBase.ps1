# Description: Boxstarter Script  
Disable-UAC

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/base"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
    iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
executeScript "EnableDeveloperMode.ps1";
executeScript "FileExplorerSettings.ps1";
executeScript "RemoveDefaultApps.ps1";
executeScript "CommonTools.ps1";

#--- Configure network / file sharing and remote desktop
executeScript "NetworkAndFileSharing.ps1"

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
