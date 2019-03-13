@{
    Path = "DemoModule2.psd1"
    OutputDirectory = "..\bin\DemoModule2"
    Prefix = '.\_PrefixCode.ps1'
    SourceDirectories = 'Classes','Private','Public'
    PublicFilter = 'Public\*.ps1'
    VersionedOutputDirectory = $true
}
