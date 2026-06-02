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
    "Value is $Value"
'@

test foo

$function:test += 'fail'

$function:Get-Foo

Get-ChildItem -Path Env:

Start-NextDemo