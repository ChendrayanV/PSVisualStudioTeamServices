function Remove-VSTSProject
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $Instance,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        $Id
    )
    
    begin
    {
    }
    
    process
    {
        if ($Headers.Authorization -eq $null)
        {
            Write-Error "Access Denied"
        }
        else 
        {
            $RestParams = @{
                Uri         = "https://$Instance.visualstudio.com/defaultcollection/_apis/projects/$($ProjectName)?api-version=1.0"
                Method      = 'Delete'
                ContentType = 'application/json'
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