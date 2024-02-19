# PowershellAutomations
Useful powershell scripts

Written for use in AD or AzureAD environments. No guarantees they will work. 

## MFA

### GetMFAStatusFromGroup
Simple script written to get the MFA status and export to a CSV of anyone who is in a certain GroupID. Depends on MSOnline module

## Passwords

### BulkPasswordExpire
Expires local AD passwords of all users in the column name "UserName" with "Compromised" set to "Yes". This is modeled after the export from Defender 365 for Attack Simulation Training. 