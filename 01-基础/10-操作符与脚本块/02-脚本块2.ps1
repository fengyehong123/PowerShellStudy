# 来源
# https://www.pstips.net/powershell-using-scriptblocks.html

<#
    ⏹函数本身也是一个已命名的语句块
#>

# 定义一个函数
function SayHello {
    param(
        [string]$name = '每一个人!'
    )
    "你好啊, $($name)" | Out-Host
}

# 通过函数来调用
SayHello '贾飞天!'  # 你好啊, 贾飞天!
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹存储函数的引用
$func1 = Get-Command SayHello
# 通过操作符来调用函数并传递参数
& $func1 '枫叶红'  # 你好啊, 枫叶红
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹脚本块也可以实现函数的特性,类似于匿名函数
#>
$scriptblock = {
    # 参数区域
    param(
        [string]$name = '~每一个人~'
    )
    "Hello, $($name)" | Out-Host
}
# 通过 & 操作符调用脚本块
& $scriptblock  # Hello, ~每一个人~
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹通过 .Invoke() 的方式调用脚本块
$func2 = {
    param(
        [string]$name = '默认名'
    )
    # 在脚本块中调用自定义的函数
    SayHello $name
}
$func2.Invoke('张三李四王五!')
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    Invoke-Command 是 PowerShell 中用于执行命令或脚本块的强大命令。
    通常用于在本地或远程计算机上运行脚本或命令。
#>
Invoke-Command -ScriptBlock $scriptblock -ArgumentList '剑寒春水'  # Hello, 剑寒春水
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red


