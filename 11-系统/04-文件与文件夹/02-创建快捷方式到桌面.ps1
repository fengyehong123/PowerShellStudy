# 构造快捷方式的路径
$shortcutPath = Join-Path -Path ([Environment]::GetFolderPath("Desktop")) -ChildPath 'EditorStart.lnk'

# 创建 WScript.Shell COM 对象
$wshShell = New-Object -ComObject WScript.Shell

# 创建快捷方式
$shortcut = $wshShell.CreateShortcut($shortcutPath)
# 设置快捷方式的目标路径,图标,描述
$shortcut.targetpath = "notepad.exe"
$shortcut.IconLocation = "notepad.exe,0"
$shortcut.Description = "测试创建快捷方式"

# 保存快捷方式
$shortcut.Save()

# 关闭
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($wshShell) | Out-Null

# 封装为函数
function New-DesktopShortcut {

    param (
        [string]$TargetPath,
        [string]$ShortcutName
    )

    # 拼接桌面快捷方式的路径
    $desktop = [Environment]::GetFolderPath("Desktop")
    $shortcutPath = Join-Path $desktop ($ShortcutName + ".lnk")

    # 创建WScript对象
    $wsh = New-Object -ComObject WScript.Shell
    # 保存快捷方式
    $shortcut = $wsh.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $TargetPath
    $shortcut.Save()

    # 释放WScript对象
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($wsh) | Out-Null

}