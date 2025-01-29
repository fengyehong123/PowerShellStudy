<#
    ⏹操作符 
        -match 大小写不敏感
        -cmatch 大小写敏感
#>

# 大小写不敏感
"hello" -match "heLLO" | Out-Host  # True
# 大小写敏感
"hello" -cmatch "heLLO" | Out-Host  # False

<#
    ⏹如果想在部分片段中使用大小写敏感
        (?i) 后的字符大小写不敏感
        (?-i) 后的字符大小写敏感
#>
$text = "This is a Word. Here is another wording and WORD."
# 匹配大小写不敏感的 word 或 大小写敏感的 WORD
$pattern = "(?i)\bword\b|(?-i)\bWORD\b"

# ⏹-match 只会返回第一个匹配结果,因此虽然匹配到了多个结果,也只会显示一个
if ($text -match $pattern) {
    $Matches | Out-Host
    <#
        Name   Value
        ----   -----
        0      Word
    #>
}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹通过Select-String可以返回所有的匹配结果
$match_result = Select-String -InputObject $text -Pattern $pattern -AllMatches
$match_result.Matches | ForEach-Object {
    $_.Value | Out-Host
    <#
        Word
        WORD
    #>
}
Write-Host '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' -ForegroundColor Red

<#
    ⏹在正则表达式前加上[regex]对象也可以匹配多个结果
    Regex对象默认是大小写敏感的
#>
$regex  = [regex]"(?i)\bword\b|(?-i)\bWORD\b"
$regex.Matches($text) | ForEach-Object {
    $_.Value | Out-Host
    <#
        Word
        WORD
    #>
}

# 还可以可以通过.NET framework的对象RegEx来进行匹配
$([regex]::matches("test", "TEST", "IgnoreCase")).Value | Out-Host  # test