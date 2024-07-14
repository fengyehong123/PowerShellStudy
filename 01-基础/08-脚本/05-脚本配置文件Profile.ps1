<#
    
    ⏹在 PowerShell 中，配置文件（Profile）脚本允许你在启动 PowerShell 时自动运行特定的命令、加载模块或设置环境。
    配置文件脚本通常用于设置自定义别名、函数、变量和环境设置，以便在启动 PowerShell 时自动加载。

    ⏹PowerShell 有多个配置文件脚本位置，每个位置对应不同的作用范围
        $PROFILE.AllUsersAllHosts
            所有用户和所有 PowerShell 主机应用程序的配置文件
        $PROFILE.AllUsersCurrentHost
            所有用户和当前 PowerShell 主机应用程序的配置文件
        $PROFILE.CurrentUserAllHosts
            当前用户和所有 PowerShell 主机应用程序的配置文件
        $PROFILE.CurrentUserCurrentHost
            当前用户和当前 PowerShell 主机应用程序的配置文件
#>

if (Test-Path -Path $PROFILE.CurrentUserAllHosts) {
    "该配置文件是否存在: $(Test-Path -Path $PROFILE.CurrentUserAllHosts)" | Out-Host
    # 该配置文件是否存在: True
}

<#
    我们可以在该配置文件(profile.ps1)中输入以下内容

        # 设置控制台的标题
        $host.UI.RawUI.WindowTitle = "Jmw PowerShell"

        # 定义自定义别名
        Set-Alias ll Get-ChildItem

        # 定义自定义函数
        function Hello-World {
            Write-Output "Hello, World!"
        }

        # 设置环境变量
        $env:my_name = "fengyehong"
    
    设置完成之后,当前用户的所有 PowerShell 控制台都可以使用该配置文件中的设置
    可以简化工作流程，自动加载常用的设置和脚本,提高工作效率
#>