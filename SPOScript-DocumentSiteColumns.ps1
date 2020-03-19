<#
.\SPOScript-DocumentSiteColumns.ps1
#>

Install-Module SharePointPnPPowerShellOnline
$outFile1 = "C:\temp\Outfile1-Sites.csv"  
$outFile2 = "C:\temp\Outfile2-Apps.csv"  
$outFile3 = "C:\temp\Outfile3-SiteColumns.csv"  
$siteUrl  = "https://jhinshawkci.sharepoint.com"  # This is also the Credential, as long as it exists as a generic credential within your windows environment

#URLs to exclude, best to keep this collapsed
$excludedUrlsArray = @(
    "https://jhinshawkci.sharepoint.com/portals/Community",
    "https://jhinshawkci.sharepoint.com/sites/AppCatalog",
    "https://jhinshawkci.sharepoint.com/portals/hub",
    "https://jhinshawkci.sharepoint.com/search",
    "https://jhinshawkci-my.sharepoint.com/"
)
#Apps to exclude, best to keep this collapsed
$excludedAppsArray = @(
    "_catalogs/hubsite",
    "App Packages",
    "appdata",
    "appfiles",
    "Apps in Testing",
    "Composed Looks",
    "Converted Forms",
    "Form Templates",
    "Get started with Apps for Office and SharePoint",
    "List Template Gallery",
    "Maintenance Log Library",
    "Master Page Gallery",
    "SharePointHomeOrgLinks",
    "Site Assets",
    "Solution Gallery",
    "Style Library",
    "TaxonomyHiddenList",
    "Theme Gallery",
    "User Information List",
    "Web Part Gallery"
)


# Return site collections function
function DocumentSiteCollections($TenantUrl, $ExcludedUrls) {
    $hashTable1 = @()
    Connect-PnPOnline -Url $TenantUrl -Credentials $TenantUrl
    $allSiteCollections = Get-PnPTenantSite
    foreach ($siteCollection in $allSiteCollections) {
        $siteCollectionUrl = $siteCollection.Url
        $includeSiteCollection = $true;
        foreach ($excludedUrl in $ExcludedUrls) {
            if ($siteCollectionUrl -like $excludedUrl) {
                $includeSiteCollection = $false;
            }
        }
        if ($includeSiteCollection) {
            $hashTable1 += New-Object psobject -Property @{
                'Title' = $siteCollection.Title;
                'Url' = $siteCollection.Url;
            }
            Connect-PnPOnline -Url $siteCollectionUrl -Credentials $TenantUrl
            $allSubWebs = Get-PnPSubWebs
            foreach ($subWeb in $allSubWebs) {
                $subWebUrl = $subWeb.Url
                $includeSubSite = $true;
                foreach ($excludedUrl in $ExcludedUrls) {
                    if ($subWebUrl -like $excludedUrl){
                        $includeSubSite = $false;
                    }
                }
                if ($includeSubSite) {
                    $hashTable1 += New-Object psobject -Property @{
                        'Title' = $subWeb.Title;
                        'Url' = $subWeb.Url;
                    }
                }
            }
        }
    }
    return $hashTable1
}

# Return apps function
function DocumentApps ($TenantUrl, $SitesArray, $ExcludedApps) {
    $hashTable2 = @()
    foreach ($site in $SitesArray) {
        $siteUrl = $site.Url
        Connect-PnPOnline -Url $siteUrl -Credentials $TenantUrl
        $allApps = Get-PnPList
        foreach ($app in $allApps) {
            $includeApp = $true;
            foreach ($excludedApp in $ExcludedApps) {
                if ($app.Title -like $excludedApp) {
                    $includeApp = $false;
                }
            }
            if ($includeApp) {
                $hashTable2 += New-Object psobject -Property @{
                    'Title' = $app.Title;
                    'App Type' = $app.BaseType;
                    'Item Count' = $app.ItemCount;
                    'Url' = "$($TenantUrl, $app.DefaultViewUrl.replace(' ','%20'))".replace(' ','')
                }
            }
        }
    }
    return $hashTable2
}

# Return Site Columns function
function DocumentSiteColumns ($TenantUrl, $SitesArray, $ExcludedApps) {
    $hashTable3 = @()
    foreach ($site in $SitesArray) {
        $siteUrl = $site.Url
        Connect-PnPOnline -Url $siteUrl -Credentials $TenantUrl
        $allApps = Get-PnPList
        foreach ($app in $allApps) {
            $includeApp = $true;
            foreach ($excludedApp in $ExcludedApps) {
                if ($app.Title -like $excludedApp) {
                    $includeApp = $false;
                }
            }
            if ($includeApp) {
                $allSiteColumns = Get-PnPField
                foreach ($siteColumn in $allSiteColumns) {
                    $hashTable3 += New-Object psobject -Property @{
                        'App Title' = $app.Title;
                        'App Type' = $app.BaseType;
                        'App Url' = "$($TenantUrl, $app.DefaultViewUrl.replace(' ','%20'))".replace(' ','');
                        'Site Column Title' = $siteColumn.Title;
                        'Site Column Internal Name' = $siteColumn.InternalName;
                        'Site Column Type' = $siteColumn.TypeDisplayName;
                        'Site Column Group' = $siteColumn.Group;
                    }
                }
            }
        }
    }
    return $hashTable3
}

# Return sites - call function
Write-Host "`t> Running Functions..." -ForegroundColor DarkYellow
$allSites  = DocumentSiteCollections -TenantUrl $siteUrl -ExcludedUrls $excludedUrlsArray 
$allSites  | Export-csv -Path $outFile1 -Append -Force

# Return apps - call function
$allApps  = DocumentApps -TenantUrl $siteUrl -SitesArray $allSites -ExcludedApps $excludedAppsArray
$allApps | Select-Object 'Title', 'App Type', 'Item Count', 'Url' | Export-csv -Path $outFile2 -Append -Force

# Return Site Columns - call function
$allSiteColumns  = DocumentSiteColumns -TenantUrl $siteUrl -SitesArray $allSites -ExcludedApps $excludedAppsArray
$allSiteColumns | Select-Object 'App Title', 'App Type', 'App Url', 'Site Column Title', 'Site Column Internal Name', 'Site Column Type', 'Site Column Group' | Export-csv -Path $outFile3 -Append -Force

Write-Host "`n`tComplete!`n" -ForegroundColor Green
[console]::beep(250,500)