# 来源
# https://www.pstips.net/powershell-variable-strongly-typing.html

<#
    ⏹Powershell会给数据分配一个最佳的数据类型；
        如果一个整数超出了32位整数的上限([int32]::MaxValue),它就会分配一个64位整数的数据类型
        如果碰到小数,会分配一个Double类型
        如果是文本,Powershell会分配一个String类型
        如果是日期或者时间,会被存储为一个Datetime对象

    ⏹查看变量的数据类型
        $variable的GetType().Name

    ⏹Powershell 默认支持的.NET类型如下
        array
        bool
        byte
        char
        datetime
        decimal
        double
        guid
        hashtable
        int16
        int32
        int
        int64
        long
        nullable
        psobject
        regex
        sbyte
        scriptblock
        single
        float
        string
        switch
        timespan
        type
        uint16
        uint32
        uint64
        XML
#>

# ⏹数据类型的自动转换
# 定义一个字符串类型的变量
[String]$name_str = '贾飞天'
Write-Host "变量值为: $($name_str)"  # 变量值为: 贾飞天
Write-Host "变量类型为: $($name_str.gettype().name)"  # 变量类型为: String

[Int32]$age_num = 20
Write-Host "变量值为: $($age_num)"  # 变量值为: 20
Write-Host "变量类型为: $($age_num.gettype().name)"  # 变量类型为: Int32
Write-Host '-----------------------------------------------------------'

try {
    <#
        🤔尝试将字符串类型的数据,赋值数字
        因为数字可以转换为字符串,powershell为我们进行了自动转换
        所以赋值之后的数据的类型还是 String
    #>
    $name_str = 10
    Write-Host "变量值为: $($name_str)"  # 变量值为: 10
    Write-Host "变量类型为: $($name_str.gettype().name)"  # 变量类型为: String
    Write-Host '-----------------------------------------------------------'

    # 🤔字符串无法自动转换为数字,因程序报错
    $age_num = '你好,世界'
}
catch {
    Write-Host "程序发生异常,异常的原因是:$($_.Exception.Message)"
    Write-Host 'A🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍'
}

try {
    # 数组自动转换为字符串
    [string]$car = @('car1', 'car2')
    Write-Host "变量值为: $($car)"  # 变量值为: car1 car2
    Write-Host "变量类型为: $($car.gettype().name)"  # 变量类型为: String
    Write-Host '-----------------------------------------------------------'
}
catch {
    Write-Host "程序发生异常,异常的原因是:$($_.Exception.Message)"
    Write-Host 'B🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍'
}

<#
    ⏹使用固定类型的优点
        每个特殊的数据类型都有自己的特殊命令和特殊方法
#>
# 字符串 类型的数据自动转换为 datetime 类型的数据
[datetime]$my_date = "2024-05-11 20:33:00"
Write-Host $my_date

# 正是因为数据定义为datetime类型,所以可以使用该数据类型所特有的方法
$my_date.DayOfWeek  # Saturday
$my_date.DayOfYear  # 132
$my_date.AddDays(-10)  # 2024年5月1日 20:33:00

$validHosts = @("ConsoleHost", "Visual Studio Code Host")
if ($validHosts -contains $host.Name) {
    $host.UI.RawUI.ReadKey()
}