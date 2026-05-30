Set-ExecutionPolicy -ExecutionPolicy Bypass
$Credentials = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $Credentials -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking

Get-Mailbox -ResultSize Unlimited | % { Get-InboxRule -Mailbox $_.DistinguishedName | Select Enabled,Name,Priority,From,SentTo,CopyToFolder,DeleteMessage,ForwardTo,MarkAsRead,MoveToFolder,RedirectTo,@{Expression={$_.SendTextMessageNotificationTo};Label="SendTextMessageNotificationTo"},MailboxOwnerId } | Export-Csv C:\WYSCOM\BB_Rules.csv -NoTypeInformation
Get-mailbox | select DisplayName,ForwardingAddress | where {$_.ForwardingAddress -ne $Null} | Export-Csv C:\WYSCOM\HTI_Forwarding.csv -NoTypeInformation