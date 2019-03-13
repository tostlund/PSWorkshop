# Plain debugging on console
Set-PSBreakpoint -Script .\AdvancedFunctions.ps1 -Line 62
Get-PSBreakpoint

# Debug other process
# Get process ID from powershell
$PID

# List all powershell processes
Get-PSHostProcessInfo

# Attach to process with PID 1234
Enter-PSHostProcess -Id 1234

# List all runspaces in proces
Get-Runspace

# Enter a runspace for debugging
Debug-Runspace -Id 1

