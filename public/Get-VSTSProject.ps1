function Get-VSTSProject
{
    [CmdletBinding(SupportsPaging)]
    param (
        [Parameter(Mandatory)]
        $Instance
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
            $Uri = "https://$Instance.visualstudio.com/defaultcollection/_apis/projects?api-version=1.0"
            if ($PSCmdlet.PagingParameters.First) 
            {
                $Uri += [string]::Concat('&$top=', $PSCmdlet.PagingParameters.First)
            }
            if ($PSCmdlet.PagingParameters.Skip)
            {
                $Uri += [string]::Concat('&$skip=', $PSCmdlet.PagingParameters.Skip)
            }
            $RestParams = @{
                Uri         = $Uri
                Method      = "Get"
                ContentType = "application/json"
                Headers     = $Headers
            }
            try 
            {
                Invoke-RestMethod @RestParams 
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