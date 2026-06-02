if ($demoGodsFailedMe) {
    Write-Warning -Message "Stop pressing F5!"
    break
}

${C:\Windows\system32\drivers\etc\hosts}
Push-Location C:\Windows\System32\drivers\etc\
$c:hosts

$c:hosts += @'
1.2.3.4   fo.bar
'@
ping fo.bar
$c:hosts
Pop-Location

${function:Get-Foo} = {
    param (
        [String]$Bar
    )

    "Bar: $Bar"
}


Get-Foo -Bar IsBar

$function:test = @'

    param (
        [String]$Value
    )
'@

$function:Get-Foo

Start-NextDemo