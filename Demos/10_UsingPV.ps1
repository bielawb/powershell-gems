if ($demoGodsFailedMe) {
    Write-Warning -Message "Stop pressing F5!"
    break
}

Get-ChildItem -Path 'C:\Windows\*.*' -Exclude iis.log -ErrorAction SilentlyContinue -PipelineVariable file -File |
    Get-Acl -PipelineVariable acl |
    Select-Object -Property @(
        @{
            Name = 'Name'
            Expression = { $file.Name }
        }
        @{
            Name = 'Size'
            Expression = { $file.Length }
        }
        @{
            Name = 'Owner'
            Expression = { $acl.Owner }
        }
        @{
            Name = 'NonInheritedCount'
            Expression = { @($acl.Access.Where{ -not $_.IsInherited }).Count }
        }
    )

Start-NextDemo