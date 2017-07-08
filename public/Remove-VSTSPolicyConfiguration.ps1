function Remove-VSTSPolicyConfiguration {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $Instance,

        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        $Project,

        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        $Id 
    )
    
    begin {
    }
    
    process {
        $RestParams = @{
            Uri = "https://$Instance/defaultcollection/$Project/_apis/policy/configurations/$($Id)?api-version=2.0-preview.1"
            Method = "Delete"
            ContentType = "application/json"
            Headers = $Headers 
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