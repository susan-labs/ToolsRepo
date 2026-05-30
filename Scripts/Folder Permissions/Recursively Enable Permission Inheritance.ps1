# Might be broken

# Set the folder path
$folderPath = "C:\WYSCOM\Job Script Test\*\02_Sellick Documents\2.1_CIV"

# Get the folder objects
$folders = Get-ChildItem -Path $folderPath -Directory

# Loop through each folder
foreach ($folder in $folders) {
    # Enable inheritance
    $acl = Get-Acl -Path $folder.FullName
    $acl.SetAccessRuleProtection($false, $true)
    Set-Acl -Path $folder.FullName -AclObject $acl
    Write-Output "Inheritance enabled for $($folder.FullName)"
}