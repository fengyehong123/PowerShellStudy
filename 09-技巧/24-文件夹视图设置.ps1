# 文件夹视图设置的注册表路径
$folderSettingPath = "Registry::\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

# 设置“显示已知文件类型的扩展名” → 0 = 显示扩展名，1 = 隐藏扩展名
New-ItemProperty -LiteralPath "${folderSettingPath}" -Name "HideFileExt" -PropertyType "DWord" -Value "0" -Force

# 设置“显示隐藏的文件、文件夹和驱动器” → 1 = 显示，2 = 不显示
New-ItemProperty -LiteralPath "${folderSettingPath}" -Name "Hidden" -PropertyType "DWord" -Value "1" -Force
