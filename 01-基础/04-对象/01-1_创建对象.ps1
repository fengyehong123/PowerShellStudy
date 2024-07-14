# 来源
# https://www.pstips.net/powershell-object-contains-properties-and-methods.html

<#
    ⏹创建对象
        创建一个新的 .NET System.Object 类的实例。
        这个对象是所有 .NET 对象的基类，具有最基本的功能，没有任何特定的属性或方法。
#>
$my_obj = New-Object System.Object
Write-Host $my_obj  # System.Object
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹向刚创建的对象中添加
        属性名 -Name
        属性值 -Value
        类型 -MemberType
            NoteProperty: PowerShell 中用于存储数据的简单属性类型
#>
Add-Member -InputObject $my_obj -Name Color -Value '红色' -MemberType NoteProperty

# 👍通过管道的方式向对象中添加属性👍
$my_obj | Add-Member NoteProperty Address '地球'
$my_obj | Add-Member NoteProperty Age 18
$my_obj | Out-Host
<#
    Color Address Age
    ----- ------- ---
    红色  地球     18
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹向对象中添加方法
    -memberType 选项需要使用 ScriptMethod
#>
Add-Member -MemberType ScriptMethod -InputObject $my_obj `
-Name Eat -Value {'我正在吃东西'}

$my_obj | Add-Member ScriptMethod Sleep {'我正在睡觉'}

# ⏹查看对象中的方法
$my_obj | Get-Member -MemberType Method | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 调用对象中添加好的方法
$my_obj.Eat() | Out-Host
$my_obj.Sleep() | Out-Host


