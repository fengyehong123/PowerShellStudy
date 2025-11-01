# $PSVersionTable 自动变量包含关于当前 PowerShell 版本及其组件的详细信息
$PSVersionTable | Out-Host

# 判断当前powershell是64位, 还是32位
$result = [Environment]::Is64BitProcess
if ($result) {
    Write-Host "正在运行64位的PowerShell"
    return
}

Write-Host "正在运行32位的PowerShell"