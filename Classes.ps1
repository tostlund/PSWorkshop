enum ComputerType {
    SurfaceBook
    HPLaptop
    IPAD
    ChromeBook
}

class SimonWahlinUserClass {
    # Properties
    [string] $GivenName
    [string] $Surname
    [int] $BirthYear
    [string] $FullName
    hidden [string] $Age


    # Constructor: Creates a new SimonWahlinUserClass object, with the specified name
    SimonWahlinUserClass([String] $GivenName, [string] $Surname, [int] $Year) {
        Write-Verbose -Message 'With year!' -Verbose
        # Set name for SimonWahlinUserClass
        $this.GivenName = $GivenName
        $this.Surname = $Surname
        $this.FullName = '{0} {1}' -f $GivenName, $Surname
        # SimonWahlinUserClass($GivenName,$Surname)
        $this.BirthYear = $Year
        $this.Age = (Get-Date).Year - (Get-Date -Year $Year).Year
    }

    SimonWahlinUserClass([string] $GivenName, [string] $Surname) {
        Write-Verbose -Message 'Without year' -Verbose
        $this.GivenName = $GivenName
        $this.Surname = $Surname
        $this.FullName = '{0} {1}' -f $GivenName, $Surname
    }

    # Method: Method that changes $Name to the default name
    [void] UpdateAge() {
        $this.Age = (Get-Date).Year - (Get-Date -Year $this.BirthYear).Year
    }

    [string] ToString() {
        $string = '{0};{1}' -f $this.FullName, $this.BirthYear
        return $string
    }
}

enum MemberAccess {
    Read = 1
    Write = 2
    Delete = 4
    Execute = 8
}

function Register-Computer {
    [CmdletBinding()]
    param (
        [ComputerType]
        $ComputerType,
        [MemberAccess[]]
        $Access
    )

    begin {
    }

    process {
        $ComputerType
    }

    end {
    }
}
