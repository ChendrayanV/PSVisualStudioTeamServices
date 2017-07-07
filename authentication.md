# Authentication

There are two popular authentication methods named OAUTH and Personal Access Token \(PAT\) and this book covers about personal access token for a demo. OAUTH is much secured and used in production environments. Choosing the right authentication mechanism [guidance](https://www.visualstudio.com/en-us/docs/integrate/get-started/authentication/authentication_guidance) will give more insight.

## Personal Access Token

Follow the steps beneath to create a personal access token

1. Sign in to either your Visual Studio Team Services account [https://{youraccount}.visualstudio.com](https://{youraccount}.visualstudio.com).
2. From your home page, open your _**profile**_. Go to your _**security**_ details.
3. In the right pane click Personal access tokens and choose add. 
4. Name your _**token**_ and select the _**time span.**_

> Do not share the Personal Access Token with anyone.
>
> Choose the time span as 90 days.
>
> Revoke the personal access token ID if you find any security issues.

The personal access token needs a conversion to base64 string and the below PowerShell script will do it.

```powershell
function Connect-VSTSInstance
{
    param (
        [Parameter(Mandatory)]
        [string]
        $Token 
    )

    $Authentication = [Text.Encoding]::ASCII.GetBytes(":$Token")
    $Authentication = [System.Convert]::ToBase64String($Authentication)
    $Script:Headers = @{
        Authorization = ("Basic {0}" -f $Authentication)
    }  
}
```

Now, we get the 52 characters length of base64 string which will be used for authentication. In the personal access token method the user name can be empty for an example both snippets beneath works fine. 

```powershell
$Authentication = [Text.Encoding]::ASCII.GetBytes(":$Token")
# returns :<TOKENID>

$Authentication = [Text.Encoding]::ASCII.GetBytes("Chendrayan.Venkatesan@contoso.com:$Token")
# returns Chendrayan.Venkatesan@contoso.com:<TOKENID>
```



