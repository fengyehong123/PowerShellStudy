# 来源
# https://www.pstips.net/powershell-creating-new-arrays.html

# ⏹通过逗号(,)来创建数组
$arr1 = 1, 2, 3, 4
Write-Host $arr1  # 1 2 3 4

# ⏹创建连续的数字数组,并指定变量类型
[Int[]]$arr2 = 1..6
Write-Host $arr2  # 1 2 3 4 5 6
Write-Host '---------------------------------------------'

# ⏹数组如果是弱类型,默认可以存储不同类型的值
$arr3 = 1, "你好", ([System.Guid]::NewGuid()), (Get-Date)
# 使用 -join 运算符将数组的每个元素连接成一个字符串, 每个元素之间用换行符 "`n" 分隔
Write-Host ($arr3 -join "`n")
<#
    1
    你好
    518c7aeb-a645-4e93-8ce1-3d6fabc4c8a4
    2024/5/15 21:46:23
#>
Write-Host '---------------------------------------------'

# ⏹创建一个空数组
$arr4 = @()

# ⏹判断是否是一个数组
Write-Host ($arr4 -is [array])  # True

# ⏹一个元素的数组
$arr5 = @(100)
Write-Host $arr5  # 100

$arr6 = ,9999
Write-Host $arr6  # 9999