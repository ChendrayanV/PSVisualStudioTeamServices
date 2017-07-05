function New-VSTSRepository
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $Instance,

        [Parameter(Mandatory)]
        $Name,

        [Parameter()]
        $Version = "1.0",

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        $RepositoryName
    )
    
    begin
    {
    }
    
    process
    {
        $RestParameters = @{
            Uri = "https://$Instance.visualstudio.com/DefaultCollection/$Name/_apis/git/repositories/?api-version=$Version"
            Method = 'Post'
            ContentType = 'application/json'
            Body = @{
                name = $RepositoryName
            } | ConvertTo-Json
            Headers = $Headers 
        }
        try
        {
            Invoke-RestMethod @RestParameters
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