# 来源
# https://www.pstips.net/powershell-func-filters-pipeline.html

# 软件路径
$soft_path = 'C:\JDK'

<#
    ⏹低效率的顺序模式
#>
function HighlightExeFile1() {

    # 保存当前控制台的前景色
    $oldColor1 = $Host.UI.RawUI.ForegroundColor

    <#
        通过循环逐条检查管道的结果
        $input 在函数或脚本块中使用,相当于外部传入的管道中的数据
    #>
    Foreach ($element in $input) {

        # 如果后缀名为.exe,设置为前景色为红色
        If ($element.name.toLower().endsWith(".exe")){
            $host.ui.Rawui.ForegroundColor = "red"
        } Else {
            # 否则恢复默认的前景色
            $host.ui.Rawui.ForegroundColor = $oldcolor1
        }

        # 输出元素
        "结果: $($element)"
    }

    # 最后，重置控制台的前景色:
    $host.ui.Rawui.ForegroundColor = $oldcolor1
}

# 统计该脚本执行的时间
$result1 = Measure-Command {
    Get-ChildItem -Path $soft_path -Recurse -File | HighlightExeFile1 | Out-Host
}
"HighlightExeFile1函数, 总共执行了: $($result1.TotalMilliseconds) 毫秒..."
# HighlightExeFile1函数, 总共执行了: 923.7821 毫秒...

if ('ConsoleHost' -eq $host.Name) {
    $host.UI.RawUI.ReadKey()
}