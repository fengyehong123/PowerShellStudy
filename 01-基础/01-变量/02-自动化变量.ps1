# 来源
# https://www.pstips.net/powershell-automatic-variables.html

<#
    ⏹Powershell自动化变量,是那些一旦打开Powershell就会自动加载的变量
    这些变量一般存放的内容包括：
        用户信息：例如用户的根目录$home
        配置信息: 例如powershell控制台的大小，颜色，背景等。
        运行时信息：例如一个函数由谁调用，一个脚本运行的目录等。
#>

<#
    ⏹$Pwd: 包含一个路径对象，该对象表示当前目录的完整路径。
#>
$Pwd.Path

# ⏹表示null,true,false
$null
$true
$false
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹用户的主目录的完整路径
        $Home ⇒ C:\Users\当前用户名
#>
$Home
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹操作系统中当前所用的用户界面(UI)区域性的名称
$PsUICulture  # zh-CN
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹查看当前host
$Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹查看当前Host的UI
$Host.UI.RawUI
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹$input 自动变量用于存储管道输入的数据
    它是一个集合,可以在函数或脚本块中使用
#>
function ConvertToUpperCase {
    process {
        # 此处的 $input 相当于通过管道传入的 "java", "javascript", "powershell"
        foreach ($item in $input) {
            $item.ToUpper()
        }
    }
}

"java", "javascript", "powershell" | ConvertToUpperCase | Out-Host
<#
    JAVA
    JAVASCRIPT
    POWERSHELL
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 所有用户和所有 PowerShell 主机应用程序的配置文件。
$PROFILE.AllUsersAllHosts
# 所有用户和当前 PowerShell 主机应用程序的配置文件。
$PROFILE.AllUsersCurrentHost
# 当前用户和所有 PowerShell 主机应用程序的配置文件。
$PROFILE.CurrentUserAllHosts
# 当前用户和当前 PowerShell 主机应用程序的配置文件。
$PROFILE.CurrentUserCurrentHost
$PROFILE

# powershell中设置控制台的编码格式
$OutputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor DarkYellow

<#
    $PSCommandPath 是一个特殊的变量，表示当前脚本所在的绝对路径
#>
Write-Host $PSCommandPath
Write-Host $MyInvocation.MyCommand.Definition