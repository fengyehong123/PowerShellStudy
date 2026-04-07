<#
    ⏹导入模块
        模块中的 Tst-Greeting 不符合 Get-Verb 命名规范
        可使用 -Verbose 参数来运行 Import-Module 命令，可以提供详细的信息
        帮助你诊断和解决模块导入时的警告或错误。

    ⏹$PSScriptRoot 自动变量
        包含当前脚本文件所在的目录路径。
        在模块开发中尤其有用，因为它允许你引用与脚本文件位于相同目录中的其他文件或资源，
        而不需要使用绝对路径。
    
    ⏹下面这种写法是导入模块中导出的全部内容
#>
Import-Module "$($PSScriptRoot)\Modules\01-Get-Greeting.psm1" -Verbose

# 使用模块中导出的函数
Get-ChineseGreeting -keyword '世界' | Out-Host
Get-JapaneseGreeting -keyword 'せかい' | Out-Host

<#
    ⏹02-Get-Info.psm1模块中导出了2个函数
    但是我们导入的时候,只导入了一个函数
#>
Import-Module "$($PSScriptRoot)\Modules\02-Get-Info.psm1" -Function Get-Info1

# ⏹执行从模块中导入的函数
Get-Info1 -keyword '测试Info1...'

# ⏹由于下面的函数没有从模块中导入,所以被catch住
try {
    Get-Info2 -keyword '测试Info2...'    
} catch {
    'Get-Info2这个函数不存在,请确认模块是否已经导入...'
}