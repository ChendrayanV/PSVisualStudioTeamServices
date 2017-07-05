function Get-VSTSRepository
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $Instance,

        [Parameter()]
        $Name,

        [Parameter()]
        $Version = "1.0"
    )
    
    begin
    {
    }
    
    process
    {
        if ($Headers.Authorization -eq $null) 
        {
            Write-Error "Access in denied!"
        }
        else 
        {
            if ($PSBoundParameters.ContainsKey('Name'))
            {
                $Uri = "https://$Instance.visualstudio.com/DefaultCollection/$Name/_apis/git/repositories?api-version=$Version"
            }
            else 
            {
                $Uri = "https://$Instance.visualstudio.com/DefaultCollection/_apis/git/repositories?api-version=$Version"
            }
            $RestParameters = @{
                Uri     = $Uri
                Method  = "Get"
                Headers = $Headers
                ContentType = 'application/json'
            }
            try 
            {
                (Invoke-RestMethod @RestParameters).value 
            }
            catch 
            {
                $_.Exception.Message 
            }
        }
    }
    
    end
    {
    }
}