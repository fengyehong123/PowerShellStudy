# 来源
# https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/foreach-object?view=powershell-5.1

<#
    ⏹ForEach-Object 也支持 -Begin {} -Process {} -End {} 代码块
#>
1..6 | ForEach-Object -Begin {
    '...处理开始...' | Out-Host
} -Process {
    "当前的值为: $($_)" | Out-Host
} -End {
    '...处理结束...' | Out-Host
}
<#
    ...处理开始...
    当前的值为: 1
    当前的值为: 2
    当前的值为: 3
    当前的值为: 4
    当前的值为: 5
    当前的值为: 6
    ...处理结束...
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    -Process 支持同时运行若干个代码块
    但是像下面这样不手动指定 -Begin 和 -End 为 $null 的话,
    会把第一个代码块给映射为 -Begin ,从而导致只能执行一次
#>
'123@qq.com', '456@qq,com' | ForEach-Object -Process {
    "代码块1接收到了参数: $($_)" | Out-Host
}, {
    "代码块2接收到了参数: $($_)" | Out-Host
}
<#
    代码块1接收到了参数:
    代码块2接收到了参数: 123@qq.com
    代码块2接收到了参数: 456@qq,com
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 下面是正确的写法
'123@qq.com', '456@qq,com' | ForEach-Object -Begin $null -Process {
    "代码块1接收到了参数: $($_)" | Out-Host
}, {
    "代码块2接收到了参数: $($_)" | Out-Host
} -End $null
<#
    代码块1接收到了参数: 123@qq.com
    代码块2接收到了参数: 123@qq.com
    代码块1接收到了参数: 456@qq,com
    代码块2接收到了参数: 456@qq,com
#>