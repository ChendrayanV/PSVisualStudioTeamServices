function Get-VSTSTeam {
    [CmdletBinding(SupportsPaging)]
    param (
        [Parameter(Mandatory)]
        $Instance,

        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        $Project
    )
    
    begin {
    }
    
    process {
        
    }
    
    end {
    }
}