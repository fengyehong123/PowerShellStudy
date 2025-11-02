# 为脚本导入 Windows.Forms 对象
using namespace System.Windows.Forms
Add-Type -AssemblyName System.Windows.Forms

[Application]::EnableVisualStyles()

# 创建文件夹对话框对象
$FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
# 打开对话框
$FolderBrowser.ShowDialog() | Out-Null

# 获取用户选择的文件夹路径并打印
$Path = $FolderBrowser.SelectedPath
Write-Host "用户选择的文件夹路径为: $Path"

# ------------------------------------------------------------------------------------------------------------------

# 创建文件对话框对象
$fileDialog = New-Object System.Windows.Forms.OpenFileDialog
# 设置过滤条件
$fileDialog.Filter = "文本文件 (*.txt)|*.txt|所有文件 (*.*)|*.*"

if ($fileDialog.ShowDialog() -eq [DialogResult]::OK) {
    Write-Host "选择的文件是: $($fileDialog.FileName)"
}

Read-Host "按 Enter 键退出..."