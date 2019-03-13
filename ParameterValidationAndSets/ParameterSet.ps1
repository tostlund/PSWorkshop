function Invoke-BrottsplatsAPI {
    [CmdletBinding(DefaultParameterSetName='MultipleEvents')]
    param (
        # Brottsplats API URL
        [Parameter(DontShow)]
        [string]
        $URL = 'https://brottsplatskartan.se/api/',

        # Typ av brott
        [Parameter(ParameterSetName='MultipleEvents')]
        [ValidateSet("Inbrott", "Brand", "Trafikolycka", "Stöld/inbrott", "Skadegörelse", "Rattfylleri")]
        [string]
        $CrimeType,

        # Id
        [Parameter(ParameterSetName='SingleEvent', Mandatory)]
        [int64]
        $Id,

        # Open Browser - Exempel 97346
        [Parameter(ParameterSetName='SingleEvent')]
        [switch]
        $OpenWithBrowser
    )
    
    begin {
        Write-Verbose "Will now interact with the Brottsplats API."
    }
    
    process {
        if ($PSBoundParameters.ContainsKey('CrimeType')) {
            $Brott = Invoke-RestMethod -Method GET -UseBasicParsing -Uri "$URL`events/?type=$Crimetype"
        } elseif ($PSBoundParameters.ContainsKey('Id')) {
            try {   
                $Brott = Invoke-RestMethod -Method GET -UseBasicParsing -Uri "$URL`event/$id"
            } catch [System.Net.WebException] {
                throw
            }
        } else {
            $Brott = Invoke-RestMethod -Method GET -UseBasicParsing -Uri "$URL`events/"
        }
        
        if ($OpenWithBrowser.IsPresent -and $PSBoundParameters.ContainsKey('Id')) {
            $Brott.data | Select-object Id, description, parsed_title, parsed_content, permalink
            $IE = new-object -com internetexplorer.application
            $IE.navigate2("$($Brott.data.permalink)")
            $IE.visible=$true
        } else {
            $Brott.data | Select-object Id, title_type, title_location, description, content
        }
    }
    
    end {
        
    }
}
