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
# 可选值为0或1 分别代表2种不同的图标
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

# 重启资源管理器
Stop-Process -Name explorer -Force | Out-Null