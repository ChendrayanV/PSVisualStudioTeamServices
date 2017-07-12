function Export-VSTSWorkItem {
    [CmdletBinding()]  
    param (  
        # Visual Studio Team Services Account Name  
        [Parameter(Mandatory)]  
        $Instance,  
 
        # Create a Personal Access Token  
        [Parameter(Mandatory)]  
        $Token,  
 
        # Opt the Work Items Type. (Modify as required)  
        [Parameter(Mandatory)]  
        [ValidateSet('Bug', 'Task', 'Epic', 'Feature')]  
        $WorkItemType,  
 
        # Export in your favorite format.  
        [Parameter()]  
        [ValidateSet('Csv', 'HTML', 'FancyHTML')]  
        $ExportAs  
    )  
      
    begin {  
    }  
      
    process {  
        $Authentication = (":$Token")  
        $Authentication = [System.Text.Encoding]::ASCII.GetBytes($Authentication)  
        $Authentication = [System.Convert]::ToBase64String($Authentication)  
        switch ($WorkItemType) {  
            "Bug" {  
                $Body = @{  
                    Query = "Select * from WorkItems WHERE [System.WorkItemType] = '$WorkItemType'"  
                } | ConvertTo-Json  
            }  
            "Task" {  
                $Body = @{  
                    Query = "Select * from WorkItems WHERE [System.WorkItemType] = '$WorkItemType'"  
                } | ConvertTo-Json  
            }  
            "Epic" {  
                $Body = @{  
                    Query = "Select * from WorkItems WHERE [System.WorkItemType] = '$WorkItemType'"  
                } | ConvertTo-Json  
            }  
            "Feature" {  
                $Body = @{  
                    Query = "Select * from WorkItems WHERE [System.WorkItemType] = '$WorkItemType'"  
                } | ConvertTo-Json  
            }  
        }  
        $RestParams = @{  
            Uri         = "https://$Instance.visualstudio.com/DefaultCollection/_apis/wit/wiql?api-version=1.0"  
            Method      = "Post"  
            ContentType = "application/json"  
            Headers     = @{  
                Authorization = ("Basic {0}" -f $Authentication)  
            }  
            Body        = $Body  
        }  
        try {  
            $Id = (Invoke-RestMethod @RestParams).workitems.id -join ","  
            if ($Id -ne $null) {  
                $Fields = @('System.Id', 'System.Title', 'System.AssignedTo',   
                    'System.State', 'System.CreatedBy', 'System.WorkItemType') -join ","  
                $RestParams["Uri"] = "https://$Instance.visualstudio.com/DefaultCollection/_apis/wit/WorkItems?ids=$Id&fields=$Fields&api-version=1"  
                $RestParams["Method"] = "Get"  
                $RestParams.Remove("Body")  
                $Result = Invoke-RestMethod @RestParams  
                if (! $PSBoundParameters['ExportAs']) {  
                    ($Result.value.fields)  
                }  
            }  
            else {  
                Write-Warning "No Items are available in $WorkItemType"  
            }  
          
            switch ($ExportAs) {  
                'csv' {  
                    $Result.value.fields | Export-Csv .\WITReport.csv -NoTypeInformation   
                }  
                'HTML' {  
                    $Result.value.fields | Export-Csv .\WITReport.html -NoTypeInformation   
                }  
                'FancyHTML' {  
                    Add-Content  ".\style.CSS"  -Value " body {   
                    font-family:Calibri;   
                    font-size:10pt;   
                    }   
                    th {    
                    background-color:black;   
                    color:white;   
                    }   
                    td {   
                    background-color:#19fff0;   
                    color:black;}"  
                    $Result.value.fields | ConvertTo-Html -CssUri .\Style.css | Out-File .\Report.html  
                }  
            }  
        }  
        catch {  
            $_.Exception.Message   
        }  
    }  
      
    end {  
    }  
}  