# ⏹csv字符串数据(没有标题)
$csvStrData = @"
"苹果","100","01","20"
"苹果","80","02","30"
"香蕉","70","01","33"
"香蕉","85","02","45"
"西瓜","52","01","330"
"西瓜","41","02","450"
"@

# ⏹csv字符串转换为csv对象的同时给添加标题
$csvObj = $csvStrData | ConvertFrom-Csv -Header @("水果", "价格", "月份", "销量")
# 直接通过 Out-Host 将内容输出到控制台上
$csvObj | Out-Host
<#
    水果 价格 月份 销量
    ---- ---- ---- ----
    苹果 100  01   20
    苹果 80   02   30
    香蕉 70   01   33
    香蕉 85   02   45
    西瓜 52   01   330
    西瓜 41   02   450
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹统计所有水果的总销量
    Group-Object -Property '水果'
        按照 水果 进行分组

    -Property @{Name = '水果名'; Expression = { $_.Name }}
        使用Select-Object的计算属性,将Name属性重命名为 水果名

    -Property @{
        Name = '总计'; 
        Expression = {
            ($_.Group | Measure-Object -Sum '销量').Sum
        }
    }
        定义一个名为 总计 的属性名
        计算每一组的销量属性的总和,返回一个对象($_.Group | Measure-Object -Sum '销量')
        对象的Sum属性表示每组的销量总和
#>
$csvObj | Group-Object -Property '水果' `
| Select-Object -Property (@{
    Name = '水果名';
    Expression = { $_.Name }
}, @{
    Name = '总计'; 
    Expression = {
        ($_.Group | Measure-Object -Sum '销量').Sum
    }
}) `
| Out-Host
<#
    水果名 总计
    ------ ----
    苹果     50
    香蕉     78
    西瓜    780
#>