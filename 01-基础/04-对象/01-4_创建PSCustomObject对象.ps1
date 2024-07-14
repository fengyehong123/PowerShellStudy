# 创建一个哈希表
@{
    name = "贾飞天";
    age = 18;
    address = @("地球", "月球")
    family = @{
        father = "枫叶红"
        mother = "张三"
    }
}
<#
    Name                           Value
    ----                           -----
    family                         {father, mother}
    name                           贾飞天
    age                            18
    address                        {地球, 月球}
#>

# 创建一个Powershell自定义对象
[PSCustomObject]@{
    name = "贾飞天";
    age = 18;
    address = @("地球", "月球")
    family = @{
        father = "枫叶红"
        mother = "张三"
    }
}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 数组内元素为哈希表的打印效果
@(
    @{
        name = "贾飞天"
        age = 18
        address = '地球'
    }
    , @{
        name = "张三"
        age = 20
    }
    , @{
        name = "李四"
        age = 30
    }
) | ForEach-Object {
    $_
} | Format-Table -AutoSize
<#
    Name    Value
    ----    -----
    name    贾飞天
    age     18
    address 地球
    age     20
    name    张三
    age     30
    name    李四
#>

<#
    ⏹数组内元素为 Powershell自定义对象 的打印效果
    更加直观
#> 
@(
    [PSCustomObject]@{
        name = "贾飞天"
        age = 18
        address = '地球'
    }
    , [PSCustomObject]@{
        name = "张三"
        age = 20
    }
    , [PSCustomObject]@{
        name = "李四"
        age = 30
    }
) | ForEach-Object {
    $_
} | Format-Table -AutoSize
<#
    name   age address
    ----   --- -------
    贾飞天  18 地球
    张三    20
    李四    30
#>