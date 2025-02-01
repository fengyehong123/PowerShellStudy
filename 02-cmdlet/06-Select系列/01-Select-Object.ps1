# 来源
# https://www.pstips.net/powershell-filtering-pipeline-results.html

<#
    过滤对象
        可以使用Where-Object
    过滤对象的属性
        可以使用Select-Object
    自定义个性化的过滤效果
        可以使用ForEach-Object
    过滤重复的结果
        可以使用Get-Uinque
#>

<#
    ⏹查看指定的对象中有多少属性
        1. Format-List *
        2. Get-Member -MemberType Property

    ⏹Select-Object -First 1
        只选择第1个对象
#>
Get-Service | Select-Object -First 1 | Format-List * | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

Get-Service | Select-Object -First 1 | Get-Member -MemberType Property | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹知道对象中有多少属性了,可以过滤出对象中指定的属性
    先过滤出来 Status 为 Running 的所有属性
    然后只输出前3个
#>
Get-Service | Where-Object {$_.Status -eq "Running"} | Select-Object -First 3 | Out-Host
<#
    Status   Name               DisplayName
    ------   ----               -----------
    Running  AMD External Ev... AMD External Events Utility
    Running  AppHostSvc         Application Host Helper Service
    Running  Appinfo            Application Information
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹用于获取系统中用户帐户的详细信息。
    包括用户名、帐户域、SID（安全标识符）、描述等。
    这对系统管理员和脚本编写者非常有用，帮助他们管理和审查系统中的用户帐户。    
#>
Get-WmiObject -Class Win32_UserAccount | Select-Object -Last 2 | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹仅过滤出LocalAccount为True 并且 Name为guest的账户
    并且仅输出 Name, Description, Disabled 这3个属性
#>
Get-WmiObject -Class Win32_UserAccount -Filter "LocalAccount=True AND Name='guest'" `
| Select-Object Name, Description, Disabled | Out-Host
<#
    Name  Description                        Disabled
    ----  -----------                        --------
    guest 供来宾访问计算机或访问域的内置帐户     True
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red