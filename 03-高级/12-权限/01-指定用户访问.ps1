# 查看当前电脑的所有本地用户
Get-LocalUser

# 创建文件夹
$path = "D:\PrivateFolder"
New-Item -ItemType Directory -Path $path -Force | Out-Null

# ###############################
# 禁用继承并删除继承权限
# icacls $path /inheritance:r
# ###############################

# 禁用继承但保留原有权限
icacls $path /inheritance:d | Out-Null

# 删除 B 用户权限
# icacls $path /remove "UserB"

# 给指定的用户完全的权限
icacls $path /grant "贾铭威:(OI)(CI)F" | Out-Null

# 删除默认用户组
icacls $path /remove "Users" | Out-Null
icacls $path /remove "Authenticated Users" | Out-Null