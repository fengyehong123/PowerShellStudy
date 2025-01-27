# 为脚本导入 Windows.Forms 对象
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

# 创建文件夹对话框对象
$FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
# 打开对话框
$FolderBrowser.ShowDialog() | Out-Null

# 获取用户选择的文件夹路径并打印
$Path = $FolderBrowser.SelectedPath
Write-Host "用户选择的文件夹路径为: $Path"

Read-Host "按 Enter 键退出..."


New-PSDrive -PSProvider