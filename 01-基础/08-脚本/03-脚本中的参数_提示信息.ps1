param(
    <#
        [CmdletBinding()] 属性
            1. 将函数或脚本块标记为高级函数，使其行为类似于 PowerShell cmdlet
            2. 允许使用 CmdletBinding 提供的功能
               如支持 -Verbose、-Debug、-ErrorAction、-WarningAction 等标准参数
    #>
    [CmdletBinding()]

    # 指定name参数为必须参数,在调用脚本时会有输入name参数的提示小时
    [Parameter(
        Mandatory = $true
        , HelpMessage = '请输入姓名：'
    )]
    <#
        给参数设置别名
            . '路径/脚本名.ps1' -name 贾飞天
            . '路径/脚本名.ps1' -student_name 贾飞天
        以上两种参数名都可以指定 name 参数
    #> 
    [Alias('student_name')]
    [string]$name,

    # 指定参数的值只能为 10 或者 20
    [validateSet(10, 20)] 
    # 为参数指定默认值
    [int]$age = 20
)

<#
    $PSBoundParameters 是一个自动变量，它是一个包含当前命令调用时绑定的所有参数的哈希表。
    它主要用于函数和脚本中的参数处理和验证。
#>
# 打印所有指定的参数
$PSBoundParameters | Out-Host
# 如果没有指定 age 参数的话,就提示,然后终止脚本的运行
if (-not $PSBoundParameters.ContainsKey('age')) {
    Write-Host '请输入age参数!' -ForegroundColor Blue
    return
}

@"
姓名为: $($name)
年龄为: $($age)
"@

Pause