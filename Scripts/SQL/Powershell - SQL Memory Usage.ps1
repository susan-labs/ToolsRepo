$serverName = $env:COMPUTERNAME
$Counters = @(
    "\\$serverName\Memory\Available Bytes",   # Free RAM
    "\\$serverName\Process(sqlservr*)\Working Set",  # SQL Server RAM usage
    "\\$serverName\Process(sqlservr*)\Private Bytes" # SQL Server committed memory
)

Get-Counter -Counter $Counters -MaxSamples 30 | ForEach {
    $_.CounterSamples | ForEach {
        [pscustomobject]@{
            TimeStamp      = $_.TimeStamp
            Counter        = $_.Path
            ValueGB        = [math]::Round($_.CookedValue / 1GB, 3)  # Convert bytes to GB
        }
        Start-Sleep -s 2
    }
}