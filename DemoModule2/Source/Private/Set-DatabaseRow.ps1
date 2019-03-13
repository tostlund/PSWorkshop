function Set-DatabaseRow {
    [cmdletbinding(SupportsShouldProcess=$true)]
    param (
        [SimonWahlinUserClass]
        $InputObject,
        [switch]
        $Force
    )

    # Check WhatIf
    if($PSCmdlet.ShouldProcess($Result.FullName,'Add member')) {
        # Check if Force, or Confirm
        if($Force -or $PSCmdlet.ShouldContinue($Result.FullName,'Confirm adding member:')) {
            Write-Warning -Message 'Commiting to database!'
            Write-Output -InputObject $Result
        }
    }

}
