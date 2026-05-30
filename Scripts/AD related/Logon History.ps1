Param   ( 
 [string]$Computer = (Read-Host Remote computer name), 
 [string]$Days = (Read-Host How many days?)
        )
 $events = @() 
 $events += Get-WinEvent -ComputerName $Computer -FilterHashtable @{ 
    LogName='Security' 
    Id=@(529,4634,4647,4800,4801,4624,540) 
    StartTime=(Get-Date).AddDays(-$Days) 

} 
$events += Get-WinEvent -ComputerName $Computer -FilterHashtable @{ 
    LogName='System' 
    Id=@(7001,7002) 
    StartTime=(Get-Date).AddDays(-$Days) 
}


$type_lu = @{ 
    7001 = 'Logon' 
    7002 = 'Logoff' 
    4800 = 'Lock' 
    4801 = 'UnLock' 
    529  = 'Logon Failure' 
    540  = 'Successful Network Logon' 
    4634 = 'An account was logged off' 
    4624 = 'An account was successfully logged on' 
    4647 = 'User initiated logoff' 
    4608 = 'Windows is starting up' 
    4609 = 'Windows is shutting down'
} 

$ns = @{'ns'='http://schemas.microsoft.com/win/2004/08/events/event'}
$target_xpath = "//ns:Data[@Name='TargetUserName']" 
$usersid_xpath = "//ns:Data[@Name='UserSid']" 

If($events) { 
    $results = ForEach($event in $events) { 
    $xml = $event.ToXml() 
    Switch -Regex ($event.Id) { 
        '4...' { 
        $user = ( 
            Select-Xml -Content $xml -Namespace $ns -XPath $target_xpath 
        ).Node.'#text'
        Break
      } 
      '7...' { 
      $sid = ( 
        Select-Xml -Content $xml -Namespace $ns -XPath $usersid_xpath 
              ).Node.'#text' 
              $user = ( 
                New-Object -TypeName 'System.Security.Principal.SecurityIdentifier' -ArgumentList $sid 
              ).Translate([System.Security.Principal.NTAccount]).Value 
         Break 
     } 
} 
    New-Object -TypeName PSObject -Property @{
        Time = $event.TimeCreated 
        Id = $event.Id 
        Type = $type_lu[$event.Id] 
        User = $user 
        
     } 
} 
If($results) { 
    #$results 
    $Results | Sort Time -Descending | Out-GridView
             } 
}
<#Logon types possible: 

Logon Type- Description 

2- Interactive (logon at keyboard and screen of system) Windows 2000 records Terminal Services logon as this type rather than Type 10. 
3- Network (i.e. connection to shared folder on this computer from elsewhere on network or IIS logon - Never logged by 528 on W2k and forward. See event 540) 
4- Batch (i.e. scheduled task) 
5- Service (Service startup) 
7- Unlock (i.e. unnattended workstation with password protected screen saver) 
8- NetworkCleartext (Logon with credentials sent in the clear text. Most often indicates a logon to IIS with "basic authentication") 
9- NewCredentials 
10- RemoteInteractive (Terminal Services, Remote Desktop or Remote Assistance) 
11- CachedInteractive (logon with cached domain credentials such as when logging on to a laptop when away from the network) 
#>