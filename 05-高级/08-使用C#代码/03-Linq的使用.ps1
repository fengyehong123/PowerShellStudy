<#
    案例来源：PowerShellでLINQを活用して、定番のデータ処理をスマートに！
        https://qiita.com/Tadataka_Takahashi/items/3f953bc858bd904f2bf7
#>

# 使用Linq的事前准备
using namespace System.Linq
using namespace System.Collections.Generic
Add-Type -AssemblyName System.Core

# 模拟csv文件的数据
$csvData = @"
Date,Product,Category,Amount,SalesPerson
2024-01-15,Laptop,Electronics,150000,田中
2024-01-16,Mouse,Electronics,3000,佐藤
2024-01-17,Keyboard,Electronics,8000,田中
2024-01-18,Desk,Furniture,45000,鈴木
2024-01-19,Chair,Furniture,25000,田中
2024-01-20,Monitor,Electronics,80000,佐藤
2024-01-21,Lamp,Furniture,12000,鈴木
2024-01-22,Laptop,Electronics,150000,田中
2024-01-23,Mouse,Electronics,3000,佐藤
2024-01-24,Bookshelf,Furniture,35000,鈴木
"@

# 模拟读取csv文件获取到的csv对象
$salesData = $csvData | ConvertFrom-Csv

# 使用通常的方法进行数据统计
$traditionalResult = $salesData | Group-Object Category | ForEach-Object {
    [PSCustomObject]@{
        Category = $_.Name
        TotalSales = ($_.Group | Measure-Object Amount -Sum).Sum
        Count = $_.Count
    }
}
$traditionalResult | Format-Table -AutoSize
Write-Host '-----------------------------------------------------------' -ForegroundColor Red


# 使用C#的Linq进行合计(感觉还不如原生的PowerShell的写法简单...)
# 因为使用【using namespace System.Linq】引入了命名空间，所以【System.Linq.Enumerable】可以简写为【Enumerable】
$categoryGroups = [Enumerable]::GroupBy($salesData, [Func[object,string]]{
    param($row) return $row.Category
})

$categoryGroups | ForEach-Object {

    $totalSales = [Enumerable]::Sum($_, [Func[object,int]]{
        param($row) return [int]$row.Amount
    })
    
    [PSCustomObject]@{
        Category = $_.Key
        TotalSales = $totalSales
        Count = [Enumerable]::Count($_)
    }
} | Format-Table -AutoSize

