if ($demoGodsFailedMe) {
    Write-Warning -Message "Stop pressing F5!"
    break
}

Get-ChildItem -Recurse -Path C:\Repos -Filter G*.ps1 | Select-Object BaseName, { $_.Length / 42 }

Get-ChildItem -Recurse -Path C:\Repos -Filter G*.ps1 | Sort-Object { $_.LastWriteTime - $_.CreationTime }| Select-Object BaseName, LastWriteTime, CreationTime

Get-ChildItem -Recurse -Path C:\Repos -Filter G*.ps1 | Sort-Object {
    switch -Regex ($_.BaseName) {
        \.tests {
            # make sure they are last... ;)
            "ZZZZZZZZZZZ$_"
            break
        }
        ^Get- {
            $_ -replace 'Get-'
            break
        }
        default {
            [array]::Reverse(
                ($text = $_.ToCharArray())
            )
            -join $text
        }
    }
} | Select-Object BaseName, {
    switch -Regex ($_.BaseName) {
        \.tests {
            'Tests go last!'
        }
        ^Get- {
            "Don't care about Get- prefix!"
        }
        default {
            'Reverse it!'
        }
    }
}

Get-ChildItem -Recurse -Path C:\Repos -Filter G*.ps1 | Group-Object { $_.BaseName -match '.tests$' }

Start-NextDemo