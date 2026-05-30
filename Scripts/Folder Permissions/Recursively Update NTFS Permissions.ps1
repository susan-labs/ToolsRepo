# Define variables for the main folder, subfolders, and groups
$subFolders = @("8.3.1_Contract Variations", "8.3.2_Meeting Minutes", "8.3.3_Progress Claims", "8.3.4_Request for Information", "8.3.5_Review & Approvals", "8.3.6_Site Inspection Reports")
$groups = @("sellick\Project_Team_Member", "sellick\Project_Team_Leader")
$permissionGroup1 = [System.Security.AccessControl.FileSystemRights]::FullControl
$permissionGroup2 = [System.Security.AccessControl.FileSystemRights]::FullControl

## Get a list of all top-level Folders
$mainFolder = "F:\Data\Projects\2024\*\08_Construction Management\8.3_STR"
#$mainFolder = "C:\WYSCOM\Job Script Test\*\"
$topLevelFolders = Get-ChildItem $mainFolder -Directory

# Log file path
$logFilePath = "C:\WYSCOM\8_0_Log.txt"

# Function to log messages
function Write-Log {
    param (
        [string]$Message
    )
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $LogMessage = "$Timestamp - $Message"
    $LogMessage | Out-File -FilePath $logFilePath -Append
}

# Loop through the top-level Folders and set permissions
foreach ($topLevelFolder in $topLevelFolders) {
    # Get the directory security of the top-level folder
    $topLevelFolderSecurity = Get-Acl $topLevelFolder.FullName
    Write-Log "Processing top-level folder: $($topLevelFolder.FullName)"

    # Loop through the subfolders and set permissions
    foreach ($subFolder in $subFolders) {
        $path = Join-Path $topLevelFolder.FullName $subFolder

        # Check if the directory exists before performing operations
        if (Test-Path $path -PathType Container) {
            Write-Log "Processing subfolder: $path"
            # Get the directory security
            $directorySecurity = Get-Acl $path

            # Remove existing permissions for specified groups
            foreach ($group in $groups) {
                $accessRules = $directorySecurity.Access | Where-Object { $_.IdentityReference.Value -eq $group }
                foreach ($accessRule in $accessRules) {
                    $directorySecurity.RemoveAccessRule($accessRule)
                    Write-Log "Removed existing access rule for group: $group"
                }
            }

            # Create a new permission rule for subfolders and files only
            foreach ($group in $groups) {
                if ($group -eq "sellick\Project_Team_Member") {
                    $permissionRule = New-Object System.Security.AccessControl.FileSystemAccessRule($group, $permissionGroup1, "ContainerInherit, ObjectInherit", "InheritOnly", "Allow")
                }
                else {
                    $permissionRule = New-Object System.Security.AccessControl.FileSystemAccessRule($group, $permissionGroup2, "ContainerInherit, ObjectInherit", "InheritOnly", "Allow")
                }

                # Add the permission rule to the directory security
                $directorySecurity.AddAccessRule($permissionRule)
                Write-Log "Added permission for group: $group"
            }

            # Disable access rule protection
            $directorySecurity.SetAccessRuleProtection($false, $true)

            # Set the modified directory security back to the directory
            Set-Acl $path $directorySecurity

            # Log the success message
            Write-Log "Directory security updated successfully for: $path"
        } else {
            Write-Log "Directory does not exist: $path"
        }
    }

    # Set the modified directory security back to the top-level folder
    Set-Acl $topLevelFolder.FullName $topLevelFolderSecurity
}

Write-Log "Script execution completed."
