<#
Check and kill the process for recovery
#>
$Check = (Get-Counter -Counter "\Thread(WMIPrvSE*)\% Processor Time" -SampleInterval 10 -ErrorAction SilentlyContinue).CounterSamples | where { $_.CookedValue -gt 98 }
if($Check -ne $null)
{
    $startp = $check.Path.indexof("/") + 1
    $endp = $check.Path.indexof(")",$startp)
    $cnumber = $check.Path.Substring($startp,$endp - $startp)
    $TargetPID = ((Get-counter -Counter "\Thread(WMIPrvSE/$cnumber)\id process" -SampleInterval 1).CounterSamples | Select-Object -ExpandProperty CookedValue)
    Write-Host "Process WmiPrvSE ($TargetPID) has %Processor Time value of $($check.CookedValue)"
    Get-Process -Id $TargetPid -IncludeUserName | Where { $_.UserName -like "*Network service" } | Stop-Process -Force
}

<#
Check only
#>
$Check = (Get-Counter -Counter "\Thread(WMIPrvSE*)\% Processor Time" -SampleInterval 10 -ErrorAction SilentlyContinue).CounterSamples | where { $_.CookedValue -gt 98 }
if($Check -ne $null)
{
    $startp = $check.Path.indexof("/") + 1
    $endp = $check.Path.indexof(")",$startp)
    $cnumber = $check.Path.Substring($startp,$endp - $startp)
    $TargetPID = ((Get-counter -Counter "\Thread(WMIPrvSE/$cnumber)\id process" -SampleInterval 1).CounterSamples | Select-Object -ExpandProperty CookedValue)
    Write-Host "Process WmiPrvSE ($TargetPID) has %Processor Time value of $($check.CookedValue)"
}
