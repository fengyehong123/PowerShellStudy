# 来源
# https://www.pstips.net/non-capturing-group.html

<#
    (expression) 
        是一种简单的子表达式
    (?:expression)  
        是一种特殊的子表达式
        不会将子表达式的匹配结果加入组中
#>

$Matches.Clear()
'PSTips Net' -match 'PS(Tips)\b' | Out-Null
$Matches
<#
    Name   Value
    ----   -----
    1      Tips
    0      PSTips
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

$Matches.Clear()
'PSTips Net' -match 'PS(?:Tips)\b' | Out-Null
$Matches
<#
    Name   Value
    ----   -----
    0      PSTips
#>