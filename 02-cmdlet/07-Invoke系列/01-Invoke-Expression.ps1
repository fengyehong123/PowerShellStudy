# 动态执行命令
$command = "Get-Process | Where-Object { $_.CPU -gt 100 }"
Invoke-Expression -Command $command

# 执行外部脚本
Invoke-Expression -Command "C:\Scripts\myscript.ps1"

# 执行包含变量或表达式的命令
$computerName = "Server01"
Invoke-Expression -Command "Get-Service -ComputerName $computerName"
<#
    需要注意的是，由于 Invoke-Expression 可以执行任意字符串，因此在使用时需要确保执行的命令是安全可靠的，以避免安全风险。
    同时，推荐在可能的情况下使用更安全的方法，如使用命令替代符 & 或 . 来执行外部脚本。
#>