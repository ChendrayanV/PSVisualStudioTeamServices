function Get-VSTSWorkItem
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $Instance,

        [Parameter()]
        [ValidateSet('Task', 'Bug', 'Product Backlog Item', 'Code Review Request', 'Code Review Response', 'Feature')]
        $WorkItemType,

        [Parameter()]
        [switch]
        $Detailed 
    )
    
    begin
    {
    }
    
    process
    {
        if ($PSBoundParameters.ContainsKey('WorkItemType'))
        {
            $Body = @{
                Query = "Select * from WorkItems where [System.WorkItemType] = '$WorkItemType'"
            } | ConvertTo-Json
        }
        else 
        {
            $Body = @{
                Query = "Select * from WorkItems"
            } | ConvertTo-Json
        }
        $Uri = "https://$Instance.visualstudio.com/DefaultCollection/_apis/wit/wiql?api-version=1.0"
        $RestParams = @{
            Uri         = $Uri 
            Method      = 'Post'
            ContentType = 'application/json'
            Headers     = $Headers
            Body        = $Body
        }
        try 
        {
            $items = (Invoke-RestMethod @RestParams)
            foreach ($item in $items)
            {
                $Ids = $item.workitems.id -join ','
                if ($PSBoundParameters.ContainsKey('Detailed')) 
                {
                    $RestParams = @{
                        Uri = "https://$Instance.visualstudio.com/DefaultCollection/_apis/wit/workitems?ids=$ids&`$expand=all&api-version=1.0"
                        Method = "Get"
                        ContentType = "application/json"
                        Headers = $Headers
                    }
                    try 
                    {
                        $Results = Invoke-RestMethod @RestParams 
                        $Results.value.fields 
                    }
                    catch
                    {
                        $_.Exception.Message
                    }
                }
                else 
                {
                    $item.workItems 
                }
            }
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