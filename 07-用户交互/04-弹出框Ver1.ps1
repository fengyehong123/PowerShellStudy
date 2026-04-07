# 导入并且使用 Windows.Forms
using namespace System.Windows.Forms
Add-Type -AssemblyName System.Windows.Forms

[MessageBox]::Show("操作完成！", "提示", [MessageBoxButtons]::OK, [MessageBoxIcon]::Information)

# 可以封装一个弹出消息的函数
function Show-MessageBox {
    
    param (
        [string]$Message,
        [string]$Title = "提示",
        [MessageBoxButtons]$Buttons = "OK",
        [MessageBoxIcon]$Icon = "Information"
    )

    [MessageBox]::Show($Message, $Title, $Buttons, $Icon)
}

# 调用示例
Show-MessageBox "操作完成！"