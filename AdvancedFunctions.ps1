<#
.SYNOPSIS
Adds member to database

.DESCRIPTION
Adds all members to database one by one really slowly with a long help text

.PARAMETER GivenName
Given name of member

.PARAMETER Surname
Surname of member

.PARAMETER BirthYear
Year of birth for member

.PARAMETER Force
Skip confirmation per member by using -Force

.EXAMPLE
Add-SWMember -GivenName John -Surname Smith -BirthYear 1921
Adds a member named John Smith born in 1921.

.NOTES
This function was written by Simon
#>


function Add-SWMember {
    [cmdletbinding(SupportsShouldProcess=$true)]
    [OutputType('SimonWahlinUserClass')]
    param (
        [Parameter(Mandatory,Position = 2, ValueFromPipelineByPropertyName=$true)]
        [string]
        $GivenName,

        [Parameter(Mandatory,Position = 1,ValueFromPipelineByPropertyName=$true)]
        $Surname,

        [Parameter(Position = 3,ValueFromPipelineByPropertyName=$true)]
        [int]
        $BirthYear,

        [switch]
        $Force
    )

    begin {
        Write-Verbose -Message 'Connecting to members database'
    }

    process {
        Write-Verbose -Message "Processing $GivenName..."

        # $Result = [pscustomobject]@{
        #     GivenName = $GivenName
        #     Surname = $Surname
        #     BirthYear = $BirthYear
        #     FullName = '{0} {1}' -f $GivenName, $Surname
        # }

        if($PSBoundParameters.ContainsKey('BirthYear')){
            $Result = [SimonWahlinUserClass]::new($GivenName,$Surname,$BirthYear)
        } else {
            $Result = [SimonWahlinUserClass]::new($GivenName,$Surname)
        }

        # Check WhatIf
        if($PSCmdlet.ShouldProcess($Result.FullName,'Add member')) {
            # Check if Force, or Confirm
            if($Force -or $PSCmdlet.ShouldContinue($Result.FullName,'Confirm adding member:')) {
                Write-Output -InputObject $Result
            }
        }

    }

    end {
        Write-Verbose -Message 'Closing connection.'
    }

}


<#
.SYNOPSIS
Short description

.DESCRIPTION
Long description

.PARAMETER User
Parameter description

.PARAMETER GivenName
Parameter description

.PARAMETER Surname
Parameter description

.PARAMETER BirthYear
Parameter description

.PARAMETER Force
Parameter description

.EXAMPLE
An example

.NOTES
General notes
#>
function Update-SWMember {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory, ParameterSetName='ByUser')]
        [SimonWahlinUserClass]
        $User,

        [Parameter(Mandatory,Position = 2, ValueFromPipelineByPropertyName=$true,ParameterSetName='Default')]
        [string]
        $GivenName,

        [Parameter(Mandatory,Position = 1,ValueFromPipelineByPropertyName=$true,ParameterSetName='Default')]
        $Surname,

        [Parameter(Position = 3,ValueFromPipelineByPropertyName=$true,ParameterSetName='Default')]
        [int]
        $BirthYear,

        [Parameter(ParameterSetName='Default')]
        [Parameter(ParameterSetName='ByUser')]
        [switch]
        $Force
    )

    process {
        if($PSCmdlet.ParameterSetName -eq 'Default') {
            if($PSBoundParameters.ContainsKey('BirthYear')){
                $User = [SimonWahlinUserClass]::new($GivenName,$Surname,$BirthYear)
            } else {
                $User = [SimonWahlinUserClass]::new($GivenName,$Surname)
            }
        } elseif($PSCmdlet.ParameterSetName -eq 'ByUser') {
            # User already exsist
        } else {
            throw 'Not implented!'
        }
        return $User
    }

}

# Add-SWMember Simon Wahlin 1983 -Verbose

# 'Simon' | Add-SWMember

# Import-Csv -Path .\Memberlist.csv -Delimiter ';' | Add-SWMember -Verbose

# $InputDat = Import-Csv -Path .\Memberlist.csv -Delimiter ';'
# foreach ($Entry in $InputDat) {
#     Add-SWMember -GivenName  $Entry.GivenName -Surname $Entry.Surname -BirthYear $Entry.BirthYear -Verbose
# }

# Import-Csv -Path .\Memberlist.csv -Delimiter ';' | ForEach-Object -Begin {} -Process {
#     Add-SWMember -GivenName  $_.GivenName -Surname $_.Surname -BirthYear $_.BirthYear -Verbose
# } -End {}

# DO NOT USE foreach as an alias for ForEach-Object
# Import-Csv -Path .\Memberlist.csv -Delimiter ';' | foreach -Process {
#     Add-SWMember -GivenName  $_.GivenName -Surname $_.Surname -BirthYear $_.BirthYear -Verbose
# }

# $PSDefaultParameterValues.Add('*:Surname','Wahlin')
# $PSDefaultParameterValues.Add('Add-SWMember:Surname','Wahlin')
# Add-SWMember -GivenName asdf -BirthYear 1923
Add-SWMember -GivenName asdf -BirthYear 1923 -Surname Sigvardsson


