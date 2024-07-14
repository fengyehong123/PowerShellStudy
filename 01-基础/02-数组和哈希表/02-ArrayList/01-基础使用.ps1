# ⏹创建list,并向其中添加元素
$list1 = [System.Collections.ArrayList]::new()
# 添加void,避免返回添加元素之后的下标
[void]$list1.Add("a")
# 通过管道符配合 Out-Null 将元素添加后的下标输出到null,避免添加到控制台上
$list1.Add("aa") | Out-Null
# 由于没有指定void,因此添加元素之后的下标被打印在控制台上
$list1.Add("b")
Write-Host $list1
Write-Host '---------------------------------------------'

# ⏹在创建list的时候,就初始化元素
$list2 = [System.Collections.ArrayList]::new(@("A1", "A2", "A3"))
Write-Host $list2  # A1 A2 A3
Write-Host '---------------------------------------------'

# ⏹删除指定的元素
$list2.Remove("A2")
Write-Host $list2  # A1 A3

# 根据索引删除
$list2.RemoveAt(0)
Write-Host $list2  # A3
