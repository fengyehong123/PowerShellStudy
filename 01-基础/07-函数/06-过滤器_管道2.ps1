# 来源
# https://www.pstips.net/powershell-func-filters-pipeline.html

# 软件路径
$soft_path = 'C:\JDK'

<#
    ⏹将 function 关键字替换为 filter
    powershell会进行流模式处理
    可以递归处理全盘目录,可以处理庞大的数据
#>
Filter HighlightExeFile2() {

    # 保存当前控制台的前景色
    $oldColor2 = $Host.UI.RawUI.ForegroundColor

    <#
        过滤器自身已经扮演了循环的角色,没有必要再写专门的循环处理
        $_ 就相当于当前处理的数据
    #>
    If ($_.name.toLower().endsWith('.exe')) {
        $host.ui.Rawui.ForegroundColor = "red"
    } Else {
        # 否则恢复默认的前景色
        $host.ui.Rawui.ForegroundColor = $oldcolor2
    }

    # 输出元素
    "结果: $($_)"

    # 最后，重置控制台的前景色:
    $host.ui.Rawui.ForegroundColor = $oldcolor2
}

$result2 = Measure-Command {
    Get-ChildItem -Path $soft_path -Recurse -File | HighlightExeFile2 | Out-Host
}
"HighlightExeFile2函数, 总共执行了: $($result2.TotalMilliseconds) 毫秒..."

if ('ConsoleHost' -eq $host.Name) {
    $host.UI.RawUI.ReadKey()
}