if ($demoGodsFailedMe) {
    Write-Warning -Message "Stop pressing F5!"
    break
}

function Get-Regular {
    param (
        [Parameter(ValueFromPipeline)]
        [String]$Name
    )

    "Last one was: $Name"
}

'Hania', 'Paweł', 'Ewa' | Get-Regular

# Fix - make sure you have a process!

function Get-Pipeline {
    param (
        [Parameter(ValueFromPipeline)]
        [String]$Name
    )
    begin {
        Write-Verbose -Message 'Connecting to...'
    }
    process {
        "Current one is: $Name"
    }
    end {
        Write-Verbose -Message 'Disco from...'
    }
}

'Hania', 'Paweł', 'Ewa' | Get-Pipeline

filter Get-Easier {
    param (
        [Parameter(ValueFromPipeline)]
        [String]$Name
    )
    "Current one is: $Name"
}

'Hania', 'Paweł', 'Ewa' | Get-Easier

Start-NextDemo