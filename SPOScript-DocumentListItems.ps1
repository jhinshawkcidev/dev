<#
.\SPOScript-DocumentListItems.ps1
#> 

Install-Module SharePointPnPPowerShellOnline
$outFile1 = "C:\temp\Outfile1.csv"  
$outFile2 = "C:\temp\Outfile2.csv"  
$outFile3 = "C:\temp\Outfile3.csv"  
$siteUrl  = "https://jhinshawkci.sharepoint.com"  # This is also the Credential, as long as it exists as a generic credential within your windows environment

# function DocumentListItems($TenantUrl) {
#     $hashTable1 = @()
#     Connect-PnPOnline -Url $TenantUrl -Credentials $TenantUrl
#     $List = Get-PnPList -Identity B4FE45AB-393A-4EE1-8C9D-63B47B6B520F
#     $ListItems = Get-PnPListItem -List $List
#     foreach ($listItem in $ListItems) {
#         $hashTable1 += New-Object psobject -Property @{
#             'Title' = $listItem.FieldValues.Title;  
#             'Status' = $listItem.FieldValues.Status;  
#         }
#     }
#     return $hashTable1
# }

function DocumentListItems($TenantUrl) {
    $hashTable1 = @()
    Connect-PnPOnline -Url $TenantUrl -Credentials $TenantUrl
    $List = Get-PnPList -Identity B4FE45AB-393A-4EE1-8C9D-63B47B6B520F
    $ListItems = (Get-PnPListItem -List $List).FieldValues
    foreach ($listItem in $ListItems) {
        Write-Host $listItem
        # $hashTable1 += New-Object psobject -Property @{
        #     'Title' = $listItem.FieldValues.Title;  
        #     'Status' = $listItem.FieldValues.Status;  
        # }
    }
    # return $hashTable1
}

# Return sites - call function
# Write-Host "`t> Running Functions..." -ForegroundColor DarkYellow
# $functionProduct  = DocumentListItems -TenantUrl $siteUrl
# $functionProduct  | Export-csv -Path $outFile1 -Append -Force

Write-Host "`t> Running Functions..." -ForegroundColor DarkYellow
$functionProduct  = DocumentListItems -TenantUrl $siteUrl

Write-Host "`n`tComplete!`n" -ForegroundColor Green
[console]::beep(250,500)