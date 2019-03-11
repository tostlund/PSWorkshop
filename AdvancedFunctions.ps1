function Add-SWMember {
    [cmdletbinding()]
    param (
        [Parameter(Mandatory,Position = 2, ValueFromPipelineByPropertyName=$true,HelpMessage='Ett förnamn tack')]
        [string]
        $GivenName,

        [Parameter(Position = 1,ValueFromPipelineByPropertyName=$true,DontShow=$true)]
        $Surname,

        [Parameter(Position = 3,ValueFromPipelineByPropertyName=$true)]
        [int]
        $BirthYear
    )

    begin {
        Write-Verbose -Message 'Connecting to members database'
    }

    process {
        Write-Verbose -Message "Processing $GivenName..."

        $Result = [pscustomobject]@{
            GivenName = $GivenName
            Surname = $Surname
            BirthYear = $BirthYear
        }
        Write-Output -InputObject $Result

    }

    end {
        Write-Verbose -Message 'Closing connection.'
    }

}

# Add-SWMember Simon Wahlin 1983 -Verbose

# 'Simon' | Add-SWMember

# Import-Csv -Path .\Memberlist.csv -Delimiter ';' | Add-SWMember -Verbose

$InputDat = Import-Csv -Path .\Memberlist.csv -Delimiter ';'
foreach ($Entry in $InputDat) {
    Add-SWMember -GivenName  $Entry.GivenName -Surname $Entry.Surname -BirthYear $Entry.BirthYear -Verbose
}

Import-Csv -Path .\Memberlist.csv -Delimiter ';' | ForEach-Object -Begin {} -Process {
    Add-SWMember -GivenName  $_.GivenName -Surname $_.Surname -BirthYear $_.BirthYear -Verbose
} -End {}

# DO NOT USE foreach as an alias for ForEach-Object
# Import-Csv -Path .\Memberlist.csv -Delimiter ';' | foreach -Process {
#     Add-SWMember -GivenName  $_.GivenName -Surname $_.Surname -BirthYear $_.BirthYear -Verbose
# }

$PSDefaultParameterValues.Add('*:Surname','Wahlin')
$PSDefaultParameterValues.Add('Add-SWMember:Surname','Wahlin')
Add-SWMember -GivenName asdf -BirthYear 1923
Add-SWMember -GivenName asdf -BirthYear 1923 -Surname Sigvardsson

