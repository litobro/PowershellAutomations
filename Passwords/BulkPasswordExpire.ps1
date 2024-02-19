Import-Csv -Path ".\compromised-users.csv" | ForEach-Object {
    if($_.Compromised -eq "Yes") {
        $userName = $_.UserName
        Write-Host "$($userName) was compromised... Enforcing password reset now"
        $user = Get-ADUser -Filter "Name -eq '$($_.UserName)'"
        Set-ADUser -Identity $user -ChangePasswordAtLogon $true
    }
}