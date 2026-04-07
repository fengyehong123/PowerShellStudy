# 来源
# https://www.pstips.net/powershell-error-record-details.html

# 如果想把一个命令的执行结果重定向,可以使用重定向操作符 >
Get-ChildItem -Path $HOME > Home_file.txt

<#
    ⏹ > 只能重定向标准输出流
    而 Error信息不属于标准输出流
    此时需要使用 2> 操作符
#>
Get-ChildItem -Path 'xxxx/xxx' 2> Error.txt

<#
    2 代表标准错误流(stderr)
    1 代表标准输出流(stdout)

    ⏹2>&1 是一种重定向运算符，用于将标准错误流（stderr）重定向到标准输出流（stdout）。
    这意味着任何错误信息都会与正常的输出信息一起合并，从而使得两者可以被捕获并处理。
#>
$myerror1 = Remove-Item "NoSuchDirectory" 2>&1

# 显示错误信息
$myerror1.Exception | Out-Host

# 显示清晰的错误标识
$myerror1.FullyQualifiedErrorId | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹上述的通过重定向的方式将ERROR保存到变量中的方式有时也没有必要。
    绝大多数 Cmdltes都支持 -ErrorVariable 参数。

    ⏹只要将变量名称传递给 -ErrorVariable
    Powershell就会自动把出现的错误保存到这个变量中
    并且这种保存机制不受ErrorAction配置的影响。
#>
Remove-Item -Path "TestNoSuchDirectory" -ErrorVariable StoreError -ErrorAction "SilentlyContinue"
$StoreError | Out-Host

$StoreError.GetType().fullName  # System.Collections.ArrayList
$StoreError[0].gettype().fullName  # System.Management.Automation.ErrorRecord
$StoreError[0].Exception.Message
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹由上面的例子可以看到
        ErrorVariable存储类型为数组
        数组元素的类型为: ErrorRecord
#>
# 同时获取3个不存在的路径下的文件,将得到的3个异常全部存储在 ErrorStore 变量中
Get-ChildItem -Path '/path1', '/path2', '/path3' -ErrorAction SilentlyContinue -ErrorVariable ErrorStore
$ErrorStore.Count  # 3
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹可以给 -ErrorVariable 参数前加一个 + ,代表追加存储错误
    可以将一连串的错误合并在一个数组, 后面可以统一进行分析处理
#>

Get-Process 'item-fengyehong-1' -ErrorAction SilentlyContinue -ErrorVariable +ErrorVar
Get-Process 'item-fengyehong-2' -ErrorAction SilentlyContinue -ErrorVariable +ErrorVar
Get-Process 'item-fengyehong-3' -ErrorAction SilentlyContinue -ErrorVariable +ErrorVar

# 可以看到3个异常都被输出
$ErrorVar | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹即使你忘记使用ErrorVariable参数去收集异常，Powershell也会自动收集异常，存储在自动化变量$Error中
    $Error同样也是数组，该数组所对应的最大值存储在 $MaximumErrorCount 自动化变量中，默认为256
    每次会把最后发生的异常保存在索引为0的位置

    ⏹查看最后的一个异常可以使用$Error[0]
    ⏹可使用 $Error.Clear() 来清空异常
#>
$Error.Count | Out-Host  # 9
# 查看最后发生的异常
$Error[0] | Out-Host
# 清空异常数组中的信息
$Error.Clear()

# 查看异常存储的最大值
$MaximumErrorCount | Out-Host  # 256

