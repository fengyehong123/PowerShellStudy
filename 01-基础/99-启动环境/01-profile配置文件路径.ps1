# ===========================================
# $PROFILE
#   PowerShell启动时, 自动读取的配置文件路径
# ===========================================

# ==============
# 🔷所有用户
# ==============
# 所有用户和所有 PowerShell 主机应用程序的配置文件。
$PROFILE.AllUsersAllHosts  # C:\Program Files\PowerShell\7\profile.ps1
# 所有用户和当前 PowerShell 主机应用程序的配置文件。
$PROFILE.AllUsersCurrentHost  # C:\Program Files\PowerShell\7\Microsoft.PowerShell_profile.ps1

# ==============
# 🔷当前用户
# ==============
# 当前用户和所有 PowerShell 主机应用程序的配置文件。
$PROFILE.CurrentUserAllHosts  # C:\Users\【用户名】\Documents\PowerShell\profile.ps1
# 当前用户和当前 PowerShell 主机应用程序的配置文件。
$PROFILE.CurrentUserCurrentHost  # C:\Users\【用户名】\Documents\PowerShell\Microsoft.PowerShell_profile.ps1