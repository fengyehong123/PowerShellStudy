# 来源
# https://www.pstips.net/string-operators.html

<#
    ⏹格式化操作符 -f
#>
"你好,我的名字叫{0}, 我今年{1}岁了" -f '贾飞天', 18 | Out-Host
# 你好,我的名字叫贾飞天, 我今年18岁了
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹替换操作符 
    -replace
        大小写不敏感
    -ireplace
        i前缀表示字符串大小写不敏感(insensitive)
    -creplace
        c前缀表示字符串大小写敏感(case sensitive)
#>
'Hello World' -replace 'Hello', '你好' | Out-Host  # 你好 World
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹*
        代表一个字符串  
#>
'你好啊' -like '*' | Out-Host  # True

<#
    ⏹+ 
        合并两个字符串
#>
'你好' + '世界' | Out-Host  # 你好世界

<#
    ⏹验证字符串是否相等
        -eq
        -ieq
            大小写不敏感
        -ceq
            大小写敏感
#>
'Hello' -ceq 'hello' | Out-Host  # False

<#
    ⏹验证字符串包含关系,允许模式匹配
        -like
        -ilike
            大小写不敏感
        -clike
            大小写敏感
    ⏹验证字符串的不包含关系,允许模式匹配
        -notlike
        -inotlike
            大小写不敏感
        -cnotlike
            大小写敏感
#>
'hello world' -ilike 'wor' | Out-Host  # False
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹验证模式匹配
        -match
        -imatch
            大小写不敏感
        -cmatch
            大小写敏感
    ⏹验证模式不匹配
        -notmatch
        -inotmatch
            大小写不敏感
        -cnotmatch
            大小写敏感
#>
# 匹配以he开头,后面还带着2个字符
'hello ld world' -match '^he??' # True
# 匹配 空格ld
'hello ld world' -match '\sld'  # True
# 匹配ld结尾
'hello ld world' -match 'ld$'  # True

