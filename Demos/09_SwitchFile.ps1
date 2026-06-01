if ($demoGodsFailedMe) {
    Write-Warning -Message "Stop pressing F5!"
    break
}

$counter = 1
switch -File C:\Repos\EWS\EWS\Clear-EWSFolder.ps1 {
    default {
        '{0:D3} {1}' -f $counter++, $_
    }
}

# Something fails on line 31, lets see...
$counter = 1
switch -File C:\Repos\EWS\EWS\Clear-EWSFolder.ps1 {
    {
        [Math]::Abs(31 - $counter) -lt 5
    } {
        '{0:D3} {1}' -f $counter++, $_
    }
    default {
        $counter++
    }
}

switch -File C:\Repos\DzieciakiWiatraki\Blog.css -Regex {
    background-image {
        $_ -replace '.*?(https.*png).*', '$1'
    }
}

Start-NextDemo