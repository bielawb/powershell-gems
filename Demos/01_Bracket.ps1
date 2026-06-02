if ($demoGodsFailedMe) {
    Write-Warning -Message "Stop pressing F5!"
    break
}

if ($value = Get-Content $psISE.CurrentFile.FullPath) {
    $value.Length
}

$valueHidden = Get-Process | Where-Object -Property Name -Like *PowerShell*
$valueHidden
($valueShown = Get-Process | Where-Object -Property Name -Like *PowerShell*)
$valueShown

Start-NextDemo