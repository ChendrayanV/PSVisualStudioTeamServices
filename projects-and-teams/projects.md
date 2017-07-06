# Team Projects

An enthralling concept in Visual Studio Team Services is team project which are located in project collections. The team projects holds the source code, work items and other resources.

![](https://www.visualstudio.com/en-us/docs/integrate/api/tfs/_img/projects-and-teams.png)

## Get a list of team projects

> The REST API endpoint URL is shown below and to know about the parameters navigate [here](https://www.visualstudio.com/en-us/docs/integrate/api/tfs/projects#get-a-list-of-team-projects). The API version we used here is 1.0

```C\#
GET https://{instance}/DefaultCollection/_apis/projects?api-version={version}[&stateFilter{string}&$top={integer}&skip={integer}]
```

A very simple PowerShell script is below

```powershell
# use your personal access token
$Token = "TokenID"
$Authentication = [Text.Encoding]::ASCII.GetBytes(":$Token")
$Authentication = [System.Convert]::ToBase64String($Authentication)
$RestParameters = @{
    Uri         = "https://{accountname}.visualstudio.com/DefaultCollection/_apis/projects?api-version=1.0"
    Method      = 'GET'
    ContentType = 'application/json'
    Headers = @{
        Authorization = ("Basic {0}" -f $Authentication)
    }
}
try {
    Invoke-RestMethod @RestParameters 
}
catch {
    $_.Exception.Message 
}
```



