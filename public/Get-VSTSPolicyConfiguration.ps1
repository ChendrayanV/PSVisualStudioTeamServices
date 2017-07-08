function Get-VSTSPolicyConfiguration
{
    [CmdletBinding(SupportsPaging)]
    param (
        [Parameter(Mandatory)]
        $Instance,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        $Project
    )
    
    begin
    {
    }
    
    process
    {
        $Uri = "https://$Instance.visualstudio.com/defaultcollection/$Project/_apis/policy/configurations?api-version=2.0-preview.1"
        if ($PSCmdlet.PagingParameters.First) 
        {
            $Uri += [string]::Concat('&`$top=', $PSCmdlet.PagingParameters.First)
        }
        if ($PSCmdlet.PagingParameters.Skip)
        {
            $Uri += [string]::Concat('&`$skip=', $PSCmdlet.PagingParameters.Skip)
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
    
    end
    {
    }
}