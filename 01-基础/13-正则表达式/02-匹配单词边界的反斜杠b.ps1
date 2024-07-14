<#
    正则表达式中的 \b 是用来匹配单词边界的。单词边界是指一个单词的开头或结尾的位置。 
    \b 可以帮助你精确地匹配单词而不匹配单词的部分内容。
#>

$pattern = "\bword\b"
if ("This is a word. Here is another wording and sword." -match $pattern) {
    # $matches 是一个哈希表,包含捕获的匹配组
    $Matches | Out-Host
    <#
        Name   Value
        ----   -----
        0      word
    #>
}