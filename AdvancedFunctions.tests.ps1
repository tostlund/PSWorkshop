param(

)
$Classes = "$PSScriptRoot\Classes.ps1"
. $Classes
$Functions = "$PSScriptRoot\AdvancedFunctions.ps1"
. $Functions

Context 'Testing Advanced Functions' -Tag 'base' {
    BeforeAll {
        # Code to run before all
    }


    Describe 'Bla bla' {
        BeforeEach {
            # This code runs each time before It is executed
            Write-Verbose -Message 'BeforeEach!' -Verbose
        }
        Mock 'Set-DatabaseRow' {
            Write-Warning -Message 'This is not for real!'
            Write-Output $InputObject
        }
        It 'Returns an object with a full name' {
            $Result = Add-SWMember -GivenName Simon -Surname Wahlin -BirthYear 1983 -Confirm:$false -Force
            $Result.FullName | Should -Be 'Simon Wahlin'
        }

        It 'Returns CSV toString representation' {
            $Result = Add-SWMember -GivenName Simon -Surname Wahlin -BirthYear 1983 -Confirm:$false -Force
            $Result.ToString() | Should -Be 'Simon Wahlin;1983'
        }
    }


}

Context 'Infrastructure tests' -Tag 'Infra' {
    It 'W32Time is running!' {
        Get-Service W32Time | Select-Object -ExpandProperty Status | Should -Be 'Running'
    }
}