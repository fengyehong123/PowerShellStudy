<#
    PowerShell 默认的对象输出方式 是 异步刷新的，它并不会阻塞 Write-Host，所以在 Get-WmiObject 的对象还没完全处理完的情况下，Write-Host 可能先被执行。
    因此我们通过 Out-Host 强制立即输出所有结果，等全部结果都输出完毕只有，才向下执行 Write-Host
#>
Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.MACAddress -ne $null } | Select-Object Description, MACAddress | Out-Host
Write-Host "---------------------------------------------------"

<#
    还可以将执行结果存储到一个变量中，这样可以等到Mac地址完全获取到之后，才向下执行代码
#>
$MacAddress = Get-CimInstance Win32_NetworkAdapterConfiguration | Where-Object { $_.MACAddress -ne $null } | Select-Object Description, MACAddress
$MacAddress | Format-Table -AutoSize

Pause
