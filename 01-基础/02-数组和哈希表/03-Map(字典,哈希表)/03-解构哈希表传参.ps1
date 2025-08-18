# 普通的 cmdled 调用方式
Get-ChildItem -Path "$HOME\Desktop\Java笔记" -Recurse -File -Filter "*.txt" | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 将部分参数抽取为哈希表的键值对
$Param_HashTable = @{
    Path = "$HOME\Desktop\Java笔记"
    Filter = "*.txt"
}

<#
    @ 用于对哈希表解构
    ※对于系统提供的 cmdlet 来说, 并不是所有的参数都支持
#>
Get-ChildItem -Recurse -File @Param_HashTable
Write-Host '------------------------------------------------------------' -ForegroundColor Red

# 定义一个函数
function Show-Info {
    param(
        [int]$Id,
        [string]$Name,
        [int]$Age
    )

    Write-Host "Id=$Id, Name=$Name, Age=$Age"
}

# 传统的调用函数的方式
Show-Info -Id 110120 -Name "小明" -Age 20
Write-Host '------------------------------------------------------------' -ForegroundColor Red

# 可以把函数所用到的若干个参数封装到一个hashtable中
# 有了这个特性之后，可以通过条件判断来动态的控制传入函数的参数
[hashtable]$paramTable = @{
    Id = 110120
    Name = "小明"
    Age  = 20
}

# 通过hashtable传递参数, 更加简洁
Show-Info @paramTable