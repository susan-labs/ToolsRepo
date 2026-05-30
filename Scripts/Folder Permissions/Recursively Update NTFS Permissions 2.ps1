# Define variables
#$folderPath = "C:\WYSCOM\Job Script Test\*\02_Sellick Documents"
$folderPath = "F:\Data\Projects\2024\*\02_Sellick Documents"
$securityGroup = "Sellick\Project_Team_Leader"
$logFile = "C:\WYSCOM\Log - Update 2.1_CIV Permissions - Project_Team_Leader.txt"

# Function to add permissions recursively
function Add-Permissions {
    param (
        [string]$folderPath,
        [string]$securityGroup,
        [string]$logFile
    )
    
    # Get all directories recursively
    $directories = Get-ChildItem -Path $folderPath -Directory -Recurse | Where-Object { $_.Name -eq "2.1_CIV" }
    
    # Loop through each directory and apply ACL
    foreach ($directory in $directories) {
        try {
            $acl = Get-Acl -Path $directory.FullName
            Write-Host "ACL obtained for $($directory.FullName)"
        } catch {
            Write-Host "Failed to get ACL for $($directory.FullName): $_"
            continue
        }
        
        # Add permission for the security group
        try {
            $permission = New-Object System.Security.AccessControl.FileSystemAccessRule($securityGroup, "Modify", "ContainerInherit, ObjectInherit", "None", "Allow")
            $acl.AddAccessRule($permission)
            Write-Host "Permission added for $($securityGroup) on $($directory.FullName)"
        } catch {
            Write-Host "Failed to set permission for $($securityGroup) on $($directory.FullName): $_"
            continue
        }
        
        # Apply ACL to the directory
        try {
            Set-Acl -Path $directory.FullName -AclObject $acl
            Write-Host "ACL applied to $($directory.FullName)"
        } catch {
            Write-Host "Failed to apply ACL to $($directory.FullName): $_"
            continue
        }
        
        # Log the action
        $logEntry = "$(Get-Date) - Added permission for $securityGroup to $($directory.FullName)"
        try {
            Add-Content -Path $logFile -Value $logEntry
            Write-Host "Log entry added to $($logFile)"
        } catch {
            Write-Host "Failed to write log entry to $($logFile): $_"
            continue
        }
    }
}

# Add permissions recursively
Add-Permissions -folderPath $folderPath -securityGroup $securityGroup -logFile $logFile
