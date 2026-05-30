# Define the directory to start listing the structure
$directoryPath = "E:\Data"
$outputCsv = "C:\Wyscom\e-data-folder-structure-top-level.csv"

# Initialize an array to hold folder information
$folderList = @()

# Set the maximum depth level (0 = top level, 1 = second level, 2 = third level, etc.)
$maxDepth = 2  # Change this value to control the depth

# Use Try-Catch to handle errors like invalid characters or missing paths
try {
    # Recursively collect folder data
    $stack = @(@{Path = $directoryPath; Level = 0})  # Initialize stack with starting path and level
    while ($stack.Count -gt 0) {
        $currentItem = $stack[0]
        $stack = $stack[1..$stack.Count]  # Remove first element from stack
        $currentPath = $currentItem.Path
        $currentLevel = $currentItem.Level

        # Get all directories in the current path, but stop if the current level exceeds the max depth
        if ($currentLevel -le $maxDepth) {
            $folders = Get-ChildItem -Path $currentPath -Directory -ErrorAction SilentlyContinue

            foreach ($folder in $folders) {
                # Add folder information to the array
                $folderList += [pscustomobject]@{
                    FolderName = $folder.FullName
                    Level      = $currentLevel
                }
                
                # Push the current folder to the stack to explore further subdirectories
                $stack += @{Path = $folder.FullName; Level = $currentLevel + 1}
            }
        }
    }
} catch {
    Write-Host "Error processing path: $directoryPath. $_"
}

# Export the folder structure to a CSV file
$folderList | Export-Csv -Path $outputCsv -NoTypeInformation