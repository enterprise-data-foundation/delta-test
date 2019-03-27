param (
    [Parameter(ValueFromRemainingArguments=$true)]
    $Path
)

$Parent = Split-Path -Path $Path -Parent
$BaseName = (Get-Item $Path).BaseName
$Extension = (Get-Item $Path).Extension

Copy-Item -Path $Path -Destination "$($Parent)\$($BaseName).certified$($Extension)"
