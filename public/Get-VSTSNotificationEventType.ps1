function Get-VSTSNotificationEventType
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
            Uri         = "https://$Instance.visualstudio.com/_apis/notification/eventTypes?api-version=3.2-preview"
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