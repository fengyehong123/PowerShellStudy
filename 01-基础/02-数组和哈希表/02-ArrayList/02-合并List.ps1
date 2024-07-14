# 创建一个空list
$arrayList = [System.Collections.ArrayList]::new()

# list1
$arr1 = [System.Collections.ArrayList]::new((1, 2, 3))
# list2
$arr2 = [System.Collections.ArrayList]::new((4, 5, 6))

# ⏹合并两个list
$arrayList.AddRange($arr1)
$arrayList.AddRange($arr2)

Write-Host ($arrayList)  # 1 2 3 4 5 6