<#
.\SPOScript-DocumentSiteCollections.ps1
#> 

Install-Module SharePointPnPPowerShellOnline
$outFile1 = "C:\temp\Outfile1-Desc.csv"  
$outFile2 = "C:\temp\Outfile2-Desc.csv"  
$outFile3 = "C:\temp\Outfile3-Desc.csv"  
$siteUrl  = "https://jhinshawkci.sharepoint.com"  # This is also the Credential, as long you're using PowerShell 5 and have Windows Credential Manager

#URL Property to exclude, best to keep this collapsed
$excludedUrlsArray = @(
    "https://jhinshawkci.sharepoint.com/portals/Community",
    "https://jhinshawkci.sharepoint.com/portals/hub",
    "https://jhinshawkci.sharepoint.com/search"
)

# Return site collections function
function DocumentSiteCollections($TenantUrl, $ExcludedUrls) {
    $hashTable1 = @()
    Connect-PnPOnline -Url $TenantUrl -Credentials $TenantUrl
    $allSiteCollections = Get-PnPTenantSite
    foreach ($siteCollection in $allSiteCollections) {
        $includeSiteCollection = $true;
        foreach ($excludedUrl in $ExcludedUrls) {
            if ($siteCollection.Url -like $excludedUrl) {
                $includeSiteCollection = $false;
            }
        }
        if ($includeSiteCollection) {
            $hashTable1 += New-Object psobject -Property @{
                'Title' = $siteCollection.Title;
                'Url' = $siteCollection.Url;
            }
        }
    }
    return $hashTable1
}

# Return site collections - call function
Write-Host "`t> Running Functions..." -ForegroundColor DarkYellow
$allSites  = DocumentSiteCollections -TenantUrl $siteUrl -ExcludedUrls $excludedUrlsArray 
$allSites  | Export-csv -Path $outFile1 -Append -Force

Write-Host "`n`tComplete!`n" -ForegroundColor Green
[console]::beep(250,500)