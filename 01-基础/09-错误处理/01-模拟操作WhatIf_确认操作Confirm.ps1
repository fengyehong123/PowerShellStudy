# 获取桌面上的指定文件夹路径
$target_path = "$($Home)\Desktop\test0608\*.txt"

<#
    ⏹通过 WhatIf配置项 进行模拟操作
    powershell会把模拟运行产生的结果打印在控制台上

    ⏹并不是所有的cmdltes都支持WhatIf配置项
    只有Remove-Item, Stop-Process 等危险操作支持该配置项
#>
Remove-Item -Path $target_path -WhatIf
<#
    WhatIf: 正在目标“C:\Users\Admin\Desktop\test0608\Hello_World.txt”上执行操作“删除文件”。 
    WhatIf: 正在目标“C:\Users\Admin\Desktop\test0608\Hello_World1.txt”上执行操作“删除文件”。
    WhatIf: 正在目标“C:\Users\Admin\Desktop\test0608\Hello_World2.txt”上执行操作“删除文件”。
#>

<#
    ⏹-Confirm配置项 相当于linux中rm命令的 -i 配置项
    用于在操作之前逐个确认
#>
Remove-Item -Path $target_path -Confirm
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹$ConfirmPreference 可以对默认设置或者其它更严格的设置作出判断与回应
#>
# 查看$ConfirmPreference支持的设置
[Enum]::GetNames($ConfirmPreference.GetType()) | Out-Host
<#
    None
    Low
    Medium
    High
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 查看当前的$ConfirmPreference
$ConfirmPreference | Out-Host  # High
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red