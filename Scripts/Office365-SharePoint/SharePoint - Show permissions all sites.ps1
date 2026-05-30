# Connect to SharePoint Online
#adminUrl = "https://yourtenant-admin.sharepoint.com"
#adminUsername = "admin@yourtenant.onmicrosoft.com"
$csvOutputPath = "C:\temp\permissions.csv"  # Specify your desired export path and filename
#$credential = Get-Credential -UserName $adminUsername -Message "Enter your password"
#Connect-SPOService -Url https://liberalnationalparty-admin.sharepoint.com/

# Initialize an empty array to store permission data
$permissionData = @()

# Get all site collections
$siteCollections = Get-SPOSite -Limit All

# Iterate through each site collection
foreach ($siteCollection in $siteCollections) {
    Write-Output "Site Collection: $($siteCollection.Url)"
    
    # Get all sites in the site collection
    $sites = Get-SPOSite -Identity $siteCollection.Url -Detailed -Limit All
    
    # Iterate through each site
    foreach ($site in $sites) {
        Write-Output "  Site: $($site.Url)"
        
        # Get all users and groups with permissions on the site
        $permissions = Get-SPOUser -Site $site.Url -Limit All
        
        # Iterate through each permission
        foreach ($permission in $permissions) {
            # Create a custom object for each permission
            $permissionObject = New-Object PSObject -Property @{
                "Site Collection" = $siteCollection.Url
                "Site" = $site.Url
                "User or Group" = $permission.DisplayName
                "Login Name" = $permission.LoginName
                "Roles" = $permission.Roles -join ", "  # Convert roles array to comma-separated string
            }
            
            # Add the object to the permissionData array
            $permissionData += $permissionObject
        }
    }
}

# Export the permissionData array to CSV
$permissionData | Export-Csv -Path $csvOutputPath -NoTypeInformation

Write-Output "Permissions exported to: $csvOutputPath"