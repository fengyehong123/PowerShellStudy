<#
    #Requires 是 PowerShell 脚本中的一个前置条件声明指令，用于在脚本运行前检查环境是否满足要求。
    如果不满足，脚本会直接停止执行并报错。可以理解为：「运行脚本之前先做环境校验」。

    注意：
        1. 必须写在脚本最前面
        2. 只对脚本文件有效, 在控制台上使用无效
#>
# 要求PowerShell版本 >= 6.0 , 否则会直接报错
#Requires -Version 6.0
# 脚本需要以管理员运行, 否则会提示报错
#Requires -RunAsAdministrator
# 要求必须安装ImportExcel模块, 对版本没有约束
#Requires -Modules ImportExcel
# 要求必须安装指定版本的模块
#Requires -Modules @{ModuleName = "AWSpowerShell.NetCore"; ModuleVersion = "3.3.253.0"}

Write-Host "脚本执行成功..."
Pause