# Define the folder containing the CSV files
$folderPath = "C:\PATH\TO\CSV\FILES\"

# Get all CSV files in the folder
$csvFiles = Get-ChildItem -Path $folderPath -Filter *.csv

# Define the path for the combined CSV file
$combinedCsvPath = "C:\save\location\combined.csv"

# Initialize an array to hold the combined data
$combinedData = @()

foreach ($file in $csvFiles) {
    Write-Output "Processing file: $($file.FullName)"
    
    # Import the CSV file
    $csvData = Import-Csv -Path $file.FullName
    
    # Add the data to the combined array
    $combinedData += $csvData
}

# Export the combined data to a new CSV file
$combinedData | Export-Csv -Path $combinedCsvPath -NoTypeInformation
Write-Output "Saved combined CSV to $combinedCsvPath"