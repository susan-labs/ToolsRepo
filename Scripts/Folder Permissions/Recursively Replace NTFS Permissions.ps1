# Define parent folder and specific subfolder name
$parentFolder = "C:\WYSCOM\Job Script Test\"
$subfolderName = "2.1_CIV"
#$projectTeamLeaderGroup = "SELLICK\Project_Team_Leader"
$projectTeamMemberGroup = "SELLICK\Project_Team_Member"
$logfile = "C:\WYSCOM\Logggg.txt"

# Get all subfolders matching the wildcard pattern
$subfolders = Get-ChildItem -Path $parentFolder -Directory -Recurse

# Loop through subfolders
foreach ($folder in $subfolders) {
    # Construct the specific subfolder path
    $specificSubfolder = Join-Path -Path $folder.FullName -ChildPath $subfolderName

    # Check if the specific subfolder exists
    if (Test-Path $specificSubfolder -PathType Container) {
         Retrieve existing permissions
        $acl = Get-Acl -Path $specificSubfolder

        # Remove existing permissions for Project_Team_Leader group
        $acl.Access | Where-Object { $_.IdentityReference.Value -eq $projectTeamLeaderGroup } | ForEach-Object {
            $acl.RemoveAccessRule($_)
        }

        # Remove existing permissions for Project_Team_Member group
        $acl.Access | Where-Object { $_.IdentityReference.Value -eq $projectTeamMemberGroup } | ForEach-Object {
            $acl.RemoveAccessRule($_)
        }

        # Capture existing inherited permissions
        $inheritance = $acl.GetAccessRules($true, $true, [System.Security.Principal.SecurityIdentifier])

        # Disable inheritance
        $acl.SetAccessRuleProtection($true, $false)

        # Re-add the inherited permissions
        foreach ($rule in $inheritance) {
            $acl.AddAccessRule($rule)
        }

        # Add permissions for Project_Team_Leader group

        #$leaderRule = New-Object System.Security.AccessControl.FileSystemAccessRule($projectTeamLeaderGroup, "Read", "ContainerInherit, ObjectInherit", "None", "Allow")
        $acl.AddAccessRule($leaderRule)

        #$leaderRule = New-Object System.Security.AccessControl.FileSystemAccessRule($projectTeamLeaderGroup, "Write", "ContainerInherit, ObjectInherit", "None", "Allow")
        $acl.AddAccessRule($leaderRule)

        #$leaderRule = New-Object System.Security.AccessControl.FileSystemAccessRule($projectTeamLeaderGroup, "Execute", "ContainerInherit, ObjectInherit", "None", "Allow")
        $acl.AddAccessRule($leaderRule)
        
        # Add permissions for Project_Team_Member group

        $memberRule = New-Object System.Security.AccessControl.FileSystemAccessRule($projectTeamMemberGroup, "Read", "ContainerInherit, ObjectInherit", "None", "Allow")
        $acl.AddAccessRule($memberRule)

        $memberRule = New-Object System.Security.AccessControl.FileSystemAccessRule($projectTeamMemberGroup, "Write", "ContainerInherit, ObjectInherit", "None", "Allow")
        $acl.AddAccessRule($memberRule)

        $memberRule = New-Object System.Security.AccessControl.FileSystemAccessRule($projectTeamMemberGroup, "Execute", "ContainerInherit, ObjectInherit", "None", "Allow")
        $acl.AddAccessRule($memberRule)

        # Apply modified ACL to the subfolder
        Set-Acl -Path $specificSubfolder -AclObject $acl

        # Log the changes
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $logEntry = "Permissions modified for $specificSubfolder at $timestamp"
        Add-Content -Path $logfile -Value $logEntry
    #}
#}