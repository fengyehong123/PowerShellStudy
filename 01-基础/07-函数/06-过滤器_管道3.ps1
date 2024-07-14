# 来源
# https://www.pstips.net/powershell-func-filters-pipeline.html

# 软件路径
$soft_path = 'C:\JDK'

<#
    ⏹如果一个函数内部使用了管道，你就可以定义三个基础的任务区了：
        第一步，完成函数的初始化，完成函数执行的预备步骤;
            begin {}
        第二步处理递归调用所得的结果;
            process {}
        最后进行收尾工作。
            end {}
#>
function HighlightExeFile3() {
    begin {
        # 保存当前控制台的前景色
        $oldColor3 = $Host.UI.RawUI.ForegroundColor
    }
    process {
        If ($_.name.toLower().endsWith('.exe')) {
            $host.ui.Rawui.ForegroundColor = "red"
        } Else {
            # 否则恢复默认的前景色
            $host.ui.Rawui.ForegroundColor = $oldcolor3
        }
    
        # 输出元素
        "结果: $($_)"
    }
    end {
        # 最后，重置控制台的前景色:
        $host.ui.Rawui.ForegroundColor = $oldcolor3
    }
}

$result3 = Measure-Command {
    Get-ChildItem -Path $soft_path -Recurse -File | HighlightExeFile3 | Out-Host
}
"HighlightExeFile3函数, 总共执行了: $($result3.TotalMilliseconds) 毫秒..."


if ('ConsoleHost' -eq $host.Name) {
    $host.UI.RawUI.ReadKey()
}