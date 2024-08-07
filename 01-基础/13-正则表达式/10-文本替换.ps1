﻿$regex = "女士|先生"

# 通过正则表达式,将 女士 先生 替换为 人类
$result = '女士们,先生们,大家晚上好' -replace $regex, '人类'
$result | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

$content = '太多 太多 的话 我还没有说， 太多 太多 太多 的理由值得你留下'
<#
    \b
        单词边界，确保匹配的是完整的单词
    (\w+)
        捕获一个或多个单词字符，并将其捕获为组1
        \w 匹配字母、数字和下划线
    (\s+\1){1,}
        匹配一个或多个空白字符后跟组1的内容（即前面捕获的单词），匹配这个模式一次或多次
        \1 引用第一个捕获组的内容
    $1
        替换为第一个捕获组的内容，即第一个单词
    
    整个正则表达式是在 搜索和移除重复的单词
#>
$content -replace "\b(\w+)(\s+\1){1,}\b", '$1'