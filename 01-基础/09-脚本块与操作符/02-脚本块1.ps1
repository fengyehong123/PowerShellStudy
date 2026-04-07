# 来源
# https://www.pstips.net/powershell-using-scriptblocks.html

<#
    ⏹脚本块是一种特殊的命令模式。一个脚本块可以包含许多的 Powershell命令和语句。
    它通常使用大括号定义。最小最短的脚本块，可能就是一对大括号，中间什么也没有。

    可使用 & 操作符 来调用执行脚本块
#>
& {
    "当前时间为: $(Get-Date)" | Out-Host
    # 当前时间为: 06/15/2024 08:15:21
}

<#
    ⏹& 操作符只能执行一条命令,但是借助语句块就可以让操作符执行多条PowerShell命令
#>
& {
    $files = Get-ChildItem $PWD
    "文件数为: $($files.Count)" | Out-Host
}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹执行表达式 Invoke-Expression
        将一条字符串传递给调用操作符
    
    注意:
        下面这个字符串,需要使用单引号 ''
        如果使用双引号 "" 的话
        字符串中的 $_ 就会优先被执行
#>
$cmd_str = 'Get-Process | Where-Object { $_.Name -like "e*"}'
Invoke-Expression $cmd_str | Out-Host
<#
    Handles  NPM(K)    PM(K)      WS(K)     CPU(s)     Id  SI ProcessName
    -------  ------    -----      -----     ------     --  -- -----------
        128       8     1820       6652              4468   0 esif_uf
        528      20     7556      24152       0.47   5284   1 ETDCtrl
        119      10     2464       9872       0.05   6444   1 ETDCtrlHelper
        110       7     1180       5664              4592   0 ETDService
        116       8     1876       7156       0.03   7908   1 ETDTouch
        338      17     4852      14432              4488   0 EvtEng
        2931     108    84076     198572      46.22  7584   1 explorer
#>