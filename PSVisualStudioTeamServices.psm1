$public = (Get-ChildItem $PSScriptRoot\public\*.ps1 -ErrorAction SilentlyContinue)
foreach ($import in $public)
{
    . $import.FullName
}

Export-ModuleMember -Function $public.BaseName -Alias *