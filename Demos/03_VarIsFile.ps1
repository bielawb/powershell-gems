if ($demoGodsFailedMe) {
    Write-Warning -Message "Stop pressing F5!"
    break
}

${C:\Windows\system32\drivers\etc\hosts}

${function:Get-Foo} = {
    param (
        [String]$Bar
    )

    "Bar: $Bar"
}

Get-Foo -Bar IsBar

