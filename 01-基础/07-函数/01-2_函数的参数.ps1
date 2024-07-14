# ⏹必须参数：Mandatory
function Test-Func1 {
    # 推荐使用下面这种方式书写参数
    param (
        <#
            ⏹使用 [Parameter(Mandatory=$true)] 属性来指定参数为必需参数。
            这意味着调用函数或脚本时，如果未提供这些参数，将提示用户输入必需参数。
        #>
        [Parameter(Mandatory)]
        <#
            ⏹结合 ValidateNotNullOrEmpty 属性,对参数进一步验证
        #>
        [ValidateNotNullOrEmpty()]
        [string]$Name
        , $Color
    )

    "当前输入的Name参数为: $($Name)"
    "当前输入的Color参数为: $($Color)"
}

# ⭕调用函数时,只传入了 Color 参数,控制台会提示我们输入 Name参数的值
Test-Func1 -Color '绿色'
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹参数取值范围校验: ValidateSet
function Test-Func2 {
    param (
        [Parameter(Mandatory)]$Name
        , [ValidateSet('红色', '绿色', '蓝色')]$Color
    )

    "当前输入的Name参数为: $($Name)"
    "当前输入的Color参数为: $($Color)"
}

# ⭕调用函数,由于'黑色'并不是参数的取值范围,因此报错
try {
    Test-Func2 -Name '贾飞天' -Color '黑色'
} catch {
    Write-Host "程序发生异常,异常的原因是:$($_.Exception.Message)"
}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹参数校验脚本: ValidateScript
function Test-Func3 {
    param (
        # 通过自定义脚本片段的方式对参数进行校验
        [ValidateScript(
            {$_ % 2 -eq 0}
        )]
        [int]$Num
    )
}

# ⭕调用函数,由于 3 是偶数,因此脚本报错
try {
    Test-Func3 -Num 3
} catch {
    Write-Host "程序发生异常,异常的原因是:$($_.Exception.Message)"
}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹可变参数: ValueFromRemainingArguments
function Test-Func4 {
    param (
        [Parameter(Mandatory)]$Arg1
        # 指定可变参数
        , [Parameter(ValueFromRemainingArguments)]$ArgList
    )
    "传入的参数: $($Arg1)"
    "传入的其他参数: $(
        $ArgList | ForEach-Object {
            $_
        }
    )"
}

Test-Func4 -Arg1 1 2 3 4
<#
    传入的参数: 1
    传入的其他参数: 2 3 4
#>