function Remove-VSTSWorkItem
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $Instance,

        [Parameter(Mandatory)]
        $ProjectName,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        $Id 
    )
    
    begin
    {
    }
    
    process
    {
        $RestParams = @{
            Uri         = "https://$Instance.visualstudio.com/DefaultCollection/$ProjectName/_apis/wit/workitems/$Id?api-version=$Version"
            Method      = 'Delete'
            ContentType = 'application/json'
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