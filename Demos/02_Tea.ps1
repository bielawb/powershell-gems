if ($demoGodsFailedMe) {
    Write-Warning -Message "Stop pressing F5!"
    break
}

ls .\Demos | tee C:\RecycleBin\ls.txt | measure | % Count
$null = Show-Picture -Name Tee
Get-Content -Path C:\RecycleBin\ls.txt

Get-Content -Path C:\RecycleBin\ls.txt | ForEach-Object GetType | ForEach-Object FullName

# Objects! I want OBJECTS!

Get-Service | Tee-Object -Variable services | Group-Object -Property Status -NoElement
$services.Where{ $_.Status -eq 'Running' } | Tee-Object -Variable runningService | Group-Object -Property StartType
$runningService | select Name, DisplayName, ServiceType -First 5

Start-NextDemo