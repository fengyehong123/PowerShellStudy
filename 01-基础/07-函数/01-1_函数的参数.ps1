# 来源
# https://www.pstips.net/powershell-passing-arguments-to-functions.html

<#
    ⏹Powershell函数可以接受参数，并对参数进行处理。函数的参数有3个特性：
        任意参数：内部变量$args 接受函数调用时接受的参数，$args是一个数组类型。
        命名参数：函数的每一个参数可以分配一个名称，在调用时通过名称指定对应的参数。
        预定义参数：函数在定义参数时可以指定默认值，如果调用时没有专门指定参数的值，就会保持默认值。
        
    🔴Powershell中的脚本必须要先定义,然后才能使用,否则会报错
       这一点和其他编程语言不同
#>

function helloWorld {
    
    # 如果当前函数没有参数的话
    if ($args.Count -eq 0) {
        '当前函数没有参数!' | Out-Host
        return
    }

    <#
        $args是一个数组,这个内置的参数可以识别任意个参数
        尤其适用哪些参数可有可无的函数
    #>
    $args | ForEach-Object {
        "当前的参数为: $($_)" | Out-Host
    }
}

# 调用函数
helloWorld "你好" "我好" "大家好"
<#
    当前的参数为: 你好
    当前的参数为: 我好
    当前的参数为: 大家好
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹给函数设置参数,并指定默认值
function func1($arg1, $arg2, $arg3 = '默认参数值') {
    return "$arg1,$arg2,$($arg3)"
}

# 调用函数,并传递参数
func1 "参数1" "参数2"  # 参数1,参数2,默认参数值
func1 "参数1" "参数2" "参数3"  # 参数1,参数2,参数3
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹使用强制类型的参数
#>
function func2([Int]$num1, [Int]$num2) {
    return "两个参数相加的值为: $($num1 + $num2)";
}
# 调用函数时,按照顺序添加参数
func2 10 20 | Out-Host  # 两个参数相加的值为: 30
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹函数参数的另外一种书写和调用方法
#>
function func3 {
    # 函数中参数的另外一种指定方式
    param (
        [int]$num1 = 0,
        [int]$num2 = 0
    )

    '$num1' + "的值为: $($num1),类型为: $($num1.GetType().FullName)" | Out-Host
    '$num2' + "的值为: $($num2),类型为: $($num2.GetType().FullName)" | Out-Host
}
# 调用函数时无序指定参数时,需要指定参数的名称
func3 -num2 100 -num1 10
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹参数类型自动转换
#>
function func4 {

    param(
        # 指定默认值
        [datetime]$date = (Get-Date)
    )

    return $date.DayOfWeek
}

# 参数是日期字符串,Powershell会为我们自动转换
func4 '2024-06-04' | Out-Host  # Tuesday
# 参数不是日期字符串,无法自动转换为 datetime 类型,因此报错
try {
    func4 -date '你好' | Out-Host  # Tuesday    
} catch {
    "程序发生异常,异常的原因是:$($_.Exception.Message)" | Out-Host
    <#
        程序发生异常,异常的原因是:无法处理对参数“date”的参数转换。无法将值“你好”转换为类型“System.DateTime”。
        错误:“该字符串未被识别为有效的 DateTime。有一个未知单词(从索引 0 处开始)。”
    #>
}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹switch参数
        Powershell函数最简单的参数类型为布尔类型
        除了使用布尔类型,也可以使用Switch关键字
#>
function handleStr {

    param(
        [string]$str,
        [switch]$isReverse
    )

    if (-not $isReverse) {
        return $str
    }

    <#
        反转字符串 → LINQ 风格的反转(需要 .NET4.0 或更高版本)
            最终得到的是一个数组,数组中的元素是被反转之后的字符串元素
        
        可通过下面的方式转换为字符串
            1. -join $temp
            2. [string]::new($temp)
    #>
    $temp = [System.Linq.Enumerable]::Reverse([char[]]$str)
    return -join $temp
}

handleStr "Hello world"  # Hello world
handleStr -str "Hello world" -isReverse  # dlrow olleH