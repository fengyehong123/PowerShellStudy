# ============================
# 当前脚本的父级目录
# ============================
Write-Host $PSScriptRoot

# ============================
# 当前执行脚本的绝对路径
# ============================
Write-Host $PSCommandPath

# ============================
# PowerShell命令所在的路径
# ============================
# PowerShell的5.1版本
$PSHOME  # C:\Windows\System32\WindowsPowerShell\v1.0
# PowerShell7的版本
$PSHOME  # C:\Program Files\PowerShell\7

# ============================
# PowerShell Core    
#   返回 Core
# Windows PowerShell
#   返回 Desktop
# ============================
$PSEdition

# PowerShell7之后支持
# 判断运行的环境
$IsLinux
$IsMacOS
$IsWindows

# 获取PowerShell的版本情报
$PSVersionTable