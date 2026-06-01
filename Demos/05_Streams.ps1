if ($demoGodsFailedMe) {
    Write-Warning -Message "Stop pressing F5!"
    break
}

$help = Get-Help -Name about_output_streams
$help -replace '(?ms).*(^PowerShell supports.*?redirection\.).*', '$1'

$redirect = Get-Help -Name about_Redirection
$redirect -replace '(?ms).*(^PowerShell redirection.*?SUCCESS stream\.).*', '$1'

Test-DscConfiguration -Verbose -Detailed 4>&1 | Tee-Object -Variable output
$output = Import-Clixml -Path .\Demos\Helpers\output.clixml
$output
# Should be just a 'Message', CliXml is doing something fancy here... ;)
$output.Where{ $_.InformationalRecord_Message -match 'Bartek' }

Start-NextDemo