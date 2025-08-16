# 定义一个类, 类里面有静态方法
class project {

    # 静态方法
    static [PSCustomObject]GetCategoryInfo() {
        return [PSCustomObject]@{
            mpl = [string[]]@(
                "mpl_rt_net",
                "mpl_rt_api",
                "mpl_eu_net",
                "mpl_eu_api"
            );
            ang = @(
                "ang_rt_net",
                "ang_rt_api",
                "ang_eu_net"
            );
            qch = @(
                "qch_rt_net",
                "qch_rt_api"
            );
        }
    }
}

# 用来获取值的key
$key = "mpl"

# ⏹获取map映射
[PSCustomObject]$categoryInfoMap = [project]::GetCategoryInfo()

# ⏹通过key获取到value
$categoryInfoList = $categoryInfoMap.$key
foreach ($categoryInfo in $categoryInfoList) {
    Write-Host "$categoryInfo" -ForegroundColor Green
}
Write-Host "+ -----------------------------------------" -ForegroundColor Red


# ⏹像java的HashMap那样去遍历
foreach ($entry in $categoryInfoMap.PSObject.Properties) {

    # $entry.Name 就是键
    #                 mpl qch ang
    Write-Output "Key → $($entry.Name)"

    # $entry.Value 就是数组
    foreach ($v in $entry.Value) {
        Write-Output "  Value → $v"
    }

    <#
        Key → mpl
            Value → mpl_rt_net
            Value → mpl_rt_api
            Value → mpl_eu_net
            Value → mpl_eu_api
        Key → ang
            Value → ang_rt_net
            Value → ang_rt_api
            Value → ang_eu_net
        Key → qch
            Value → qch_rt_net
            Value → qch_rt_api
    #>
}
Write-Host "+ -----------------------------------------" -ForegroundColor Red

# ⏹像 Java map.keySet() 那样 只遍历key
$categoryInfoMap.PSObject.Properties.Name | ForEach-Object {
    # 其中 _ 就代表当前被遍历的元素
    Write-Output "key的值 → ${_}"
    <#
        key的值 → mpl
        key的值 → ang
        key的值 → qch
    #>
}
Write-Host "+ -----------------------------------------" -ForegroundColor Red

# ⏹像 Java map.values() 那样 只遍历值
foreach ($values in $categoryInfoMap.PSObject.Properties.Value) {
    foreach ($v in $values) {
        Write-Output $v
    }
}
<#
    mpl_rt_net
    mpl_rt_api
    mpl_eu_net
    mpl_eu_api
    ang_rt_net
    ang_rt_api
    ang_eu_net
    qch_rt_net
    qch_rt_api
#>