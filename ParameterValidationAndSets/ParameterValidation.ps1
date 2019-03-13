function New-User {
    [CmdletBinding()]
    param (
        # GivenName
        [Parameter(Mandatory)]
        [ValidateLength(1,64)]
        [string]
        $GivenName,

        # Surname
        [Parameter(Mandatory)]
        [ValidateLength(1,64)]
        [string]
        $Surname,

        # MobilePhone
        [Parameter(Mandatory)]
        [AllowNull()]
        $MobilePhone,

        # Manager
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Manager,

        # ComputerType
        [Parameter(Mandatory)]
        [ValidateSet("Macbook", "Microsoft Surface Book", "None")]
        [String]
        $ComputerType,

        # EmployeeId
        [Parameter(Mandatory)]
        # Must match atleast 4 digits
        [ValidatePattern('\d{4}')]
        $EmployeeId,

        # Start Date
        [Parameter(Mandatory)]
        [ValidateScript(
            {
                if ($_ -lt (get-date)) {
                    Throw 'Start date cannot have passed.'
                } else {
                    $true
                }
            }
        )]
        [datetime]
        $StartDate
    )
    
    begin {
    }
    
    process {
        [PSCustomObject]@{
            GivenName = $GivenName
            Surname = $Surname
            MobilePhone = $MobilePhone
            ComputerType = $ComputerType
            EmployeeId = $EmployeeId
            StartDate = $StartDate.ToShortDateString()
            Manager = $Manager
        }
    }
    
    end {
    }
}

# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-6
# http://blog.simonw.se/powershell-functions-and-parameter-sets/
# http://apikatalogen.se/api
