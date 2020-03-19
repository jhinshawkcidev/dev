# Overview

_These PowerShell scripts are intended to be used within SharePoint Online assuming you have:_
- Administrator Rights
- Windows Credential Manager
- SharePoint PnP PowerShell Online

## Quick Start Guide
1. **Create an O365 Trial Tenant**

  ` >`https://aka.ms/e5trial 

2. **Install PowerShell 5**

  ` >`https://github.com/PowerShell/PowerShell
  
  ` >` _Recent PowerShell versions are not compatible with PnP cmdlets_

3. **Install Visual Studio Code**

  ` >`https://code.visualstudio.com/download
  
  ` >`_Install PowerShell Extension as well_

4. **Create a Windows Credential**

  ` >`https://github.com/jhinshawkcidev/dev/wiki/How-to-create-a-Windows-Credential

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
