<#
.\SPOScript-DocumentListItems.ps1
#> 

Install-Module SharePointPnPPowerShellOnline
$siteUrl  = "https://jhinshawkci.sharepoint.com"  # This is also the Credential, as long as it exists as a generic credential within your windows environment
$listId = "List Name, ID, or Relative URL"

# Function to display field values of a list
function DocumentListItems($TenantUrl) {
    Connect-PnPOnline -Url $TenantUrl -Credentials $TenantUrl
    $List = Get-PnPList -Identity $listId
    $ListItems = (Get-PnPListItem -List $List).FieldValues
    foreach ($listItem in $ListItems) {
        Write-Host $listItem
    }
}

# Return sites - call function
Write-Host "`t> Running Functions..." -ForegroundColor DarkYellow
$functionProduct  = DocumentListItems -TenantUrl $siteUrl

Write-Host "`n`tComplete!`n" -ForegroundColor Green
[console]::beep(250,500)
