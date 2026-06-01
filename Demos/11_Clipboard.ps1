if ($demoGodsFailedMe) {
    Write-Warning -Message "Stop pressing F5!"
    break
}


(Get-Clipboard) -join ', '
# Say, I want to do something with DNS record: powershellpl.net

Resolve-DnsName -Name (Get-Clipboard) | Tee-Object -Variable dns
$body = @{
    name = (Get-Clipboard)
    ip = $dns[0].IPAddress
} | ConvertTo-Json

$body | Write-Verbose -Verbose
Invoke-RestMethod -Method Post -Body $body -Uri https://notthere.com -Verbose

Start-NextDemo