function Get-VSTSRecycleBinWorkItem {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $Instance,

        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        $Project,

        [Parameter()]
        [switch]
        $Detailed
    )
    
    begin {
    }
    
    process {
        $RestParams = @{
            Uri = "https://$Instance.visualstudio.com/DefaultCollection/$Project/_apis/wit/recycleBin?api-version=3.0-preview"
            Method = "Get"
            Headers = $Headers
            ContentType = "application/json"
        }
        try 
        {
            $Results = (Invoke-RestMethod @RestParams).value
            foreach($Result in $Results)
            {
                if($PSBoundParameters.ContainsKey('Detailed'))
                {
                    $ids = $Result.id -join ","
                    $Uri = "https://$Instance.visualstudio.com/DefaultCollection/$Project/_apis/wit/recycleBin?ids=$ids&api-version=3.0-preview"
                    $items = Invoke-RestMethod -Uri $Uri -Method Get -ContentType 'application/json' -Headers $Headers 
                    foreach($item in $items)
                    {
                        $item.value
                    }
                }
                else 
                {
                    $Result
                }
            }
        }
        catch 
        {
            $_.Exception.Message 
        }
    }
    
    end {
    }
}