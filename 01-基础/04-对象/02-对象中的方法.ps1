<#
    ⏹当把一个对象直接输出到控制台上的时候,对象的属性值会被转换为可视化的文本
    但是对象的方法不会输出到控制台上
#>
$Host.UI.RawUI | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<# 
    ⏹查看指定对象上的所有方法
        Get-Member -MemberType Method
#>
$Host.UI.RawUI | Get-Member -MemberType Method | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹Get_ 和 Set_ 方法
        1. 所有名称以 Get_ 开头的方法都是为了给对应的属性返回一个值
           Version是 $Host 对象上的一个属性
        2. 如果一个对象是由 Get_属性名(),但是却没有 Set_属性名()
           说明该属性为只读属性
#>
$Host.Version | Out-Host
$Host.Get_Version() | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹过滤方法名中包含了 s 的方法
#>
$Host.UI.RawUI | Get-Member -MemberType Method `
| Where-Object {$_.Name -notlike '*s*'} | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹过滤出方法名中包含了 Write 的所有方法 → 得到若干个方法
    从若干个方法中,只获取出下标为1的方法
#>
$Host.UI | Get-Member -Name '*Write*' | Select-Object -Index 1