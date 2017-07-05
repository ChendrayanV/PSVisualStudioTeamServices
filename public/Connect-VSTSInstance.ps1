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