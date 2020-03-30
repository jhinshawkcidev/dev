<#
.\SPOScript-UpdateSiteColumns.ps1

https://docs.microsoft.com/en-us/previous-versions/office/sharepoint-csom/ee540543(v%3Doffice.15)
https://docs.microsoft.com/en-us/previous-versions/office/sharepoint-server/ee537052%28v%3doffice.15%29
https://docs.microsoft.com/en-us/sharepoint/dev/schema/choices-element-list
https://docs.microsoft.com/en-us/dotnet/api/system.xml.xmldocument.createelement?view=netframework-4.8
#> 

Install-Module SharePointPnPPowerShellOnline
Install-Module ImportExcel -Scope CurrentUser
$siteUrl  = "https://jhinshawkci.sharepoint.com"  # This is also the Credential, as long you're using PowerShell 5 and have Windows Credential Manager


function ValidateSiteColumn($TenantUrl) {
    
    Write-Host "`t> Importing Excel File..." -ForegroundColor DarkYellow
    $sheet = Import-Excel -Path "C:\temp\SampleIA-SingleColumn.xlsx"
    Write-Host "`t> Connecting to Tenant..." -ForegroundColor DarkYellow
    
    Connect-PnPOnline -Url $TenantUrl -Credentials $TenantUrl
    foreach ($row in $sheet) {
        if ($row.Type -match "Calculated") {
            CreateCalculatedColumn -Row $row
        }
        elseif ($row.Type -match "Choice") {
            CreateChoiceColumn -Row $row
        }
        else  {
            CreateColumn -Row $row
        }
    }
}

function CreateColumn($Row) {

    Write-Host "`t> Creating Column..." -ForegroundColor DarkYellow
    $Group = $Row.Group
    $InternalName = $Row.InternalName
    $DisplayName = $Row.DisplayName
    $Type = $Row.Type

    $hashTable = @{
        Title = "$DisplayName";
        Group = "$Group";
        TypeAsString = "$Type"
    }

    try {
        Add-PnPField -Group $Group -InternalName $InternalName -DisplayName $DisplayName -Type $Type -ErrorAction Stop
    }
    catch {
        Set-PnPField -Identity $InternalName -Values $hashTable
    }
}

function CreateChoiceColumn($Row) {

    Write-Host "`t> Creating Choice Column..." -ForegroundColor DarkYellow
    $Group = $Row.Group
    $InternalName = $Row.InternalName
    $DisplayName = $Row.DisplayName
    $Type = $Row.Type
    $rawChoices = $Row.Choices
    if ($rawChoices -Match ", ") {
        $formattedChoices = $rawChoices -split ", "
    }
    else {
        $formattedChoices = $rawChoices
    }

    try {
        Add-PnPField -Group $Group -InternalName $InternalName -DisplayName $DisplayName -Type $Type -Choices $formattedChoices -ErrorAction Stop
    }

    catch {

        $emptyHashTable = @{
            Title = "$DisplayName";
            Group = "$Group";
            TypeAsString = "$Type";
            Choices = $null
        }
        Set-PnPField -Identity $InternalName -Values $emptyHashTable

        $hashTable2 = @{
            Title = "$DisplayName";
            Group = "$Group";
            TypeAsString = "$Type";
            Choices = $formattedChoices
        }
        Set-PnPField -Identity $InternalName -Values $hashTable2
    }
}

function CreateCalculatedColumn($Row) {
    Write-Host "`t> Creating Column..." -ForegroundColor DarkYellow
    $Group = $Row.Group
    $InternalName = $Row.InternalName
    $DisplayName = $Row.DisplayName
    $Type = $Row.Type
    $Formula = "=" + $Row.Formula

    $hashTable = @{
        Title = "$DisplayName";
        Group = "$Group";
        TypeAsString = "$Type";
        Formula = "$Formula"
    }

    try {
        Add-PnPField -Group $Group -InternalName $InternalName -DisplayName $DisplayName -Type $Type  -Formula $Formula -ErrorAction Stop
    }
    catch {
        Set-PnPField -Identity $InternalName -Values $hashTable
    }
}

Write-Host "`t> Running Function..." -ForegroundColor DarkYellow
ValidateSiteColumn -TenantUrl $siteUrl

Write-Host "`n`tComplete!`n" -ForegroundColor Green
[console]::beep(250,500)