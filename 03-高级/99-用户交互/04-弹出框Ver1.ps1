# 导入并且使用 Windows.Forms
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show("操作完成！", "提示", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)

# 可以封装一个弹出消息的函数
function Show-MessageBox {
    param (
        [string]$Message,
        [string]$Title = "提示",
        [System.Windows.Forms.MessageBoxButtons]$Buttons = "OK",
        [System.Windows.Forms.MessageBoxIcon]$Icon = "Information"
    )
    Add-Type -AssemblyName System.Windows.Forms -ErrorAction SilentlyContinue
    [System.Windows.Forms.MessageBox]::Show($Message, $Title, $Buttons, $Icon)
}

# 调用示例
Show-MessageBox "操作完成！"