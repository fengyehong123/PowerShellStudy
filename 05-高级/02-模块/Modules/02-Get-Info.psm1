function Get-Info1() {

    param(
        [string]$keyword
    ) 
    "Info1执行了,$keyword"
}

function Get-Info2() {

    param(
        [string]$keyword
    ) 
    "Info2执行了,$keyword"
}

# 导出模块中的指定函数
Export-ModuleMember -Function Get-Info1, Get-Info2