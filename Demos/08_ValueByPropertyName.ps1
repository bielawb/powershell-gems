if ($demoGodsFailedMe) {
    Write-Warning -Message "Stop pressing F5!"
    break
}

foreach ($key in ($attributes = (Get-Command -Name Rename-Item).Parameters).Keys) {
    if ($attributes.$key.Attributes.ValueFromPipelineByPropertyName) {
        $attributes.$key.Name
    }
}

Get-ChildItem -Path .\Demos\* -File | Rename-Item -NewName { '0{0}' -f $_.Name } -WhatIf
Invoke-Command -Session $session -ScriptBlock { Import-Module ActiveDirectory }
Import-PSSession -Session $session -Module ActiveDirectory
Invoke-Command -Session $session {
    (Get-Command -Name New-ADUser).Parameters.Values.Where{ $_.Attributes.ValueFromPipelineByPropertyName } | Format-Table Name
}

@'
first,last
Ewa,Bielawska
Hania,Bielawska
Paweł,Bielawski
'@ | ConvertFrom-Csv |
    New-ADUser -SamAccountName {
            '{0}{1}' -f $_.first[0], $_.lasts 
        } -Name {
            '{0}{1}' -f $_.first, $_.last
        }  -WhatIf

Invoke-Command -Session $session -ScriptBlock {
@'
first,last
Ewa,Bielawska
Hania,Bielawska
Paweł,Bielawski
'@ | ConvertFrom-Csv |
    New-ADUser -SamAccountName {
            '{0}{1}' -f $_.first[0], $_.lasts 
        } -Name {
            '{0}{1}' -f $_.first, $_.last
        }  -WhatIf
}

Start-NextDemo