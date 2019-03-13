$String = 'My name is Simon, I''m 12845 years old'

if($String -match '((\w+\s+){3}(?<name>\w+)), (I''m (?<age>\d+).*)') {
    $Matches
    $Matches.Age
}

$String -replace '((\w+\s+){3})\w+(, I''m )\d+(.*)','$1Sigge${3}32${4}'

# Ta bort första backslash på raden
'Cert:\temp\' -replace '(?<=^[^\\]+)\\'