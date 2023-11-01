# Dependencies
Import-Module MSOnline

# Connect with prompt if necessary
Get-MsolDomain -ErrorAction SilentlyContinue > $null
if ($?) {
    Write-Output "Using previously connected MSOL credential"
}
else {
    Connect-MsolService
}

# Get all licensed users
$groupMembers = Get-AzureADGroupMember -ObjectId "XXXX" -All $true

$exportData = foreach ($member in $groupMembers) {
    # Check member is user
    if ($member.ObjectType -eq "User") {
        $user = Get-MsolUser -ObjectId $member.ObjectId | Select-Object -Property UserPrincipalName,DisplayName,FirstName,LastName,StrongAuthenticationMethods
        
        [PSCustomObject]@{
            fname = $user.FirstName
            lname = $user.LastName
            upn = $user.UserPrincipalName
            mfa = $user.StrongAuthenticationMethods.Count
        }
    }
}

# $exportData
Write-Output "Saving to CSV"
$exportData | Export-CSV ".\mfa_status.csv" -NoTypeInformation