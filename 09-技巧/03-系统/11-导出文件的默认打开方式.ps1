$desktopPath = [Environment]::GetFolderPath("Desktop")

<#
    要执行的 dism 命令
        将文件后缀关联的软件映射关系导出到当前用户桌面文件夹
#>
$dismCmd = "dism /online /Export-DefaultAppAssociations:`"$desktopPath\defaults.xml`""

# 调用管理员 PowerShell 执行 命令
Start-Process -FilePath "powershell.exe" `
    -ArgumentList "-NoProfile -Command `"$dismCmd`"" `
    -Verb RunAs

Write-Host "XML文件导出成功!" -ForegroundColor Green

Pause
