if ($demoGodsFailedMe) {
    Write-Warning -Message "Stop pressing F5!"
    break
}

Get-ChildItem | tee C:\RecycleBin\ls.txt
cat C:\RecycleBin\ls.txt

cat C:\RecycleBin\ls.txt | ForEach-Object GetType | ForEach-Object FullName

# Objects! I want OBJECTS!

Get-Service -Name MS* | Tee-Object -Variable services
$services.Name
