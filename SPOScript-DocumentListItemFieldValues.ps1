<#
.\SPOScript-DocumentListItemFieldValues.ps1
#> 

Install-Module SharePointPnPPowerShellOnline
$siteUrl  = "https://jhinshawkci.sharepoint.com"  # This is also the Credential, as long as it exists as a generic credential within your windows environment
$listId = "3632fe77-e755-4f08-945c-1d9bb839b11a"

function DocumentListItems($TenantUrl) {
    Connect-PnPOnline -Url $TenantUrl -Credentials $TenantUrl
    $List = Get-PnPList -Identity $listId
    $FieldValues = (Get-PnPListItem -List $List).FieldValues

    Write-Host "`t> Here is the List Item Title:" -ForegroundColor DarkYellow
    Write-Host $FieldValues[0].Title -ForegroundColor Cyan

    Write-Host "`t> Here is are the List Item Field Values:" -ForegroundColor DarkYellow
    Write-Host $FieldValues[0] -ForegroundColor Blue
}

Write-Host "`t> Running Function..." -ForegroundColor DarkYellow
$functionProduct  = DocumentListItems -TenantUrl $siteUrl

Write-Host "`n`tComplete!`n" -ForegroundColor Green
[console]::beep(250,500)
