# 来源
# https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/about/about_classes?view=powershell-5.1

# ⏹定义一个类
class Person {

    [string]$Name
    [int]$Age
    # ⏹隐藏属性,只能在类的内部使用,实例化类对象中无法访问
    hidden [string]$tokens = '10'

    # ⏹构造函数1,传入指定的属性的参数
    Person([string]$name, [int]$age) {
        $this.Name = $name
        $this.Age = $age
    }

    # ⏹构造函数2,传入哈希Table,构造
    Person([hashtable]$Properties) {
        $this.Init($Properties)
    }

    <#
        ⏹通过哈希表的方式来初始化参数
        该方法不需要在类的外部被调用,因此可以使用hidden来隐藏
    #> 
    hidden [void] Init([hashtable]$Properties) {

        # 遍历哈希表
        foreach ($Property in $Properties.Keys) {
            $this.$Property = $Properties.$Property
        }
    }

    [void]SayHello() {
        <# 
            在此处使用 Write-Host 将结果打印在控制台上
            此处无法使用 Write-Output 打印结果
        #>
        Write-Host "你好,我的名字叫: $($this.Name), 我今年$($this.Age)岁了."
    }

    # 指定类方法的返回类型
    [string]GetMsg() {
        return 'hello world!'
    }

    # 静态方法
    static [PSCustomObject]GetInfo() {
        return [PSCustomObject]@{
            Id = 110
            Address = '地球'
        }
    }
}

# ⏹方式1,实例化一个类
New-Object -TypeName Person -ArgumentList '张三', 18 | Out-Host
<#
    Name Age  
    ---- ---  
    张三  18
#>

# ⏹方式2,实例化一个类
[Person]::new("贾飞天", 30) | Out-Host
<#
    Name   Age
    ----   ---
    贾飞天  30
#>

# ⏹方式3,实例化一个类
[Person]@{
    Name = '李四'
    Age = 15
} | Out-Host
<#
    Name Age
    ---- ---
    李四  15
#>

# 定义一个电脑类
class Compuer {
    [string]$id
    [string]$name
    [int]$price
}

<#
    ⏹当不存在显示指定的构造函数时
    可以直接通过哈希的方式来创建对象
    ⏹Person类,由于手动指定了构造函数
        Person([string]$name, [int]$age)
    此时必须要手动指定下面这种函数的重载才能通过哈希表的方式创建对象
         Person([hashtable]$Properties) {
            $this.Init($Properties)
        }
    才能创建对象,否则无法
#>
[Compuer]@{
    id = '110120'
    name = '戴尔'
    price = 100
} | Out-Host
<#
    id     name price
    --     ---- -----
    110120 戴尔   100
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 创建对象
$person = [Person]::new("贾飞天", 30)

$person | Out-Host
<#
    Name   Age
    ----   ---
    贾飞天  30
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 访问属性
Write-Output $person.Name | Out-Host  # 贾飞天
Write-Output $person.Age | Out-Host  # 30

# 调用方法,将消息打印到控制台
$person.SayHello() | Out-Host  # 你好,我的名字叫: 贾飞天, 我今年30岁了.
# 调用方法,获取方法的返回值
$person.GetMsg() | Out-Host  # hello world!
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 调用静态方法
[Person]::GetInfo() | Out-Host
<#
    Id Address
    -- -------
    110 地球
#>

