<#
    让 PowerShell 代码中的 System.Windows.Forms 里的类可以直接使用，
    而不需要写完整的命名空间（即 System.Windows.Forms.MessageBox 变成 MessageBox）
#>
using namespace System.Windows.Forms
<#
    告诉 PowerShell 加载 System.Windows.Forms.dll 这个程序集，否则 MessageBox 相关的类和方法无法使用。
#>
Add-Type -AssemblyName System.Windows.Forms

<#
    [MessageBoxButtons]::OK	只显示 “确定” 按钮
    [MessageBoxButtons]::OKCancel	显示 “确定” 和 “取消” 按钮
    [MessageBoxButtons]::YesNo	显示 “是” 和 “否” 按钮
    [MessageBoxButtons]::YesNoCancel	显示 “是”、“否” 和 “取消” 按钮

    [MessageBoxIcon]::None	不显示图标
    [MessageBoxIcon]::Information	显示 ℹ️（信息图标）
    [MessageBoxIcon]::Warning	显示 ⚠️（警告图标）
    [MessageBoxIcon]::Error	显示 ❌（错误图标）
    [MessageBoxIcon]::Question	显示 ❓（问号图标）
#>
[MessageBox]::Show("操作完成！", "提示", [MessageBoxButtons]::OK, [MessageBoxIcon]::Information)

# -----------------------------------------------------------

# 导入并且使用 Windows Presentation Foundation (WPF)
Add-Type -AssemblyName PresentationFramework
# 创建消息框
[System.Windows.MessageBox]::Show("这是一个消息框！", "标题")

Read-Host "按 Enter 键退出..."
