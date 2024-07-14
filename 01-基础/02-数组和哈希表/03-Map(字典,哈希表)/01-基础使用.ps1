# 来源
# https://www.pstips.net/powershell-using-hash-tables.html

<#
    ⏹使用 @{} 来创建哈希表
#>
$student = @{
    # 字符串类型
    name = "贾飞天";
    # 数字类型
    age = 18;
    # 数组类型
    address = @("地球", "月球")
    # 哈希表类型
    family = @{
        father = "枫叶红"
        mother = "张三"
    }
}

# ⏹查看类型
Write-Host ($student.GetType().FullName)  # System.Collections.Hashtable
Write-Host '-----------------------------------'

# ⏹获取所有的key
Write-Output $student.Keys
<#
    family
    name
    age
    address
#>
Write-Host '=================================='

# ⏹获取所有的value
Write-Output $student.Values
Write-Host '=================================='

# ⏹获取key的数量
Write-Host $student.Count  # 4
Write-Host '=================================='

# ⏹根据key获取value
Write-Host $student['address']  # 地球 月球
Write-Host '=================================='

# ⏹追加键值对
$student['hobby'] = '睡觉'
Write-Host $student['hobby']  # 睡觉
Write-Host '=================================='

# ⏹更新value
$student['name'] = 'hello world!'
Write-Host $student['name']  # hello world!
Write-Host '_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/'

# ⏹删除键值对
$student.Remove('name')
# 通过 .ContainsKey() 来判断key是否存在
if (-not $student.ContainsKey('name')) {
   Write-Host 'name这个key已经被删除!'
}

