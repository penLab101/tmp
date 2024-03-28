
$domainObj = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()

$PDC = ($domainObj.PdcRoleOwner).Name
$DistinguishedName = "DC=$($domainObj.Name.Replace('.', ',DC='))"

$SearchString = "LDAP://"
$SearchString += $PDC + "/"
$SearchString += $DistinguishedName
Write-Output "using SearchString: $SearchString"


$Searcher = New-Object System.DirectoryServices.DirectorySearcher([ADSI]$SearchString)
$objDomain = New-Object System.DirectoryServices.DirectoryEntry
$Searcher.SearchRoot = $objDomain


$Searcher.filter="(servicePrincipalName=*)"

$Result = $Searcher.FindAll()

Foreach($obj in $Result)
{
    Foreach($prop in $obj.Properties)
    {
        $prop
    }
    Write-Host "------------------------"
}

