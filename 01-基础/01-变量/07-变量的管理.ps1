# 来源
# https://www.pstips.net/powershell-variable-management-behind-the-scenes.html

<#
    ⏹在Powershell中创建一个变量,会在后台生成一个PSVariable对象.
    这个对象不仅包含变量的值,也包含变量的其它信息,例如'只写保护'这样的描述.
    
    ⏹可以通过Get-Variable命令来查看一个变量的全部信息
#>

# 创建一个变量,存储当前的日期
$my_date = Get-Date
# 通过 Get-Variable 来获取一个变量的 PSVariable对象
Get-Variable my_date
Write-Host '------------------------------'

# 查看一个变量的全部信息
Get-Variable my_date | Format-List * 
Write-Host '------------------------------'

# 只查看变量名和变量值
Get-Variable my_date | Format-List Name,Value
Write-Host '------------------------------'

<#
    ⏹修改变量的选项设置
        Powershell处理一个变量的PSVariable对象,主要是为了能够更新变量的选项设置
        既可以使用命令Set-Variable来直接更改
        也可以在获取PSvariable对象后直接更改
#>

$str = '你好,世界!'
# 通过 Set-Variable 来直接修改变量值的描述
Set-Variable str -Value 'Hello World!' -Description 'English Content!'
Get-Variable str | Format-List *
Write-Host '⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐'

# 先通过 Get-Variable 获取变量的PSVariable对象,然后修改Value属性
$my_var_info = Get-Variable str
$my_var_info.Value = 'こんにちは 世界!'
# 也可以使用powershell的子表达式的方式
(Get-Variable str).Description = '日本語 コンテンツ!'
$my_var_info | Format-List *
Write-Host '⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐'

<#
    ⏹变量的Option是一个枚举值,包含以下内容
        None
            默认设置
        ReadOnly
            变量只读，但是可以通过-Force 选项更新
        Constant
            常量一旦声明，在当前控制台不能更新
        Private
            只在当前作用域可见，不能贯穿到其它作用域
        AllScope
            全局，可以贯穿于任何作用域
#>
$my_address = '地球'
Set-Variable my_address -Option 'ReadOnly'
# 尝试修改变量值
try {
    Write-Host $my_address
    $my_address = '宇宙'
} catch {
    Write-Host "程序发生异常,异常的原因是:$($_.Exception.Message)"
    Write-Host '⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐'
}

<#
    ⏹变量的类型规范
        每个变量的都有自己的类型,存放在PsVariable对象的Attributes[System.Management.Automation.PSVariableAttributeCollection]属性中
        如果这个Attributes为空
            就可以给这个变量存放任何类型的数据,Powershell会根据我们存入的数据自己选择合适的类型
        一旦这个Attributes属性不为空,确定下来
            就不能随意存放数据了
#>

<#
    给$var存放一个整数,没有指定类型,所以属性弱类型变量,此时Attributes属性为空
    所以也可以赋值字符串给变量var
#>
$var = 10
Write-Host (Get-Variable var).Attributes
$var.GetType().FullName  # System.Int32

$var = "你好"
Write-Host (Get-Variable var).Attributes
$var.GetType().FullName  # System.String
Write-Host '🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳'

<#
    给$num存放一个整数,指定数据类型为Int,属于强数据类型
        此时给变量赋予字符串数字,不会报错,因此Powershell解释器会进行自动转换
        但是如果给赋予非数字的字符串的话,Powershell解释器自动抓换失败,此时程序就会出现异常
    若非要将字符串赋予到$num变量中,使用
        (Get-Variable 变量).Attributes.Clear() 来清空Attributes
        此时变量就是弱类型的了,因此可以存入字符串类型的数据
#>
[Int]$num = 10
Write-Host (Get-Variable num).Attributes  # System.Management.Automation.ArgumentTypeConverterAttribute
$num.GetType().FullName  # System.Int32

# 向Int强类型的变量赋值字符串数字
$num = '100'
Write-Host (Get-Variable num).Attributes  # System.Management.Automation.ArgumentTypeConverterAttribute
# Powershell为我们完成了自动转换
$num.GetType().FullName  # System.Int32

# 向Int强类型的变量赋值字符串
try {
    $num = '一万'
} catch {
    Write-Host "程序发生异常,异常的原因是:$($_.Exception.Message)"
    Write-Host '🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳'
}

# 清空强类型变量的Attributes属性
(Get-Variable num).Attributes.Clear()
Write-Host (Get-Variable num).Attributes

# 可以看到已经由强类型变为弱类型
$num.GetType().FullName  # System.Int32

$num = '一万'
$num.GetType().FullName  # System.String

$num = @(10, 20, 30)
$num.GetType().FullName  # System.Object[]

<#
    ⏹验证和检查变量的内容
        PSVariable变量的Attributes属性能够存储一些附件条件
        变量在 ⇒重新赋值⇐ 时就会进行验证
    
    ⏹常用的变量内容验证
        ValidateNotNullAttribute
            限制变量不能为空
        ValidateNotNullOrEmptyAttribute
            限制变量不等为空，不能为空字符串，不能为空集合
        ValidatePatternAttribute
            限制变量要满足制定的正则表达式
        ValidateRangeAttribute
            限制变量的取值范围
        ValidateSetAttribute
            限制变量的取值集合
        ValidateLengthAttribute 
            验证字符串的长度
#>

# ⏹定义字符串的条件为2到5个字符
$my_str1 = '你好'
$condition1 = New-Object System.Management.Automation.ValidateLengthAttribute -ArgumentList 2,5
(Get-Variable my_str1).Attributes.Add($condition1)

$my_str1 = '你好,世界'
try {
    # 因此长度超过5个字符 ⇒ 程序报错
    $my_str1 = '你好,世界!!!!'
} catch {
    Write-Host "程序发生异常,异常的原因是:$($_.Exception.Message)"
    Write-Host '🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳'
}

# ⏹定义变量不能为 null
$my_str2 = 'hello'
$condition2 = New-Object System.Management.Automation.ValidateNotNullAttribute
(Get-Variable my_str2).Attributes.Add($condition2)

$my_str2 = ''
try {
    # 尝试将字符串赋值为 null ⇒ 程序报错
    $my_str2 = $null
} catch {
    Write-Host "程序发生异常,异常的原因是:$($_.Exception.Message)"
    Write-Host '🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳'
}

# ⏹定义数组不能为null或空
$my_array = @('1', '2', '3')
(Get-Variable my_array).Attributes.Add($(New-Object System.Management.Automation.ValidateNotNullOrEmptyAttribute))
try {
    $my_array = @(4, 5, 6)
    Write-Host $my_array
    $my_array = @()
} catch {
    Write-Host "程序发生异常,异常的原因是:$($_.Exception.Message)"
    Write-Host '🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳'
}

# ⏹验证范围,设置范围为1到12
$my_month = 1
(Get-Variable my_month).Attributes.Add($(New-Object System.Management.Automation.ValidateRangeAttribute -ArgumentList 1,12))

try {
    $my_month = 10
    Write-Host $my_month
    $my_month = 99
} catch {
    Write-Host "程序发生异常,异常的原因是:$($_.Exception.Message)"
    Write-Host '🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳'
}
