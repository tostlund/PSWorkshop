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

        Set-DatabaseRow -InputObject $Result -Force:$Force

    }

    end {
        Write-Verbose -Message 'Closing connection.'
    }

}