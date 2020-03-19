# Overview

_These PowerShell scripts are intended to be used within SharePoint Online assuming you have:_
- Administrator Rights
- Windows Credential Manager
- SharePoint PnP PowerShell Online

## Quick Start Guide
1. **Create an O365 Trial Tenant**
    - https://aka.ms/e5trial 

2. **Install PowerShell 5**
    - https://github.com/PowerShell/PowerShell
    - _Recent PowerShell versions are not compatible with PnP cmdlets_

3. **Install Visual Studio Code**
    - https://code.visualstudio.com/download
    - _Install PowerShell Extension as well_

4. **Create a Windows Credential**
    - https://github.com/jhinshawkcidev/dev/wiki/How-to-create-a-Windows-Credential

***
### `SPOScript-DocumentSiteCollections.ps1`
https://github.com/jhinshawkcidev/dev/blob/master/SPOScript-DocumentSiteCollections.ps1
- Replace the `$siteUrl` variable with your SharePoint site
- `$excludedUrlsArray` is an array of all URLs that should not be included within the script, this is helpful so as not to slow the script down if looping through subsites, apps, and items.

***
### `SPOScript-DocumentSites.ps1`
https://github.com/jhinshawkcidev/dev/blob/master/SPOScript-DocumentSites.ps1
- Accomplishes the same tasks as `SPOScript-DocumentSiteCollections.ps1`, but includes Subsites
- Replace the `$siteUrl` variable with your SharePoint site
- `$excludedUrlsArray` is an array of all URLs that should not be included within the script, this is helpful so as not to slow the script down if looping through subsites, apps, and items.

***
### `SPOScript-DocumentApps.ps1`
https://github.com/jhinshawkcidev/dev/blob/master/SPOScript-DocumentApps.ps1
- Accomplishes the same tasks as `SPOScript-DocumentSites.ps1`, but includes Apps in a separate CSV file
- Replace the `$siteUrl` variable with your SharePoint site
- `$excludedUrlsArray` is an array of all URLs that should not be included within the script
- `$excludedAppsArray` is an array of all Apps that should not be included within the script

***
### `SPOScript-DocumentSiteColumns.ps1`
https://github.com/jhinshawkcidev/dev/edit/master/SPOScript-DocumentSiteColumns.ps1
- Accomplishes the same tasks as `SPOScript-DocumentApps.ps1`, but includes Apps + Site Columns in a separate CSV file
- Replace the `$siteUrl` variable with your SharePoint site
- `$excludedUrlsArray` is an array of all URLs that should not be included within the script
- `$excludedAppsArray` is an array of all Apps that should not be included within the script
- This code is for reference only, it returns too many site columns and I will need to adjust it to only return ones that are necessary.

***
### `SPOScript-DocumentListItemFieldValues.ps1`
https://github.com/jhinshawkcidev/dev/blob/master/SPOScript-DocumentListItemFieldValues.ps1
- Prints the Field Values, or properties, of each list item within a single list
- Replace the `$siteUrl` variable with your SharePoint site
- Replace the `$listId` variable with your list, acceptable values can be found with `Get-PnPList` cmdlet
 - `Id -1` is included to return the first item in the list, though this will not work in all lists. If, for example, the first list item is deleted over time this Id parameter will have to be changed to a working number. I will need to adjust a fix for this.

***
