Connect-SPOService -Url https://cconstructions-admin.sharepoint.com/

# Specify the site URL
$siteUrl = "https://cconstructions.sharepoint.com/sites/GRP_ClassicConstructions_Exec"

# Initialize an empty array to store permission data
$permissionData = @()

# Get the site details
$site = Get-SPOSite -Identity $siteUrl -Detailed

# Get all files and folders within the site
$files = Get-SPOFile -Site $site.Url -Recursive
$folders = Get-SPOFolder -Site $site.Url -Recursive

# Combine files and folders into a single collection
$allItems = $files + $folders

# Iterate through each item (file or folder)
foreach ($item in $allItems) {
    # Determine the type of the item (File or Folder)
    if ($item.FileSystemObjectType -eq "File") {
        $itemType = "File"
        $itemName = $item.Name
    } else {
        $itemType = "Folder"
        $itemName = $item.Folder.Name
    }

    # Get permissions for the item
    $permissions = Get-SPOUser -Site $site.Url -Identity $item.UniqueId -Limit All

    # Create a custom object for each permission
    foreach ($permission in $permissions) {
        $permissionObject = New-Object PSObject -Property @{
            "Item Type" = $itemType
            "Item Name" = $itemName
            "User or Group" = $permission.DisplayName
            "Login Name" = $permission.LoginName
            "Roles" = $permission.Roles -join ", "
        }
        $permissionData += $permissionObject
    }
}

# Export the permissionData array to CSV
$csvOutputPath = "C:\temp\permissions_files_folders.csv"  # Specify your desired export path and filename
$permissionData | Export-Csv -Path $csvOutputPath -NoTypeInformation

Write-Output "Permissions for files and folders exported to: $csvOutputPath"