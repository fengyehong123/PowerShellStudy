# 定义注册表路径
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"

# 如果路径不存在就创建
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# 经典桌面图标对应的 GUID
$icons = @{
    "ThisPC"        = "{20D04FE0-3AEA-1069-A2D8-08002B30309D}"  # 此电脑
    "ControlPanel"  = "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}"  # 控制面板
    "Network"       = "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}"  # 网络
    "UserFiles"     = "{59031a47-3f72-44a7-89c5-5595fe6b30ee}"  # 用户文件
    "RecycleBin"    = "{645FF040-5081-101B-9F08-00AA002F954E}"  # 回收站
}

# 设置所有图标显示 (值为 0 = 显示, 1 = 隐藏)
foreach ($guid in $icons.Values) {
    Set-ItemProperty -Path $regPath -Name $guid -Value 0 -Force
}

# 重启 Explorer 以刷新桌面
Stop-Process -Name explorer -Force