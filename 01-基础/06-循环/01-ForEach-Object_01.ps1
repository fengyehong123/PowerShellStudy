# 来源
# https://www.pstips.net/powershell-foreach-object-loop.html

# ⏹对管道的对象进行定制化的处理
Get-WmiObject Win32_Service | ForEach-Object {
    "名称: $($_.DisplayName), ProcessId是否超过100: $($_.ProcessId -gt 100)"
}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹和其他编程语言一样,也可以可以嵌套if语句
    -f 是格式化字符串的简写。
       它用于将指定格式的字符串与变量的值进行组合。
       可以使用 {} 作为占位符，并在 -f 后提供相应的值来填充这些占位符。
    $_ 代表循环中的当前元素
#>
Get-WmiObject Win32_Service | ForEach-Object {
    if ($_.ProcessId -gt 3000) {
        "{0} ➡ ({1})" -f $_.DisplayName, $_.ProcessID | Out-Host
    }
}

<#
    ForEach-Object 循环并不支持 continue
    但是通过return可以实现相同的效果
#>
1..10 | ForEach-Object {

    if ($_ -le 5) {
        return
    }
    "当前输出的数字为: $($_)" | Out-Host
}
<#
    当前输出的数字为: 6
    当前输出的数字为: 7
    当前输出的数字为: 8
    当前输出的数字为: 9
    当前输出的数字为: 10
#>

