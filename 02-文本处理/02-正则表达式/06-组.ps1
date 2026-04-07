# 来源
# https://www.pstips.net/regex-form-group.html

<#
    ⏹匹配由TAB分隔的2个字符串
    .* 表示 匹配任意数量的字符(包括0个字符)
#>
$pattern1 = "(.*)\t(.*)"
# `t 表示TAB分隔符
$str1 = "2024/06/19`t一些内容"

$result = ([regex]$pattern1).Matches($str1)
# ⏹查看匹配到的整个组
$result.Groups | Out-Host
<#
    Groups   : {0, 1, 2}
    Success  : True
    Name     : 0
    Captures : {0}
    Index    : 0
    Length   : 15
    Value    : 2024/06/19   一些内容

    Success  : True
    Name     : 1
    Captures : {1}
    Index    : 0
    Length   : 10
    Value    : 2024/06/19

    Success  : True
    Name     : 2
    Captures : {2}
    Index    : 11
    Length   : 4
    Value    : 一些内容
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹查看匹配到的各个组
$result.Groups[1].Value | Out-Host  # 2024/06/19
$result.Groups[2].Value | Out-Host  # 一些内容
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹给子表达式命名,便于读取理解
        ?<子表达式名称>
#>
# 待匹配字符串和正则表达式
$str2 = "2024/06/19`t一些内容"
$pattern2 = "(?<Date>.*)\t(?<文本内容>.*)"

$str2 -match $pattern2 | Out-Null
# $matches自动变量,会自动存储匹配的结果
$matches
<#
    Name        Value
    ----        -------------------------
    Date        2024/06/19
    文本内容     一些内容
    0           2024/06/19       一些内容
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 通过自定义的名称获取匹配到的结果
$matches['Date'] | Out-Host  # 2024/06/19
$matches['文本内容'] | Out-Host  # 一些内容
Write-Host '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' -ForegroundColor Red

# 先清空$matches变量,避免产生影响
$matches.Clear()
$str3 = @"
2024/06/19`tAA
2024/06/21`tAA
2024/06/21`tBB
"@
<#
    ?:
        表示仅辅助匹配,不将结果放入存储空间,可以提高匹配速度
        如果我们去掉 ?: 的话,会把AA也给匹配到,然后放到结果中
#>
$pattern3 = "(?<Date>.*)\t(?:AA)"

$result1 = ([regex]$pattern3).Matches($str3)
$result1.Groups | Out-Host
<#
    Groups   : {0, Date}
    Success  : True
    Name     : 0
    Captures : {0}
    Index    : 0
    Length   : 13
    Value    : 2024/06/19   AA

    Success  : True
    Name     : Date
    Captures : {Date}
    Index    : 0
    Length   : 10
    Value    : 2024/06/19

    Groups   : {0, Date}
    Success  : True
    Name     : 0
    Captures : {0}
    Index    : 15
    Length   : 13
    Value    : 2024/06/21   AA

    Success  : True
    Name     : Date
    Captures : {Date}
    Index    : 15
    Length   : 10
    Value    : 2024/06/21
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

$result1 | ForEach-Object {
    # 通过对象中的Name属性来获取值
    $_.Groups['Date'].Value
    <#
        2024/06/19
        2024/06/21
    #>
}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red
