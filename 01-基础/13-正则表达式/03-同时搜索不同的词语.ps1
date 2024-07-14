<#
    ⏹使用 ? 来标记指定词语为可选字符
    将 ? 放在可选字符后面,这样 ? 前面的字符就变为可选字符
#>
# 此处的 ? 并不代表任何字符,此处的 ? 和简单模式匹配里面的 ? 不相同
# u? 表示字符 u 在模式中并不是需要的
'color' -match 'colou?r' | Out-Host  # True
'colour' -match 'colou?r' | Out-Host  # True
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹如果想标记更多的连续字符作为可选
    可以将这些字符放在小括号中建立子表达式
#>
<#
    (ember)?
        ? 前面的小括号中的 ember 是可选的
#>
"Nov" -match "\bNov(ember)?\b" | Out-Host  # True
"November" -match "\bNov(ember)?\b" | Out-Host  # True
"Novxmber" -match "\bNov(ember)?\b" | Out-Host  # False

# 使用或操作符 | 
'Tom and Me' -match 'You|Me' | Out-Host  # True
"Peter and Bob" -match "and (Bob|Willy)"  # True
"Bob and Peter" -match "and (Bob|Willy)"  # False