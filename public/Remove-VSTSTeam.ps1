function Remove-VSTSTeam
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $Instance,

        [Parameter(Mandatory)]
        $Project,

        [Parameter(Mandatory)]
        $Team
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
                Uri         = "https://$Instance.VisualStudio.com/DefaultCollection/_apis/projects/$($Project)/teams/$($Team)?api-version=1.0"
                Method      = "Delete"
                ContentType = "application/json"
                Headers     = $Headers
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