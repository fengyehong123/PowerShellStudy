# 来源
# https://www.pstips.net/powershell-drive-variables.html

<#
    ⏹Powershell中所有 不是 我们自己的定义的变量都属于驱动器变量（比如环境变量）
        它的前缀只是提供给我们一个可以访问信息的虚拟驱动器，例如 env:windir

    ⏹可以通过 Get-PSDrive 查看powershell支持的所有驱动器
        驱动器是一种虚拟设备,用于访问不同数据存储位置的方式
        比如文件系统、注册表、环境变量等

    ⏹常见的 PowerShell 驱动器
        C
            文件系统的根目录(通常是系统安装的主要硬盘)
        D
            其他硬盘分区或挂载的设备
        Variable
            用于访问和管理变量
        Function
            用于访问和管理函数
        Alias
            用于访问和管理别名
        Env
            用于访问和管理环境变量
#>

# 获取当前会话中的所有驱动器
Get-PSDrive
Write-Host '-------------------------------'

# 获取特定类型的驱动器 ⇒ 系统驱动器
Get-PSDrive -PSProvider FileSystem
Write-Host '-------------------------------'

# 获取特定名称的驱动器 ⇒ 环境变量驱动器
Get-PSDrive -Name Env