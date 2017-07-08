function Get-VSTSTestConfiguration
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
        $Uri = "https://$Instance.visualstudio.com/DefaultCollection/$Project/_apis/test/configurations?api-version=3.0-preview.2"
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
            (Invoke-RestMethod @RestParams).value 
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