function Restore-VSTSRecycleBinWorkItem {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $Instance,

        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        $Id 
    )
    
    begin {
    }
    
    process {
        $RestParams = @{
            Uri = "https://$Instance.visualstudio.com/DefaultCollection/_apis/wit/recyclebin/$($Id)?api-version=3.0-preview"
            Method = "Patch"
            Headers = $Headers
            ContentType = "application/json"
            Body = @{
                IsDeleted = "false"
            } | ConvertTo-Json
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
    
    end {
    }
}