<#
    需要以管理员权限运行脚本
#>
$SmbShareName = "Desktop"
# 获取当前用户的桌面目录
$user_desktop_path = [Environment]::GetFolderPath('Desktop')

# 共享当前用户的桌面, 管理员拥有全部的权限, 普通用户拥有读写的权限
New-SmbShare -Name "$SmbShareName" -Path "$user_desktop_path " -FullAccess "administrator" -ChangeAccess "users"

# 为共享添加描述
Set-SmbShare -Name "$SmbShareName" -Description "桌面共享"

# 查看创建好的共享
Get-SmbShare -Name "$SmbShareName"

# 删除指定的共享
# Remove-SmbShare -Name "$SmbShareName" -Force
