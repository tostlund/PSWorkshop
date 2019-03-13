# Try/Catc/Finally example
try {
    Get-Item -Path $Env:SystemRoot -ErrorAction Stop
    throw 'FEEEL!'
    Get-Item -Path 'C:\DoesNotExist' -ErrorAction Stop
    Get-Item -Path $Env:Temp -ErrorAction Stop
} catch [System.Management.Automation.ItemNotFoundException] {
    Write-Warning -Message 'Den filen fanns inte!'
} catch {
    $TypeName = $_.Exception.GetType().FullName
    Write-Warning -Message "Något gick fel! Fel: $TypeName"
} finally {
    Write-Verbose -Message "Vi är klara" -Verbose
}

# ErrorHandling
try {
    $folder = get-item -path $path -ErrorAction stop
} catch [System.Management.Automation.ItemNotFoundException] {
    try {
        $folder = new-item -Path $path -ItemType Directory
    } catch {
        # Print nice message and stop execution
    }
} catch {
    # Print nice message and stop execution

    if($_.Message -like '*dethärgickfel*') {
        # Special error ( not preferred )
    }
}

# Query WMI using CIM and fallback to DCOM (old WMI)
try {
    $Session = New-CimSession -ComputerName $ComputerName -Credential $Credential -ErrorAction Stop
}
catch {
    try {
        $SessionOption = New-CimSessionOption -Protocol Dcom
        $Session = New-CimSession -ComputerName $ComputerName -Credential $Credential -SessionOption $SessionOption -ErrorAction Stop
    }
    catch {
        # Really don't work, handle it!
    }
}
$CS = Get-CimInstance -CIMSession $Session -ClassName Win32_ComputerSystem

# Alternative error handling
$folder = get-item -path $path -ErrorAction SilentlyContinue
if(-not $folder) {
    $folder = new-item -Path $path -ItemType Directory
}

# Not as good error handling
$Error.Clear()
$folder = get-item -path $path -ErrorAction SilentlyContinue
if($Error.Count -gt 0) {
    # Hantera felet
}

# Another bad example
$folder = get-item -path $path -ErrorAction SilentlyContinue
if(-not$?) {
    # Handle error
}

# Another bad example
$folder = get-item -path 'C:\NoFolder' -ErrorAction SilentlyContinue -ErrorVariable PathFail
if($null -ne $PathFail) {
    # Handle error
}

# Good example for retry logic
$MaxRetry = 10
$RetryCount = 1
While($Null -eq $Data -and $RetryCount -lt $MaxRetry) {
    try {
        $Data = Get-SOmething -ErrorAction Stop
    } catch {
        $RetryCount++
        start-sleep -seconds 1
    }
}

$Data = $null,$null,3,4,6,1
if($null -eq $Data) {
    'We have no result'
}
if($Data -eq $null) {
    'We have null objects'
}
