function Remove-VSTSRepository
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $Instance,

        [Parameter(Mandatory)]
        $ProjectName,

        [Parameter(Mandatory)]
        $RepositoryName,

        [Parameter()]
        $Version = "1.0"
    )
    
    begin
    {
    }
    
    process
    {
        $RestParameters = @{
            Uri     = "https://$Instance.visualstudio.com/DefaultCollection/$ProjectName/_apis/git/repositories/$RepositoryName?api-version=$Version"
            Method  = 'Delete'
            Headers = $Headers
        }
        try
        {
            Invoke-RestMethod @RestParameters -Verbose
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