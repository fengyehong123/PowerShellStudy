# 来源
# https://www.pstips.net/powershell-switch-loop.html

<#
    ⏹Powershell中由于Switch支持集合，所以也可以使用它进行循环处理
#>

# 定义一个数组
$arr = 1..6

# 使用switch循环
switch ($arr) {
    # 直接循环,没有使用条件,因此使用Default关键字
    Default {
        "当前输出的数字为: $($_)"
    }
}
<#
    当前输出的数字为: 1
    当前输出的数字为: 2
    当前输出的数字为: 3
    当前输出的数字为: 4
    当前输出的数字为: 5
    当前输出的数字为: 6
#>

switch ($arr) {

    # 相当于for循环中的if条件判断
    {($_ % 2) -eq 0} {
        "$($_) 偶数"
    }
    {($_ % 2) -ne 0} {
        "$($_) 奇数"
    }
}