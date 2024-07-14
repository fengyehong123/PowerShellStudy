﻿# 来源
# https://www.pstips.net/powershell-defining-text.html

# 定义一个变量
$var = 'Hello World!'

# ⏹单引号 '' 中的内容会被原封不动的输出
'你好, $($var)' | Out-Host  # 你好, $($var)

# ⏹双引号 "" 中的变量内容会被替换, $() 或 $变量名
"今天的日期是 $(Get-Date);你好, $var" | Out-Host  # 今天的日期是 06/15/2024 12:25:24;你好, Hello World!

# ⏹@""@ 用来定义多行文本
@"
你好
$($var)
"@ | Out-Host
<#
    你好
    Hello World!
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
   ⏹其他编程语言一般使用 反斜杠\ 用来表示转义字符
   PowerShell中使用 反引号 ` 用来表示转义字符 
#>
# ⏹单引号套双引号
'你好, "这个世界"' | Out-Host

# ⏹双引号套双引号,但是使用 ` 对双引号进行转义
"你好, `"这个世界`"" | Out-Host

# ⏹在字符串中输出换行符(必须使用双引号,单引号的话会原样输出)
"你好,`n 这个世界" | Out-Host

<#
   ⏹其他转义字符
    `n	换行符
    `r	回车符
    `t	制表符
    `a	响铃符
    `b	退格符
    `'	单引号
    `"	双引号
    `0	Null
    ``	反引号本身
#>
"你好,我的名字叫: `0 ``" | Out-Host  # 你好,我的名字叫:  `
