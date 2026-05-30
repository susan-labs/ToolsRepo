# Folders below parent directories
    #Get-childitem E:\Common\ -Recurse -Directory -Exclude File |

# Folders and Files below parent directories
    #Get-childitem E:\Common\ -Recurse -Directory |

# Folders in parent directory    
    #Get-childitem E:\Common\ -Directory -Exclude File |

# Folders and Files in parent directory
    #Get-childitem E:\Common\ -Directory |
 

Get-ChildItem E:\Common\ -Directory -Exclude File |
    
    # Get the ACL (Access Control List) for each directory
    Get-Acl |
    % {
        $path = $_.Path
    
        # Process each access role
        $_.Access | % {
    
            # Create a custom object with properties for each access role
            New-Object PSObject -Property @{
            Folder      = $path.Replace("Microsoft.PowerShell.Core\FileSystem::", "")
            Access      = $_.FileSystemRights
            Control     = $_.AccessControlType
            User        = $_.IdentityReference
            Inheritance = $_.IsInherited
                                            }
                       }
       } |
    
# Filter to include only objects with inherited permissions
    ? { $_.Inheritance } |

# Filter to not include objects with inherited permissions
    #? {-not $_.Inheritance } |
    
    # Export the results to a CSV file
    Export-Csv c:\csvname-folder-inherited-true-ntfs-perms.csv -Force