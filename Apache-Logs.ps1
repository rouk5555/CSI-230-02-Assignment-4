function Get-Logs {
    param (
        [string]$Page,      # Page visited or referred from
        [string]$Code,      # HTTP code returned
        [string]$Browser    # Name of the web browser
    )

    # Read the log file and filter based on the given inputs
    $logs = Get-Content C:\xampp\apache\logs\access.log | 
            Select-String -Pattern "$Page" |
            Where-Object { $_ -match $Code -and $_ -match $Browser }

    # Regex for IP addresses, thanks again ChatGPT
    $regex = [regex] "\b(?:\d{1,3}\.){3}\d{1,3}\b"

    $ipsUnorganized = $regex.Matches($logs)

    # Store the IPs
    $ips = @()
    for($i = 0; $i -lt $ipsUnorganized.Count; $i++) {
        $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value }
    }

    # Return the unique IPs
    $ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
    $counts = $ipsoftens | Group-Object IP
    return $counts | Select-Object Count, Name
}