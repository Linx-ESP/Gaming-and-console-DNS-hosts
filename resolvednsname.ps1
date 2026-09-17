[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$DomainList,

    [Parameter(Mandatory = $true)]
    [string]$DnsServer,

    [Parameter(Mandatory = $true)]
    [string]$OutputFile,

    [Parameter(Mandatory = $false)]
    [ValidateSet('Hosts', 'AdGuard')]
    [string]$OutputFormat = 'Hosts'
)

if (-not (Test-Path -LiteralPath $DomainList)) {
    throw "Domain list not found: $DomainList"
}

$results = foreach ($domain in Get-Content -LiteralPath $DomainList) {
    $domain = $domain.Trim()

    # Skip blank lines and comments
    if ([string]::IsNullOrWhiteSpace($domain) -or $domain.StartsWith('#')) {
        continue
    }

    Write-Host "Resolving $domain using DNS server $DnsServer ..."

    try {
        $answers = Resolve-DnsName `
            -Name $domain `
            -Type A `
            -Server $DnsServer `
            -DnsOnly `
            -ErrorAction Stop |
            Where-Object { $_.Type -eq 'A' }

        foreach ($answer in $answers) {
            $ipAddress = $answer.IPAddress

            if ($OutputFormat -eq 'AdGuard') {
                # AdGuard Home DNS rewrite format
                "||{0}^`$dnsrewrite=NOERROR;A;{1}" -f $domain, $ipAddress
            }
            else {
                # Hosts-file format
                "{0}`t{1}" -f $ipAddress, $domain
            }
        }
    }
    catch {
        Write-Warning "Failed to resolve ${domain}: $($_.Exception.Message)"
    }
}

$header = if ($OutputFormat -eq 'AdGuard') {
    @(
        "# Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        "# DNS server: $DnsServer"
        "# Format: AdGuard Home"
        "# Source: $DomainList"
        ""
    )
}
else {
    @(
        "# Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        "# DNS server: $DnsServer"
        "# Format: Hosts"
        "# Source: $DomainList"
        ""
    )
}

$header + ($results | Sort-Object -Unique) |
    Set-Content -LiteralPath $OutputFile -Encoding ASCII

Write-Host "$OutputFormat file written to: $OutputFile"