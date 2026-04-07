function Get-ChineseGreeting() {

    param(
        [string]$keyword
    ) 
    "你好,$keyword"
}

function Get-JapaneseGreeting() {

    param(
        [string]$keyword
    )
    "こんにちは、$keyword"
}

# 函数的名称不符合 Get-Verb 命名规范
function Tst-Greeting() {

    param(
        [string]$keyword
    )
    "Test...$keyword"
}

# 导出模块中的指定函数
Export-ModuleMember -Function Get-ChineseGreeting, Get-JapaneseGreeting, Tst-Greeting