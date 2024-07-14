# 来源
# https://www.pstips.net/regex-searching-for-several-keywords.html

<#
    ⏹可以使用间隔符 | 来搜索某一组关键字
    在 PowerShell 中,使用 -match 操作符进行匹配时
    如果匹配成功,匹配结果会存储在 $matches 自动变量中
#>
'Set a=1' -match 'Get|GetValue|Set|SetValue' | Out-Null
$matches[0] | Out-Host  # Set
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    用来匹配多个单词的正则表达式,使用 | 表示或用来分隔
    但是这种方式,一旦找到一个匹配项，就不会继续查找其他匹配项
    但是我们其实想要匹配 SetValue 这个单词
    像下面这样匹配,结果不是我们想要的
#>
$my_pattern = 'Get|GetValue|Set|SetValue'
$my_content = 'SetValue a=1'

# 因为Set已经被匹配了,所以SetValue便不会被再匹配
$result = Select-String -InputObject $my_content -Pattern $my_pattern -AllMatches
$result.Matches | ForEach-Object {
    $_.Value | Out-Host
    # Set
}

$my_regex = [regex]$my_pattern
$my_regex.Matches($my_content) | ForEach-Object {
    $_.Value | Out-Host
    # Set
}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 可以在关键字中加入单词边界,让顺序的影响失效,更加精准的匹配
$my_pattern1 = '\b(Get|GetValue|Set|SetValue)\b'
([regex]$my_pattern1).Matches($my_content) | ForEach-Object {
    $_.Value | Out-Host
    # SetValue
}