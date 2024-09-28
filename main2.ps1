. (Join-Path $PSScriptRoot Apache-Logs.ps1)
. (Join-Path $PSScriptRoot Log-Parser.ps1)

clear

$result = Get-Logs -Page 'index.html' -Code '404' -Browser 'Chrome'
$result

$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap