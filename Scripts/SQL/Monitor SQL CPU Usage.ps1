$serverName = $env:COMPUTERNAME
$Counters = @(
    "\\$serverName\Process(sqlservr*)\% User Time",
    "\\$serverName\Process(sqlservr*)\% Privileged Time",
    "\\$serverName\Processor(_Total)\% Processor Time"  # Total CPU usage for all processes
)

for ($i = 1; $i -le 30; $i++) {  # Runs 30 times
    Get-Counter -Counter $Counters | ForEach {
        $_.CounterSamples | ForEach {
            [pscustomobject]@{
                TimeStamp = $_.TimeStamp
                Counter   = $_.Path
                CPU_Usage = [Math]::Round($_.CookedValue, 2)  # Rounded to 2 decimal places
            }
        }
    }
    Start-Sleep -Seconds 2  # Waits before next sample
}