# 来源
# https://www.pstips.net/powershell-switch-condition.html

$num = 2

# 使用if语句判断
if ($num -eq 1) {
    '北京'
} elseif ($num -eq 2) {
    '南京'
} elseif ($num -eq 3) {
    '东京'
} else {
    '其他'
}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹使用switch语句
switch ($num) {
    1 {'北京'}
    2 {'南京'}
    3 {'东京'}
    # 相当于if语句中的else
    Default {'其他'}
}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹switch语句中的取值范围
$random_num = Get-Random -Minimum 1 -Maximum 15
Write-Host "获取到的随机数是: $($random_num)"
switch ($random_num) {
    {$_ -gt 1 -and $_ -lt 10} {
        '大于1,小于10'
    }
    {$_ -eq 10} {
        '等于10'
    }
    # 当匹配到一个条件之后,不想继匹配的时候,使用break关键字
    {$_ -gt 12} {
        '大于12';
        break
    }
    {$_ -gt 10} {
        '大于10';

    }
    Default {'没有匹配条件'}
}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹switch比较字符串时,默认不区分大小写
    可通过 -case 选项 来区分大小写
#>
$str1 = 'hello World!'
switch -case ($str1) {
    'Hello World!' {
        'Hello World!被匹配到'
    }
    'hello World!' {
        'hello World!被匹配到'
    }
    'HELLO WORLD!' {
        'HELLO WORLD!被匹配到'
    }
}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹在比较的时候,可以使用通配符
    需要添加 -wildcard 选项
#>
$domain = 'www.mossfly.com'
switch -Wildcard ($domain) {
    '*' {
        "匹配'*'"
    }
    '*.com' {
        "匹配*.com"
    }
    '*.*.*' {
        "匹配*.*.*"
    }
}
<#
    匹配'*'
    匹配*.com
    匹配*.*.*
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹在比较的时候,可以使用正则表达式
    需要添加 -regex
#>
$mail = "www@mossfly.com"
switch -Regex ($mail) {
    "^www" {
        "www打头"
    }
    "com$" {
        "com结尾"
    }
    "d{1,3}.d{1,3}.d{1,3}.d{1,3}" {
        "IP地址"
    }
}
<#
    www打头
    com结尾
#>