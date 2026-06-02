if ($demoGodsFailedMe) {
    Write-Warning -Message "Stop pressing F5!"
    break
}

class Topic {
    [String]$Name
    [Int]$Count
    [String]$FilePath

    Topic ($name, $count, $filePath) {
        $this.Name = $name
        $this.Count = $count
        $this.FilePath = $filePath
    }
}
$map = @{}
Get-ChildItem -Path C:\Repos\powershell-gems\Demos\*.ps1 | ForEach-Object {
    if ($_.BaseName -match '0[0-3]') {
        # well...
        return
    }
    $name = $_.BaseName -replace '^\d+_'
    $map.Add($name, $_.FullName)
}
function Get-TopicCount {
    [CmdletBinding()]
    param ()
    dynamicParam {
        if ($true) {
            $params = [RuntimeDefinedParameterDictionary]::new()
            foreach ($key in $map.Keys) {
                $attributes = [Collections.ObjectModel.Collection[Attribute]]::new()
                $attributes.Add(
                    [ParameterAttribute]@{
                        Mandatory = $true
                    }
                )
                $params.Add(
                    $key,
                    [RuntimeDefinedParameter]::new($key, [int], $attributes)
                )
            }
        }
        $params
    }

    end {
        $list = foreach ($key in $PSBoundParameters.Keys) {
            if ($key -eq 'Verbose') {
                continue
            }
            [topic]::new($key, $PSBoundParameters.$key, $map[$key])
        }
        $prio = 0
        $prioCount = 3kb, 2kb, 1kb
        $list += Get-ChildItem -Path C:\Repos\powershell-gems\Demos\0[123]*.ps1 | ForEach-Object {
            [topic]::new(
                $_.BaseName -replace '^\d+_',
                $prioCount[$prio],
                $_.FullName
            )
            $prio++
        }

        $Global:demoQueue = [System.Collections.Queue]::new()
        $list | Sort-Object -Descending Count | Tee-Object -Variable sortedList
        Write-Verbose -Message "Manipulating data..."
        foreach ($item in $sortedList) {
            $Global:demoQueue.Enqueue($item.FilePath)
        }
    }
}

Get-TopicCount -Clipboard 5 -UsingPV 10 -Filters 15 -Globbing 20 -Streams 30 -ObjectScriptBlock 25 -SwitchFile 18 -ValueByPropertyName 9 -Verbose


Start-NextDemo