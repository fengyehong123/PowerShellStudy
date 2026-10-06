# 后缀名字
$ext = ".ttl2"
# 注册表中指定后缀所关联的自定义程序id
$progId = "TeraTermFile${ext}"

# 后缀所在的当前用户的注册表路径
$ClassPath = "HKCU:\Software\Classes"
# TeraTerm的宏程序路径
$TeraTermMacroPath = "C:\soft\teraterm5.5\ttpmacro.exe"

# 新后缀的注册表路径
$ExtRegistryPath = "$ClassPath\$ext"
# 设置新后缀关联的文件图标的注册表路径
$ProgIdIconRegistryPath = "$ClassPath\$progId\DefaultIcon"

# 设置文件图标
New-Item -Path "$ProgIdIconRegistryPath" -Force | Out-Null
# 0或1 分别代表2种不同的图标, 后续TeraTerm版本的话, 还可以使用3
Set-ItemProperty -Path "$ProgIdIconRegistryPath" -Name "(Default)" -Value "`"$TeraTermMacroPath`",1" | Out-Null

# 将新后缀与程序关联起来
New-Item -Path "$ExtRegistryPath" -Force | Out-Null
Set-ItemProperty -Path "$ExtRegistryPath" -Name "(Default)" -Value "$progId" | Out-Null

# 菜单的注册表路径
$ProgIdRegistryPath = "$ClassPath\$progId\shell\OpenWithTeraTerm"
# 创建新的文件后缀对应的程序项目
New-Item -Path "$ProgIdRegistryPath\command" -Force | Out-Null
# 设置菜单名称
Set-ItemProperty -Path "$ProgIdRegistryPath" -Name "(Default)" -Value "使用 TeraTerm 打开" | Out-Null
# 菜单图标
Set-ItemProperty -Path "$ProgIdRegistryPath" -Name "Icon" -Value $TeraTermMacroPath | Out-Null
# 菜单位置
Set-ItemProperty -Path "$ProgIdRegistryPath" -Name "Position" -Value "Top" | Out-Null
# 设置菜单对应的程序, %1 代表当前要执行的脚本路径
Set-ItemProperty -Path "$ProgIdRegistryPath\command" -Name "(Default)" -Value "`"$TeraTermMacroPath`" `"%1`"" | Out-Null

<#
    1. EntryPoint="SHChangeNotify" 用来指定【Windows Shell】的名称
    这样我们就可以自定义函数名为: RefreshIcons
    如果不在 DllImport 处, 通过EntryPoint来声明方法名的话, 我们的函数名就需要和【Windows Shell】的名称, 即 SHChangeNotify 保持一致

    2. SHChangeNotify 是 Windows Shell 的一个通知函数
    用来告诉系统“某种外观或状态发生了变化”，比如文件图标、文件夹结构、快捷方式等。
    调用它的好处是：
        让资源管理器和桌面立即刷新显示，而不用手动重启资源管理器。
#>
Add-Type @"
using System;
using System.Runtime.InteropServices;

public class WindowsAPI {
    [DllImport("shell32.dll", EntryPoint="SHChangeNotify")] 
    public static extern void RefreshIcons(int wEventId, int uFlags, IntPtr dwItem1, IntPtr dwItem2);
}
"@
[WindowsAPI]::RefreshIcons(0x08000000, 0x0000, [IntPtr]::Zero, [IntPtr]::Zero)