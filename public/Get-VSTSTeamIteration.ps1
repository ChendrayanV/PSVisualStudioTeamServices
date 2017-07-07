function Get-VSTSTeamIteration
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $Instance,

        [Parameter()]
        $ProjectName
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
            $Uri = "https://$Instance.visualStudio.com/DefaultCollection/$ProjectName/_apis/work/teamsettings/iterations?api-version=2.1-preview"
            $RestParams = @{
                Uri         = $Uri 
                Method      = 'Get'
                ContentType = 'application/json'
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
    }
    
    end
    {
    }
}