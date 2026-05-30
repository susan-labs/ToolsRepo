# Download MSIX package for new teams
# https://go.microsoft.com/fwlink/?linkid=2196106

# Specify the location for MSTeams-x64.msix
powershell.exe -ExecutionPolicy bypass -command "&{ Add-AppxProvisionedPackage -Online -PackagePath .\MSTeams-x64.msix -SkipLicense }" 