# 获取桌面路径
$desktopPath = [Environment]::GetFolderPath("Desktop")

# 上帝模式文件夹名称
$godModeName = "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
# 拼接完整路径
$godModePath = Join-Path $desktopPath $godModeName

# 判断是否已存在
if (Test-Path $godModePath) {
    Write-Host "上帝模式文件夹已经存在：" -ForegroundColor Yellow
    Write-Host $godModePath
    Pause
    return
}

# 创建文件夹
New-Item -ItemType Directory -Path $godModePath | Out-Null
Write-Host "上帝模式创建成功！" -ForegroundColor Green
Write-Host $godModePath