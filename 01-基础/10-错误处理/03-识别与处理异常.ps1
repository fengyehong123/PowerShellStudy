# 来源
# https://www.pstips.net/powershell-recognize-and-response-errors.html

<#
    ⏹在PowerShell中, $? 是一个自动变量,用于指示前一个命令的执行状态
    该变量是一个布尔值
        如果前一个命令成功执行（没有错误），$? 的值为 True。
        如果前一个命令失败（有错误），$? 的值为 False。
#>

# ⏹使用 -ErrorAction SilentlyContinue 抑制错误信息输出
Remove-Item -Path 'test/path/fengyehong' -ErrorAction SilentlyContinue
# 由于前一条命令执行失败,因此 $? 的值变为 false
if (!$?) {
    Write-Host '文件删除失败!' -ForegroundColor Green | Out-Host
} else {
    Write-Host '文件删除成功!'
}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹使用Traps可以捕获异常，在捕获到异常时，可以在做相应的处理。
#>
Trap {
    Write-Host '异常发生,以发送邮件联系系统管理员...' -ForegroundColor DarkYellow | Out-Host
    "异常的详细信息为: $($_.Exception)" | Out-Host
    Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red
    <#
        不使用关键字,或使用 continue 关键字,可让程序继续执行
        如果使用 break 关键字,会让程序停止运行
    #>
    continue
}

1 / 0
'我发生在 1 / 0 的异常之后,我可以正常执行!' | Out-Host
Write-Host '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' -ForegroundColor DarkGreen

<#
    ⏹使用try catch 代码块来处理异常
    并且可以通过 异常的类型 来捕获特定的异常
#>
try {
    <#
        Powershell中默认情况下许多命令只会引发非终止性错误，非终止性错误不会触发 catch 块。
        为了捕获这些错误，你需要将它们转换为终止性错误。
        这可以通过将 -ErrorAction 参数设置为 Stop 来实现。
    #>
    Get-Content -Path "C:\NonExistentFile.txt" -ErrorAction Stop
} catch [System.Management.Automation.ItemNotFoundException] {
    # 如果 Get-Content 没有指定 -ErrorAction Stop, 则catch块中的异常捕获不会被触发
    "文件无法被找到: $($_.Exception.Message)" | Out-Host
} catch {
    "发生了其他错误: $($_)" | Out-Host
} finally {
    'finally代码块中的代码执行' | Out-Host
}