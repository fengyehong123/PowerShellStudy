# 来源
# https://www.pstips.net/powershell-call-operator.html

<#
    Get-ChildItem
        将他放入字符串中直接输出的话,会被当做字符串进行输出
#>
$cmd1 = 'Get-ChildItem'
$cmd1 | Out-Host  # Get-ChildItem

<#
    ⏹通过 & 进行调用的话,该操作符会把字符串直接解释成命令并执行
#>
& $cmd1
<#
    Mode                 LastWriteTime         Length Name
    ----                 -------------         ------ ----
    d-----          2024/5/6     18:58                .vscode
    d-----         2024/6/15      6:47                01-基础
    d-----         2024/5/25     14:14                02-cmdlet
    d-----          2024/5/8     21:53                day01
    d-----         2024/5/25     20:03                day02
    -a----         2024/6/11     21:38            962 Error.txt
    -a----         2024/6/11     21:38          55896 Home_file.txt
    -a----          2024/6/8      9:58           3867 笔记.md
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹通过 & 操作符只能接受单个命令
    如果是多个命令组合话,程序会报错

    原因:
        在powershell中通过 & 操作符 调用的时候,
        首先会使用get-command去发现命令是否可用,
        而get-command的确只支持单独的一条命令,不支持命令串或者脚本串
#>
$cmd2 = 'Get-ChildItem $Home'
try {
    & $cmd2
} catch {
    "程序报错,原因是: $($_.Exception.Message)" | Out-Host
    # 程序报错,原因是: 无法将“Get-ChildItem $Home”项识别为 cmdlet、函数、脚本文件或可运行程序的名称。请检查名称的拼写，如果包括路径，请确保路径正确，然后再试一次。
}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹& 操作符可以直接执行一个CommandInfo对象,绕过自身的内部get-command
#>
$path1 = "$HOME\Desktop\Powershell_Study\01-基础\08-脚本\01-执行策略.ps1"
$cmd3 = Get-ChildItem $path1

Write-Host '⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓⇓' -ForegroundColor DarkYellow
# 调用其他脚本
& $cmd3
Write-Host '⇑⇑⇑⇑⇑⇑⇑⇑⇑⇑⇑⇑⇑⇑⇑⇑⇑⇑⇑⇑' -ForegroundColor DarkYellow
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹通过命令名称唯一标识一条命令
        可能存在
            别名
            命令
            函数
        的的名称一样的情况
        Powershell会通过优先级别来确定先执行哪个
    
    ⏹优先级
        Alias(1)
        Function(2)
        Filter(2)
        Cmdlet(3)
        Application(4)
        ExternalScript(5)
        Script (-)
#>
# 自定义一个Ping函数
function Ping() {
    '我是自定义的Ping函数...'
}
# 给Ping函数取一个别名
Set-Alias -Name Ping -Value echo
<#
    此时在Powershell中一共有3个Ping
    1. 为echo命令取的别名 Ping
    2. 自定义的Ping函数
    3. C:\WINDOWS\system32\PING.EXE
#>

# 因为别名的优先级最高,所以先执行别名Ping
Get-Command Ping | Select-Object CommandType, Name, Definition | Out-Host
<#
    CommandType Name Definition
    ----------- ---- ----------
          Alias Ping echo
#>
Ping "测试我的Ping,估计执行的别名echo" | Out-Host  # 测试我的Ping,估计执行的别名echo
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 将别名Ping删除之后,函数Ping的优先级 > PING.EXE,所以自定义Ping函数的返回值被打印到控制台上
Remove-Item Alias:Ping
Get-Command Ping | Select-Object CommandType, Name, Definition | Out-Host
<#
    CommandType Name Definition
    ----------- ---- ----------
       Function Ping ...
#>
Ping | Out-Host  # 我是自定义的Ping函数...
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 删除自定义函数Ping之后,PING.EXE才会起作用
Remove-Item Function:Ping
Get-Command Ping | Select-Object CommandType, Name, Definition | Out-Host
<#
    CommandType Name     Definition
    ----------- ----     ----------
    Application PING.EXE C:\WINDOWS\system32\PING.EXE
#>
Ping www.baiu.com
<#
    正在 Ping www.baiu.com [120.78.212.208] 具有 32 字节的数据:
    来自 120.78.212.208 的回复: 字节=32 时间=116ms TTL=50
    来自 120.78.212.208 的回复: 字节=32 时间=121ms TTL=50
    来自 120.78.212.208 的回复: 字节=32 时间=98ms TTL=50
    来自 120.78.212.208 的回复: 字节=32 时间=97ms TTL=50

    120.78.212.208 的 Ping 统计信息:
        数据包: 已发送 = 4，已接收 = 4，丢失 = 0 (0% 丢失)，
    往返行程的估计时间(以毫秒为单位):
        最短 = 97ms，最长 = 121ms，平均 = 108ms
#>