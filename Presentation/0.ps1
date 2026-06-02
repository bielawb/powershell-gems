using namespace System.Management.Automation
$3 = @($psISE.CurrentPowerShellTab.Files.Where{ $_.DisplayName -eq '3.xaml' })[0]
$2 = @($psISE.CurrentPowerShellTab.Files.Where{ $_.DisplayName -eq '2.xaml' })[0]
$1 = @($psISE.CurrentPowerShellTab.Files.Where{ $_.DisplayName -eq '1.xaml' })[0]
$0 = @($psISE.CurrentPowerShellTab.Files.Where{ $_.DisplayName -eq '0.ps1' })[0]
$main = @($psISE.CurrentPowerShellTab.Files.Where{ $_.DisplayName -eq '00_Title.xaml' })[0]

$demoGodsFailedMe = $true
Start-Sleep -Milliseconds 100
$wshell.SendKeys('^r')
do {
    if ($justTesting) {
        break
    }
    Start-Sleep -Seconds 10
} while ((Get-Date).Hour -lt 13)

# 3... 2... 1... countdown - PS ISE style. :P
foreach ($file in $0, $3, $2, $1) {
    Start-Sleep -Seconds 1
    $null = $psISE.CurrentPowerShellTab.Files.Remove($file)
}
$psISE.CurrentPowerShellTab.Files.SetSelectedFile($main)

function Start-NextDemo {
    $wshell.SendKeys('^r')
    $qa = @($psISE.CurrentPowerShellTab.Files.Where{ $_.DisplayName -eq '98_QA.xaml' })[0]
    if ((Get-Date).Minute -lt 42 -and $Global:demoQueue.Count -gt 0) {
        $next = $Global:demoQueue.Dequeue()
        $file = ($psISE.CurrentPowerShellTab.Files.Where{ $_.FullPath -eq $next })[0]
        $psISE.CurrentPowerShellTab.Files.SetSelectedFile($file)
    } else {
        $psISE.CurrentPowerShellTab.Files.SetSelectedFile($qa)
    }
}

$creds = Import-Clixml -Path C:\RecycleBin\creds.clixml
$session = New-PSSession -ComputerName 192.168.56.10 -Credential $creds
Start-DscConfiguration -UseExisting -Wait