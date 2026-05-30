# Define the output file for Teams structure
$outputCsv = "C:\ps-script-outputs\teams-structure.csv"

# Initialize an array to store team structure information
$teamsList = @()

# Get all Teams
$teams = Get-Team

# Log the number of teams found
Write-Host "Found $($teams.Count) teams."

# Loop through each team
foreach ($team in $teams) {
    # Log the current team being processed
    Write-Host "Processing team: $($team.DisplayName)"

    # Get the channels in the team
    $channels = Get-TeamChannel -GroupId $team.GroupId

    foreach ($channel in $channels) {
        # Add team and channel details to the array
        $teamsList += [pscustomobject]@{
            TeamName    = $team.DisplayName
            ChannelName = $channel.DisplayName
        }
    }

    # Optional: Add a delay to avoid hitting API limits
    Start-Sleep -Milliseconds 500
}

# Export the teams structure to CSV
$teamsList | Export-Csv -Path $outputCsv -NoTypeInformation

Write-Host "Export complete: $outputCsv"
