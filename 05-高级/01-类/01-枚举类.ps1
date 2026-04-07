# 来源
# https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/about/about_enum?view=powershell-5.1


# ⏹定义一个枚举类
enum DayOfWeek {
    Sunday
    Monday
    Tuesday
    Wednesday
    Thursday
    Friday
    Saturday
}

# 通过整数值转化为枚举类
[DayOfWeek]$eum1 = 0;
$eum1 | Out-Host  # Sunday
[DayOfWeek]$eum11 = 1;
$eum11 | Out-Host  # Monday

# 将字符串转化为枚举类
[DayOfWeek]$eum2 = 'Monday'
$eum2 | Out-Host  # Monday

# 
try {
    # TEST字符串不在枚举类之中,因此无法转换,最后会报错
    [DayOfWeek]$eum3 = 'TEST'
    $eum3 | Out-Host
} catch {
    Write-Host "程序发生异常,异常的原因是:$($_.Exception.Message)"
    <#
        程序发生异常,异常的原因是:无法将值“TEST”转换为类型“DayOfWeek”。
        错误:“无法将标识符名称 TEST 与有效的枚举器名称相匹配。请指定以下枚举器名称之一，然后重试:
        Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday”
    #>
}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 定义一个性别枚举类
enum SexTypes {
    女 = 0
    男 = 1
    保密 = 9
}

# 返回枚举类的标签列表
[SexTypes].GetEnumNames() | Out-Host
<#
    女
    男
    保密
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹获取枚举类的值列表
[SexTypes].GetEnumValues() | ForEach-Object {
    # $_ 表示枚举对象本身,将其转换为int类型,即可获取到对应的值
    [int]$_ | Out-Host
}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹根据value来获取对应的label
[SexTypes].GetEnumName(9)  # 保密
[SexTypes].GetEnumName(9).GetType().FullName  # System.String
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 获取到的类型是枚举类型
([SexTypes]::女).GetType().FullName  # SexTypes
# 在比较的时候,会自动转换类型
[SexTypes]::女 -eq 0 | Out-Host  # True
# 获取到枚举类型之后,又将其抓换为int类型
[int][SexTypes]::女 | Out-Host  # 0

Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 枚举值作为参数
enum EndOfLine {
    CR   = 1
    LF   = 2
    CRLF = 3
}

function ConvertTo-LineEndingRegex {
    
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [EndOfLine]$InputObject
    )

    process {
        switch ($InputObject) {
            CR   {  '\r'  }
            LF   {  '\n'  }
            CRLF { '\r\n' }
        }
    }
}

# 三种调用方式
[EndOfLine]::CR | ConvertTo-LineEndingRegex | Out-Host  # \r
'CRLF' | ConvertTo-LineEndingRegex | Out-Host  # \r\n
ConvertTo-LineEndingRegex 2 | Out-Host  # \n

