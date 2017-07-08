function New-VSTSTeam
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $Instance,

        [Parameter(Mandatory)]
        $Project,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        $TeamName,

        [Parameter()]
        $Description
    )
    
    begin
    {
    }
    
    process
    {
        if ($Headers.Authorization -eq $null)
        {
            Write-Error "Access is denied"
        }
        else 
        {
            $RestParams = @{
                Uri         = "https://$Instance.VisualStudio.com/DefaultCollection/_apis/projects/$($Project)/teams?api-version=1.0"
                Method      = "Post"
                ContentType = "application/json"
                Headers     = $Headers 
                Body        = @{
                    name        = $TeamName
                    description = $Description
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
    }
    
    end
    {
    }
}