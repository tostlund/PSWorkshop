filter Select-Running {
    param(
        $Status
    )
    if($_.Status -eq $Status) {
        Write-Output -InputObject $_
    }
}

Get-Service | Select-Running -Status Running

function Get-Age ($BirthDay) {
    $Age = (Get-Date) - (Get-Date $BirthDay)
    Write-Output $Age.Days
}

Get-Age -BirthDay 1983-09-22

function Get-Age {
    param($BirthDay)
    $Age = (Get-Date) - (Get-Date $BirthDay)
    Write-Output $Age.Days
    Write-Output $Blaj
}

Get-Age -BirthDay 1983-09-22

Get-Age 1983-09-22

