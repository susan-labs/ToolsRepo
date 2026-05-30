# https://liberalnationalparty-admin.sharepoint.com
# Nick.Frizzo@lnp.org.au




# Load SharePoint Online Management Shell
Import-Module "Microsoft.Online.SharePoint.PowerShell" -ErrorAction Stop

# Define parameters
$adminUrl = "https://cconstructions-admin.sharepoint.com/"
$userToCheck = "dcarey@htigroup.com.au"

# Connect to SharePoint Online
Connect-SPOService -Url $adminUrl

# Function to get site collections
function Get-SiteCollections {
    return Get-SPOSite -Limit All
}

# Function to get user permissions on a given site
function Get-UserPermissions {
    param (
        [string]$siteUrl,
        [string]$userToCheck
    )

    # Load the web
    $web = $context.Web
    $context.Load($web)
    $context.ExecuteQuery()

    # Get the user
    $user = $web.SiteUsers.GetByLoginName($userToCheck)
    $context.Load($user)
    $context.ExecuteQuery()

    # Get the user's role assignments
    $roleAssignments = $web.RoleAssignments
    $context.Load($roleAssignments)
    $context.ExecuteQuery()

    $permissions = @()
    foreach ($roleAssignment in $roleAssignments) {
        $context.Load($roleAssignment.RoleDefinitionBindings)
        $context.Load($roleAssignment.Member)
        $context.ExecuteQuery()

        if ($roleAssignment.Member.LoginName -eq $userToCheck) {
            $roles = $roleAssignment.RoleDefinitionBindings | ForEach-Object { $_.Name }
            $permissions += [PSCustomObject]@{
                SiteUrl = $siteUrl
                Roles = $roles -join ', '
            }
        }
    }

    if ($permissions.Count -eq 0) {
        $permissions += [PSCustomObject]@{
            SiteUrl = $siteUrl
            Roles = "No permissions found"
        }
    }

    return $permissions
}

# Main script execution
$siteCollections = Get-SiteCollections

foreach ($site in $siteCollections) {
    Write-Host "Checking permissions for site: $($site.Url)"
    $permissions = Get-UserPermissions -siteUrl $site.Url -userToCheck $userToCheck

    foreach ($perm in $permissions) {
        Write-Host "Site: $($perm.SiteUrl)"
        Write-Host "Roles: $($perm.Roles)"
    }
}