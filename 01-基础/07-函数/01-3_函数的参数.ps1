function TestFuc {

    param(
        [ref]$my_name
    )

    process {
        $my_name.Value = '默认值'
        return "参数的值为: $($my_name.Value)"
    }
}

# 定义一个变量
$name = '张三'

<#
    调用函数
        因为给参数标记了 [ref] 参数传递就变成了 地址传递
        因此在函数内部对变量的值进行修改也会影响到函数外部的变量
#>
TestFuc([ref]$name) | Out-Host  # 参数的值为: 默认值

# 查看变量值
$name | Out-Host  # 默认值