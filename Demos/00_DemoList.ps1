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
    if ($_.BaseName -match '00') {
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
            [topic]::new($key, $PSBoundParameters.$key, $map[$key])
        }
        $Global:demoQueue = [System.Collections.Queue]::new()
        $list | Sort-Object -Descending Count | Tee-Object -Variable sortedList
        foreach ($item in $sortedList) {
            $Global:demoQueue.Enqueue($item.FilePath)
        }
    }
}

Get-TopicCount
Start-NextDemo