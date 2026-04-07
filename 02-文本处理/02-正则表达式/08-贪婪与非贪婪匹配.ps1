# 来源
# https://www.pstips.net/regex-lazy-and-greedy-match.html

<#
    ? 是一个量词，表示前面的元素是可选的，即可以出现零次或一次。
        作用是使前面的元素变为可选项。
    (ruary)?
        ()：括号内的内容是一个捕获组
        ruary：匹配字符串 ruary
        ?：表示前面的捕获组(即 ruary)是可选的，可以出现零次或一次。
#>
"Feb" -match "Feb(ruary)?" | Out-Host  # True
$matches[0] | Out-Host  # Feb
$matches.Clear()
<#
    ⏹在默认情况下,正则表达式属于贪婪模式
    在匹配到Feb之后,会继续的贪婪的匹配更多符合模式的字符
    所以最终匹配到了 February ,而不是 Feb
#>
"February" -match "Feb(ruary)?" | Out-Host  # True
$matches[0] | Out-Host  # February
$matches.Clear()
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 待匹配的字符串
$str = "<div>Content1</div><div>Content2</div>"

<#
    ⏹贪婪匹配会尽可能多地匹配字符
    量词 *、+ 和 {} 默认是贪婪的
#>
([regex]"<div>(?<my_name>.*)</div>").Matches($str)[0].Groups['my_name'].Value | Out-Host
<#
    Content1</div><div>Content2
#>

<#
    ⏹非贪婪匹配会尽可能少地匹配字符
    通过在量词后面加上 ? 实现非贪婪匹配
#>
([regex]"<div>(?<my_name>.*?)</div>").Matches($str)[0].Groups['my_name'].Value | Out-Host
# Content1
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

$str2 = "aaa"

# ⏹贪婪匹配 a+ 会匹配尽可能多的 a, 因此匹配整个字符串
([regex]"a+").Matches($str2)[0].Groups[0].Value | Out-Host  # aaa

# ⏹非贪婪匹配 a+? 会匹配尽可能少的 a, 因此匹配第一个 a
([regex]"a+?").Matches($str2)[0].Groups[0].Value | Out-Host  # a