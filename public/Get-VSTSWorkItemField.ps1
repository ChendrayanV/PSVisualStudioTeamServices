function Get-VSTSWorkItemField
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $Instance
    )
    
    begin
    {
    }
    
    process
    {
        $RestParams = @{
            Uri         = "https://$Instance.visualstudio.com/DefaultCollection/_apis/wit/fields?api-version=1.0"
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