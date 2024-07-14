# 来源
# https://www.pstips.net/powershell-copying-arrays.html

<#
    ⏹数组属于引用类型，使用默认的的赋值运算符在两个变量之间赋值只是复制了一个引用，两个变量共享同一份数据。
    这样的模式有一个弊病如果其中一个改变也会株连到另外一个。
    所以复制数组最好使用Clone()方法，除非有特殊需求。
#>

# 定义数组arr1
$arr1 = "a", "b", "c"
# 将数组arr1赋值给数组arr2
$arr2 = $arr1
# 修改arr2数组
$arr2[0] = "你好"
# 打印数组arr1,可以看到也发生了变化
Write-Host $arr1  # 你好 b c
Write-Host '-----------------------------------'

# 可以看到,两个数组相等
Write-Host ($arr1.Equals($arr2))  # True
Write-Host '-----------------------------------'

# ⏹使用.Clone()方法复制数组
$arr3 = $arr1.Clone()
# 克隆前后的数组进行比较
Write-Host ($arr3.Equals($arr1))  # False
Write-Host '-----------------------------------'

# 两个数组引用的比较
Write-Host ([object]::ReferenceEquals($arr1, $arr2))  # True
Write-Host ([object]::ReferenceEquals($arr1, $arr3))  # False