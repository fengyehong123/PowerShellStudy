# 来源
# https://www.pstips.net/string-object-methods.html

# 定义一个数组
$arr1 = @('1', '2', '3')

<#
    ⏹Join 
        将数组用特定的分隔符连接成一个字符串
#> 
[string]::Join('_', $arr1) | Out-Host  # 1_2_3

<#
    ⏹Split 
        将字符串用指定的连接符分割为数组
#>
'张三,李四,王五'.Split(',') | Out-Host
<#
    张三
    李四
    王五
#>

# ⭕使用,来分隔字符串,同时移除空白项目
'one,,two,,,three'.Split(',', [System.StringSplitOptions]::RemoveEmptyEntries) | Out-Host
<#
    one
    two
    three
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹CompareTo
        两个字符串进行比较,相等的话,值为0
#>
'你好'.CompareTo('你好') | Out-Host  # 0

<#
    ⏹Contains
        是否包含指定字符串
#>
'Hello World'.Contains('Hel') | Out-Host  # True

<#
    ⏹StartsWith()
        是否以指定字符串开始
    ⏹EndsWith()
        是否以指定字符串结尾
#>
'Hello'.EndsWith('lo') | Out-Host  # True

<#
    ⏹移除空格
        Trim()
            移除前后空格
        TrimStart()
            移除开头空格
        TrimEnd()
            移除结尾空格
#>

<#
    ⏹大小写转换
        ToUpper()
            转换为大写
        ToLower()
            转换为小写
#>

<#
    ⏹补齐字符串
        PadLeft()
            字符串左补齐
        PadRight()
            字符串右补齐
#>

<#
    ⏹从指定位置取指定长度子串
        Substring()
#>
'Hello World'.Substring(2, 5) | Out-Host  # llo W

<#
    ⏹返回匹配的索引
        第一次匹配的索引
            IndexOf()
        字符的最后匹配位置
        
#>
'Hello World'.IndexOf('l') | Out-Host  # 2
'Hello World'.LastIndexOf('l') | Out-Host  # 9

<#
    ⏹在指定位置插入字符串
        Insert()
    ⏹从指定位置开始移除指定长度
        Remove()
#>
'Hello World'.Insert(6, '你好') | Out-Host  # Hello 你好World
'Hello 你好World'.Remove(6, 2) | Out-Host  # Hello World

<#
    ⏹字符串替换
        Replace()
#>
# .Replace() 只能进行简单的替换,并且不支持正则表达式
'Hello World'.Replace('World', '世界') | Out-Host  # Hello 世界
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# -replace 选项支持正则表达式
@'
123你好,456世界
456哈哈,456哦哦
789嗯嗯,456娜娜
哈嗯嗯,456娜娜
'@ -replace '\d+', '数字' | Out-Host
<#
    数字你好,数字世界
    数字哈哈,数字哦哦
    数字嗯嗯,数字娜娜
    哈嗯嗯,数字娜娜
#>

# ⏹枚举字符串中的所有字符
'Hello World'.GetEnumerator() | Out-Host
<#
    H
    e
    l
    l
    o

    W
    o
    r
    l
    d
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹转换成字符数组
'Hello World'.ToCharArray() | Out-Host
<#
    H
    e
    l
    l
    o

    W
    o
    r
    l
    d
#>