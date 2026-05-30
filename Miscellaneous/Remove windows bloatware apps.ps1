# This will remove the default windows store applications

# Command to list applications:
#   Get-AppxPackage -AllUsers | Select-Object Name

# Command to remove applications
#   Get-AppXPackage -AllUsers PACKAGENAME | Remove-AppXPackage -AllUsers #

# Missing applications
#   LinkedIn
#   Microsoft Clipchamp
#   Spotify
#   Windows Mail


# Remove default Windows Store applications
Get-AppXPackage -AllUsers Clipchamp.Clipchamp | Remove-AppXPackage -AllUsers				        #Clipchamp	
Get-AppXPackage -AllUsers DropboxInc.Dropbox | Remove-AppXPackage -AllUsers				            #Dropbox - UWP
Get-AppXPackage -AllUsers Microsoft.BingNews | Remove-AppXPackage -AllUsers				            #Bing News
Get-AppXPackage -AllUsers Microsoft.BingSearch | Remove-AppXPackage -AllUsers				        #Bing Search
Get-AppXPackage -AllUsers Microsoft.BingWeather | Remove-AppXPackage -AllUsers				        #Bing Weather
Get-AppXPackage -AllUsers Microsoft.GetHelp | Remove-AppXPackage -AllUsers				            #Get Help
Get-AppXPackage -AllUsers Microsoft.Getstarted | Remove-AppXPackage -AllUsers				        #Get Started
Get-AppXPackage -AllUsers Microsoft.MicrosoftOfficeHub | Remove-AppXPackage -AllUsers			    #Microsoft Office Hub
Get-AppXPackage -AllUsers Microsoft.MicrosoftSolitaireCollection | Remove-AppXPackage -AllUsers		#Microsoft Solitaire Collection
Get-AppXPackage -AllUsers Microsoft.MicrosoftStickyNotes | Remove-AppXPackage -AllUsers			    #Microsoft Sticky Notes
Get-AppXPackage -AllUsers Microsoft.OutlookForWindows | Remove-AppXPackage -AllUsers			    #Outlook - UWP
Get-AppXPackage -AllUsers Microsoft.People | Remove-AppXPackage -AllUsers				            #People
Get-AppXPackage -AllUsers Microsoft.PowerAutomateDesktop | Remove-AppXPackage -AllUsers			    #Power Automate Desktop - UWP
Get-AppXPackage -AllUsers Microsoft.Todos | Remove-AppXPackage -AllUsers				            #Microsoft To Do
Get-AppXPackage -AllUsers Microsoft.WindowsAlarms | Remove-AppXPackage -AllUsers			        #Windows Alarms
Get-AppXPackage -AllUsers Microsoft.WindowsFeedbackHub | Remove-AppXPackage -AllUsers			    #Windows Feedback Hub
Get-AppXPackage -AllUsers Microsoft.WindowsMaps | Remove-AppXPackage -AllUsers				        #Windows Maps
Get-AppXPackage -AllUsers Microsoft.WindowsSoundRecorder | Remove-AppXPackage -AllUsers			    #Windows Sound Recorder
Get-AppXPackage -AllUsers Microsoft.YourPhone | Remove-AppXPackage -AllUsers				        #Your Phone
Get-AppXPackage -AllUsers Microsoft.ZuneMusic | Remove-AppXPackage -AllUsers				        #Zune Music
Get-AppXPackage -AllUsers Microsoft.ZuneVideo | Remove-AppXPackage -AllUsers				        #Zune Video
Get-AppXPackage -AllUsers MicrosoftCorporationII.MicrosoftFamily | Remove-AppXPackage -AllUsers     #Microsoft Family
Get-AppXPackage -AllUsers MicrosoftCorporationII.QuickAssist | Remove-AppXPackage -AllUsers 		#Quick Assist
Get-AppXPackage -AllUsers MicrosoftTeams | Remove-AppXPackage -AllUsers 				            #Microsoft Teams - UWP
Get-AppXPackage -AllUsers microsoft.windowscommunicationsapps | Remove-AppXPackage -AllUsers 		#Windows Mail
Get-AppXPackage -AllUsers Microsoft.RemoteDesktop | Remove-AppXPackage -AllUsers                    #Remote Desktop - UWP
Get-AppXPackage -AllUsers Microsoft.Office.OneNote | Remove-AppXPackage -AllUsers                   #OneNote - UWP
Get-AppXPackage -AllUsers Microsoft.Microsoft3DViewer | Remove-AppXPackage -AllUsers                #3D Viewer
Get-AppXPackage -AllUsers Microsoft.MixedReality.Portal | Remove-AppXPackage -AllUsers              #Mixed Reality Portal
Get-AppXPackage -AllUsers Microsoft.549981C3F5F10 | Remove-AppXPackage -AllUsers                    #Cortana
Get-AppXPackage -AllUsers Microsoft.SkypeApp | Remove-AppXPackage -AllUsers                         #Skype - UWP
Get-AppxPackage -AllUsers Microsoft.MSPaint | Remove-AppXPackage -AllUsers                          #Paint3D
Get-AppxPackage -AllUsers Microsoft.OneConnect | Remove-AppXPackage -AllUsers                       #Mobile Plans - UWP
Get-AppXPackage -AllUsers Microsoft.GamingApp | Remove-AppXPackage -AllUsers                        #Xbox Related
Get-AppXPackage -AllUsers Microsoft.XboxApp | Remove-AppXPackage -AllUsers                          #Xbox Related