function Get-VSTSWorkItem
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $Instance,

        [Parameter()]
        [int]
        $Top
    )
    
    begin
    {
    }
    
    process
    {
        if ($Headers.Authorization -eq $null)
        {
            Write-Error "Access is denied!"
        }
        else 
        {
            if ($PSBoundParameters.ContainsKey('Top'))
            {
                $Uri = "https://$Instance.visualstudio.com/DefaultCollection/_apis/projects?api-version=1.0&`$top=$Top"
            }
            else 
            {
                $Uri = "https://$Instance.visualstudio.com/DefaultCollection/_apis/projects?api-version=1.0"
            }
            $RestParams = @{
                Uri         = $Uri
                Method      = "Get"
                ContentType = "application/json"
                Headers     = $Headers
            }
            try
            {
                (Invoke-RestMethod @RestParams).value 
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