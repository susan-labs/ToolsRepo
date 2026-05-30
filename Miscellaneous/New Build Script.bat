
C:\Windows\System32\reg.exe ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 5 /f


C:\Windows\System32\reg.exe ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorUser /t REG_DWORD /d 3 /f


C:\Windows\System32\reg.exe ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 1 /f


C:\Windows\System32\reg.exe ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 0 /f


C:\Windows\system32\powercfg.exe -change -monitor-timeout-ac 0

C:\Windows\system32\powercfg.exe -change -monitor-timeout-dc 0

C:\Windows\system32\powercfg.exe -change -disk-timeout-ac 0

C:\Windows\system32\powercfg.exe -change -disk-timeout-dc 0

C:\Windows\system32\powercfg.exe -change -standby-timeout-ac 0

C:\Windows\system32\powercfg.exe -change -standby-timeout-dc 0

C:\Windows\system32\powercfg.exe -change -hibernate-timeout-ac 0

C:\Windows\system32\powercfg.exe -change -hibernate-timeout-dc 0

C:\Windows\System32\reg.exe ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f

C:\Windows\System32\reg.exe ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fAllowToGetHelp /t REG_DWORD /d 1 /f

C:\Windows\System32\reg.exe ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v DisableSR /t REG_DWORD /d 0 /f


netsh advfirewall firewall set rule group="Remote Desktop" new enable=Yes

netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes

netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes
