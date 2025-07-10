# Display all icons in the notification area, rather than hiding it in the overflow area.

# This script is intended as part of a User Login Script.
# It modifies the HKCU settings for the currently logged-on user.

$RegistryPath = 'HKCU:\Control Panel\NotifyIconSettings'
$Name = 'IsPromoted'
$Value = 1

if (Test-Path -Path $RegistryPath -PathType Container) {
    Get-ChildItem -Path $RegistryPath -Recurse | ForEach-Object {
        New-ItemProperty -Path $_.PSPath -Name $Name -Value $Value -PropertyType DWORD -Force
    }
}
