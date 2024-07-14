# 来源
# https://www.pstips.net/regex-using-sub-expression.html

<#
    <body\b
        <body 后跟一个单词边界(确保匹配完整的 body 单词)
    [^>]*
        匹配零个或多个不包括 > 的字符(表示可能存在的属性,直到遇到 > 为止)
    (.*?)
        捕获组,匹配 <body> 标签和 </body> 标签之间的任何内容,非贪婪匹配
    ?<web_name>
        给子表达式取了一个名字
#>
$my_regex1 = [regex]"<body\b[^>]*>(?<web_name>.*?)</body>"
$my_html1 = "<body background=1>www.cctv.com</body>"

$result1 = $my_regex1.Matches($my_html1)

$result1 | ForEach-Object {

    $_.Groups['web_name'] | Out-Host
    <#
        Success  : True
        Name     : web_name
        Captures : {web_name}
        Index    : 19
        Length   : 12
        Value    : www.cctv.com
    #>
}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    (?i)
        开启不区分大小写模式
    <([A-Z][A-Z0-9]*)[^>]*>
        <
            匹配字符 <
        ([A-Z][A-Z0-9]*)
            捕获组 1,匹配以一个字母(A-Z)开头, 后跟零个或多个字母或数字(A-Z0-9)的字符串。
            在不区分大小写的模式下,这相当于匹配 <tag>,无论大小写如何
        [^>]*
            匹配除 > 以外的任意字符零次或多次, 表示标签中的属性或内容
        (.*?)
            ( 和 ): 定义捕获组 2
            .*?: 非贪婪匹配任意字符零次或多次, 尽可能少地匹配, 直到遇到 </\1>
        </\1>
            </: 匹配字符 </
            \1: 引用捕获组 1 的内容，即与开始标签相同的标签名称
            >: 匹配字符 >
#>
$regexTag = [regex]"(?i)<([A-Z][A-Z0-9]*)[^>]*>(.*?)</\1>"
$result2 = $regexTag.Matches("<button>我是一个按钮</button>")

$result2[0].Groups[0].Value  # <button>我是一个按钮</button>
$result2[0].Groups[1].Value  # button
$result2[0].Groups[2].Value  # 我是一个按钮
