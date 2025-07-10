# Import the Active Directory module (if not already loaded)
Import-Module ActiveDirectory

Write-Host "Searching for all active computers and their Operating System details..."

try {
    # Get all computer objects that are enabled (active)
    # Properties: Name (computer name), OperatingSystem, OperatingSystemServicePack (optional, for more detail)
    $ActiveComputers = Get-ADComputer -Filter { Enabled -eq $true } -Properties Name, OperatingSystem, OperatingSystemServicePack

    if ($ActiveComputers) {
        # Select and format the desired properties
        $ActiveComputers | Select-Object Name, OperatingSystem, OperatingSystemServicePack | Sort-Object Name | Format-Table -AutoSize

        # Optional: Export to CSV for further analysis
        # $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        # $csvPath = "C:\Temp\ActiveComputersOS_$timestamp.csv" # Change path as needed
        # $ActiveComputers | Select-Object Name, OperatingSystem, OperatingSystemServicePack | Export-Csv -Path $csvPath -NoTypeInformation
        # Write-Host "`nResults also saved to: $csvPath" # Uncomment if exporting to CSV

        Write-Host "`nSearch complete. Found $($ActiveComputers.Count) active computers."
    } else {
        Write-Host "No active computers found in the Active Directory domain."
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    Write-Warning "Ensure you have the Active Directory module installed and proper permissions to read computer objects."
}
