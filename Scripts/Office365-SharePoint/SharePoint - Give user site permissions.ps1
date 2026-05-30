# Connect to SharePoint Online
#$tenant = "lnp.org.au"
#$user = "Nick Frizzo"

# Connect to SharePoint Online Admin Center
#Connect-SPOService -Url https://$tenant-admin.sharepoint.com

# Define the list of sites
$sites = @(
	"https://liberalnationalparty.sharepoint.com/sites/BLAIR_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/BONNER_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/bowman_campaign",
	"https://liberalnationalparty.sharepoint.com/sites/BRISBANE_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/CAPRICORNIA_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/DAWSON_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/DICKSON_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/FADDEN_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/FAIRFAX_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/FISHER_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/FLYNN_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/FORDE_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/GRIFFITH_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/GROOM_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/HERBERT_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/HINKLER_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/KENNEDY_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/LEICHHARDT_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/LILLEY_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/LONGMAN_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/MARANOA_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/MCPHERSON_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/MONCRIEFF_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/MORETON_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/OXLEY_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/PETRIE_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/RYAN_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/team_schrinner",
	"https://liberalnationalparty.sharepoint.com/sites/WIDEBAY_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/WRIGHT_CAMPAIGN",
	"https://liberalnationalparty.sharepoint.com/sites/BlairCampaign89",
	"https://liberalnationalparty.sharepoint.com/sites/BonnerCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/BrisbaneCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/bowman_campaign",
	"https://liberalnationalparty.sharepoint.com/sites/BowmanCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/BowmanCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/Dawson",
	"https://liberalnationalparty.sharepoint.com/sites/FaddenCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/FairfaxCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/FisherCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/FlynnCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/FordeCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/FordeCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/GriffithCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/HerbertCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/HinklerCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/KennedyCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/LeichhardtCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/LilleyCampaign13",
	"https://liberalnationalparty.sharepoint.com/sites/LongmanCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/MaranoaCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/MoretonCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/MoncrieffCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/MoretonCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/OxleyCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/PetrieCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/RyanCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/TeamSchrinner",
	"https://liberalnationalparty.sharepoint.com/sites/WideBayCampaign",
	"https://liberalnationalparty.sharepoint.com/sites/WrightCampaign"
)

# Loop through each site and set the user as Site Collection Administrator
foreach ($site in $sites) {
    Set-SPOUser -Site $site -LoginName Nick.Frizzo@lnp.org.au -IsSiteCollectionAdmin $true
    Write-Host "Set $user@$tenant.com as Site Collection Administrator for $site"
}

# Disconnect from SharePoint Online
Disconnect-SPOService