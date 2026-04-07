# 菜单名称
$MenuName = "开发者工具"
# 菜单图标
$MenuIcon = "shell32.dll,60"

# 子菜单列表
$SubMenus = @(
    @{
        Icon = "cmd.exe"
        Name = "命令提示符"
        Command = 'cmd.exe /k cd /d "%V"'
    },
    @{
        Icon = "powershell.exe"
        Name = "PowerShell"
        Command = 'powershell.exe -NoExit -Command Set-Location "%V"'
    },
    @{
        Icon = "code.exe"
        Name = "Visual Studio Code"
        # 写全路径, 防止从环境变量中找不到 Code.exe
        Command = 'C:\软件\VSCode\Microsoft VS Code\Code.exe "%V"'
    }
)

# 需要创建的主菜单路径（桌面空白 + 文件夹空白）
$MenuPaths = @(
    "HKCU:\Software\Classes\DesktopBackground\Shell\DevTools",
    "HKCU:\Software\Classes\Directory\Background\shell\DevTools"
)

<#
    Windows 仅支持系统级(HKLM) CommandStore 自动解析 SubCommands
    当前用户 (HKCU) 路径下的 CommandStore\shell 项虽然可以创建，但 资源管理器不会去查找 这个路径。
    资源管理器只会去查找
        HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell
    因此当我们没有权限将子命令写到系统级注册表中时
    可以使用 ExtendedSubCommandsKey 写到当前用户的注册表中
#>
foreach ($MenuPath in $MenuPaths) {

    # 创建主菜单
    New-Item -Path $MenuPath -Force | Out-Null
    Set-ItemProperty -Path $MenuPath -Name "MUIVerb" -Value $MenuName
    Set-ItemProperty -Path $MenuPath -Name "Icon" -Value $MenuIcon
    Set-ItemProperty -Path $MenuPath -Name "Position" -Value "Top"
    # 设置主菜单和子菜单关联
    New-ItemProperty -Path $MenuPath -Name "SubCommands" -Value "" -PropertyType String -Force | Out-Null
    # 将子命令写到当前用户的注册表中
    New-ItemProperty -Path $MenuPath -Name "ExtendedSubCommandsKey" -Value $MenuPath -PropertyType String -Force | Out-Null

    # 循环创建子菜单
    foreach ($item in $SubMenus) {

        # 创建子菜单
        $subPath = "$MenuPath\shell\$($item.Name)"
        New-Item -Path $subPath -Force | Out-Null
        # 设置子菜单名称
        Set-ItemProperty -Path $subPath -Name "MUIVerb" -Value $item.Name
        # 设置子菜单图标
        Set-ItemProperty -Path $subPath -Name "Icon" -Value $item.Icon

        # 创建子菜单的命令
        $cmdPath = "$subPath\command"
        New-Item -Path $cmdPath -Force | Out-Null
        # 设置子菜单命令
        Set-ItemProperty -Path $cmdPath -Name "(Default)" -Value $item.Command
    }
}

Write-Host "当前用户右键菜单『$MenuName』已成功创建(含子菜单)"
