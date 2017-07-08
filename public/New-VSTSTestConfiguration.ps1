function New-VSTSTestConfiguration
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $Instance,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        $Project,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        $TestConfigurationName,

        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        $TestConfigurationDescription,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        $Name,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        $Value 
    )
    
    begin
    {
    }
    
    process
    {
        $RestParams = @{
            Uri         = "https://$Instance.visualstudio.com/DefaultCollection/$Project/_apis/test/configurations?api-version=3.0-preview.1"
            Method      = "Post"
            ContentType = "application/json"
            Headers     = $Headers
            Body        = @{
                name        = $TestConfigurationName
                description = $TestConfigurationDescription
                values      = @{
                    name  = $Name
                    value = $Value
                }
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
    
    end
    {
    }
}