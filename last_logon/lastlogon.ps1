# Import the Active Directory module (if not already loaded)
Import-Module ActiveDirectory

Write-Host "Searching for ALL active users and their true Last Logon Date across all DCs..."

try {
    # Get all Domain Controllers
    $DomainControllers = Get-ADDomainController -Filter * | Select-Object -ExpandProperty HostName

    $results = @()

    # Get all active users (no SamAccountName filter)
    $usersToQuery = Get-ADUser -Filter * -Properties SamAccountName, Enabled, Name, DistinguishedName | Where-Object { $_.Enabled -eq $true }

    if ($usersToQuery) {
        foreach ($user in $usersToQuery) {
            $latestLogon = [DateTime]::FromFileTime(0) # Initialize with the earliest possible date (Jan 1, 1601)
            $userSamAccountName = $user.SamAccountName
            $userName = $user.Name

            Write-Host "  Processing user: $userName ($userSamAccountName)" # Uncomment for verbose progress

            foreach ($dc in $DomainControllers) {
                try {
                    # Query each DC for the 'lastLogon' attribute
                    $userOnDc = Get-ADUser -Identity $userSamAccountName -Server $dc -Properties lastLogon -ErrorAction SilentlyContinue

                    # Ensure lastLogon property exists and is not null/empty (e.g., if user never logged in on that DC)
                    if ($userOnDc -and $userOnDc.lastLogon -is [System.Int64] -and $userOnDc.lastLogon -ne 0) {
                        # Convert the FileTime value to a DateTime object
                        $currentLogon = [DateTime]::FromFileTime($userOnDc.lastLogon)

                        # Compare and keep the latest logon
                        if ($currentLogon -gt $latestLogon) {
                            $latestLogon = $currentLogon
                        }
                    }
                }
                catch {
                    Write-Warning "Could not query '$userSamAccountName' on DC '$dc'. Error: $($_.Exception.Message)"
                }
            }

            # Add to results if a valid logon date was found
            if ($latestLogon -ne [DateTime]::FromFileTime(0)) {
                $results += [PSCustomObject]@{
                    Name         = $userName
                    SamAccountName = $userSamAccountName
                    LastLogon    = $latestLogon
                }
            } else {
                $results += [PSCustomObject]@{
                    Name         = $userName
                    SamAccountName = $userSamAccountName
                    LastLogon    = "No logon recorded or could not be retrieved from any DC"
                }
            }
        }

        # Display the results
        $results | Sort-Object LastLogon -Descending | Format-Table -AutoSize

        # Optional: Export to CSV for further analysis if the list is long
        # $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        # $csvPath = "C:\Temp\AllActiveUsersLastLogon_$timestamp.csv" # Change path as needed
        # $results | Export-Csv -Path $csvPath -NoTypeInformation

        Write-Host "`nSearch complete."
        # Write-Host "Results also saved to: $csvPath" # Uncomment if exporting to CSV

    } else {
        Write-Host "No active users found in the domain."
    }
}
catch {
    Write-Error "An unhandled error occurred during script execution: $($_.Exception.Message)"
    Write-Warning "Ensure you have the Active Directory module installed and proper permissions."
}
