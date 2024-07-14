# 来源
# https://www.pstips.net/powershell-using-hash-tables.html

$path = "E:\01-プロジェクト"

# ⏹使用 Format-Table 格式化输出
Get-ChildItem -Path $path | Format-Table
Write-Host '⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐'

# ⏹指定输出的项目
Get-ChildItem -Path $path | Format-Table FullName, LastWriteTime
Write-Host '⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐'

<#
    ⏹创建列相关的格式化HashTable来格式化输出
        Expression: 绑定的表达式
        Width: 列宽度
        Label: 列标题
        Alignment: 列的对齐方式
#>
$column1 = @{
    expression = "FullName"; 
    width = 50;
    label = "文件全路径"; 
    alignment = "left"
}
$column2 = @{
    expression = "LastWriteTime";
    width = 50;
    label = "最后修改时间"; 
    alignment = "left"
}
Get-ChildItem -Path $path | Format-Table $column1, $column2