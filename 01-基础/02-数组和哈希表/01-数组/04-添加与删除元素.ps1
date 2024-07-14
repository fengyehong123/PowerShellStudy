# ⏹通过 + 来添加元素
$arr1 = 1, 3
# 添加一个元素
$arr1 += 5
# 添加两个元素
$arr1 += 7, 9

# ⇓相当于这种写法
$arr1 = $arr1 + 10
Write-Host $arr1  # 1 3 5 7 9 10
Write-Host '-----------------------------------'

<# 
    ⏹从数组中删除元素
        Powershell中没有直接从数组中删除元素的方式
        只能通过间接方式来删除
#>
# 删除元素1
Write-Host ($arr1 | Where-Object { $_ -ne 1 })
Write-Host '-----------------------------------'
# 删除元素1 和 10
Write-Host ($arr1 | Where-Object { $_ -ne 1 -and $_ -ne 10 })
Write-Host '-----------------------------------'

# 也可以这样删除第3个元素
Write-Host ($arr1[0..1] + $arr1[3..5])  # 1 3 7 9 10