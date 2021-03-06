function Get-VSTSPolicyType
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $Instance,

        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        $Project 
    )
    
    begin
    {
    }
    
    process
    {
        $RestParams = @{
            Uri         = "https://$Instance.visualstudio.com/defaultcollection/$Project/_apis/policy/types?api-version=2.0-preview.1"
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