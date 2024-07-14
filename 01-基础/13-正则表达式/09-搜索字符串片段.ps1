# 来源
# https://www.pstips.net/regex-find-string-segment.html

$my_regex1 = "\bstart\W+(\w+\W+){1,6}?end\b"
$content = "Find word segments from start to end"

([regex]$my_regex1).Matches($content).Groups | Out-Host
<#
    Groups   : {0, 1}
    Success  : True
    Name     : 0
    Captures : {0}
    Index    : 24
    Length   : 12
    Value    : start to end

⏹⇓⇓⇓⇓⇓⇓⇓ 子模式匹配 ⇓⇓⇓⇓⇓⇓⇓

    Success  : True
    Name     : 1
    Captures : {1}
    Index    : 30
    Length   : 3
    Value    : to
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    \bstart\W+(\w+\W+){1,6}?end\b
    \bstart\W+(?:\w+\W+){1,6}?end\b
    上述两个正则表达式, 只差了一个 ?:

    \W+
        匹配一个或多个非单词字符, 例如空格
    \w+
        一个或多个单词字符，例如一个单词
    (?:\w+\W+){1,6}?
        匹配1到6次(尽可能少),包含单词字符和非单词字符的模式
    
    在正则表达式中，(?: ... ) 表示一个非捕获组。
    非捕获组是一种分组方式，它允许你对正则表达式中的子模式进行分组，但不捕获该组的匹配结果。
    与捕获组 (...) 不同，非捕获组不会在匹配结果中生成子模式匹配。
#>
$my_regex2 = "\bstart\W+(?:\w+\W+){1,6}?end\b"
([regex]$my_regex2).Matches($content).Groups | Out-Host
<#
    Groups   : {0}
    Success  : True
    Name     : 0
    Captures : {0}
    Index    : 24
    Length   : 12
    Value    : start to end
#>
([regex]$my_regex2).Matches($content).Value | Out-Host  # start to end