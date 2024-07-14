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
    ※并不是所有的参数都支持
#>
Get-ChildItem -Recurse -File @Param_HashTable 