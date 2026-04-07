# 来源
# https://www.pstips.net/powershell-define-fault-tolerance.html

<#
    ⏹$ErrorView 是一个 PowerShell 变量，用于控制错误消息的显示格式。
    可以通过设置 $ErrorView 来更改 PowerShell 输出错误消息的方式。
        NormalView：
            默认设置，显示详细的错误信息，包括错误类型、错误消息、行号等。
        CategoryView：
            显示简化的错误信息，按错误类别分类。
#>
# 查看当前系统的错误消息显示格式
$ErrorView | Out-Host  # NormalView
# 修改当前系统的错误消息显示格式
$ErrorView = "CategoryView"
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 尝试删除一个不存在的路径后,打印消息
Remove-Item '/test/path'
Write-Host '发送是否删除成功的邮件...'
<#
    ObjectNotFound: (C:\test\path:String) [Remove-Item], ItemNotFoundException
    发送是否删除成功的邮件...
#>
Write-Host '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' -ForegroundColor Blue

<#
    ⏹通过 ErrorAction 配置项 指定某条命令出错后,对应的处理模式
        Continue	
            将错误抛出来，但是脚本会继续往下执行。
        Inquire	
            提供选项由用户选择Error Action。
        SilentlyContinue
            错误不抛出，脚本也会继续执行。
        Stop	
            错误发生时，终止脚本执行

    ⏹每次指定命令都要去指定 ErrorAction 很繁琐,可以使用全局设置 $ErrorActionPreference
       甚至还可以针对某段函数，某个脚本设置$ErrorActionPreference
#>
Remove-Item '/test/path' -ErrorAction Stop
# 因为上一行代码设置了 -ErrorAction Stop 并且代码报错,因此下面的打印代码不会被执行
Write-Host '路径不存在啊...............'
