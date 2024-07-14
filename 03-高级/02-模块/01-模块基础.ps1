# 查看系统中是否安装了 PowerShellGet 模块
Get-Module -ListAvailable -Name PowerShellGet

# 安装模块(全局安装,需要有管理员权限)
Install-Module -Name Microsoft.PowerShell.SecretManagement -Force -AllowClobber

# 给当前用户安装模块
Install-Module -Name Microsoft.PowerShell.SecretManagement -Force -AllowClobber -Scope CurrentUser

# 卸载模块
Uninstall-Module -Name Microsoft.PowerShell.SecretManagement

# 获取模块的帮助
Get-Help Microsoft.PowerShell.SecretManagement -Detailed

# 查看模块的安装路径
$env:PSModulePath