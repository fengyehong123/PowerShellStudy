# 来源
# https://www.pstips.net/powershell-specify-return-value-from-function.html

<#
    ⏹PowerShell中的函数和Java,JS等编程语言不同
    可以返回一个或者多个返回值
#>

# ⏹返回一个值
function getObj1 {

    param(
        [string]$name
    )

    # 显示的指定返回值
    return @{
        name = $name
        age = 18
        address = '地球'
    }
}

getObj1 -name '贾飞天' | Out-Host
<#
    Name                           Value
    ----                           -----
    name                           贾飞天
    age                            18
    address                        地球
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

function getObj2 {

    <#
        非显示的指定,同时返回两个值
        返回的两个值会自动构造成一个Object数组
        然后返回
    #> 
    @{
        name = '贾飞天'
        age = 18
        address = '地球'
    }

    @{
        name = '枫叶红'
        age = 28
        address = '月球'
    }
}

# ⏹使用点操作符在当前作用域中执行函数
$result = . getObj2
# 查看类型
$result.GetType().FullName | Out-Host  # System.Object[]
# 返回第2个元素
$result[1] | Out-Host
<#
    Name                           Value
    ----                           -----
    name                           枫叶红
    age                            28
    address                        月球
#>
