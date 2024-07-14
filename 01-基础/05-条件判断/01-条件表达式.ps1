# 来源
# https://www.pstips.net/powershell-formulating-conditions.html

<#
    ⏹Powershell 中的比较运算符
        -eq：等于
        -ne：不等于
        -gt：大于
        -ge：大于等于
        -lt：小于
        -le：小于等于
        -contains：包含
        -notcontains：不包含
#>

(3, 4, 5) -contains 2 | Out-Host  # False
(3, 4, 5) -contains 5 | Out-Host  # True
(3, 4, 5) -notcontains 6 | Out-Host  # True
# -ccontains 大小写不敏感
"a","b","c" -ccontains "A"  # False
# -contains 大小写敏感
"a","b","c" -contains "A"  # True
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

2 -eq 10 | Out-Host  # False
# -eq 不区分大小写
"str" -eq "STR" | Out-Host  # True
# 比较时,区分大小写
"str" -ceq "STR" | Out-Host  # False
# 比较时,不区分大小写
"str" -ieq "STR" | Out-Host  # True
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹支持带单位比较
1MB -lt 1GB | Out-Host  # True

# ⏹支持求反
!(2 -eq 3) | Out-Host  # True
-not (2 -eq 3) | Out-Host  # True
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹布尔运算
        -and：和
        -or：或
        -xor：异或
        -not：逆
#>
$True -and $True | Out-Host  # True
$True -and $False | Out-Host  # False
$True -or $False | Out-Host  # True
-not $True | Out-Host  # False
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹过滤数组中的元素
# 从数组中过滤出 3 这个元素,然后查看元素的数量
(1,2,3,4,3,2,1 -eq 3).Length | Out-Host  # 2
Write-Host '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' -ForegroundColor Red
# 过滤出不等于3的元素
1,2,3,4,3,2,1 -ne 3 | Out-Host
<#
    1
    2
    4
    2
    1
#>
