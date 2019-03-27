function Get-Files {
    Param(
        [string]$Path = $pwd
    ) 

    $files = @()

    foreach ($item in Get-ChildItem $Path)
    {
        if (Test-Path $item.FullName -PathType Container) 
        {
            Get-Files $item.FullName
        } 

        $files += $item 
    } 

    return $files
}

Set-ExecutionPolicy Unrestricted -Force
Get-Files | Unblock-File