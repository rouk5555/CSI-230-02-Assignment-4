. (Join-Path $PSScriptRoot Apache-Logs.ps1)

clear

$result = Get-Logs -Page 'index.html' -Code '404' -Browser 'Chrome'
$result