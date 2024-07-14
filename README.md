# PowerShellStudy
PowerShell学习

```powershell
# 判断host所在的环境
if ($host.Name -eq "ConsoleHost") {
    $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    Write-Host "你按下了按键：" $key.Character
} else {
    Write-Host "当前脚本不在交互式控制台环境中执行，无法读取按键输入。"
}

# 按下Enter键继续
Pause

# 读取用户在控制台上的输入
Read-Host @"
程序执行完毕~
按下任意键结束程序=_=
"@

```

```powershell
# 获取用户凭据
$credential = Get-Credential

# 查看凭据
# https://learn.microsoft.com/ja-jp/windows-server/administration/windows-commands/cmdkey
$jmw = cmdkey /list:dav.jianguoyun.com
```

⏹脚本块
```powershell
<#
    ScriptBlock（脚本块）是在PowerShell中表示可执行代码的对象。
    它是一种封装了一组命令或表达式的代码块，并且可以被多次调用的数据类型。
    可以将脚本块赋值给变量，也可以将其作为参数传递给函数或命令。
    在使用脚本块时，你可以通过调用它来执行其中包含的命令或表达式。
#>
$myScriptBlock = {
    Write-Host "This is a script block."
}

& $myScriptBlock
```

```powershell
# 多行文本字符串
Write-Host @"
    你好,
    我好，
    大家好
"@
```

```powershell
Write-Output "请进行选择:"
$selection = "吃饭", "睡觉", "喝水" | Out-GridView -PassThru
Write-Output "你选择的是: $selection"
```

```powershell
Write-Output 和 Write-Host 的不同
Out-Host # 直接输出到控制台上
```
# Write-HostとWrite-Outputの違い
https://blog.shibata.tech/entry/2016/01/11/151201

```powershell
Get-Help -Name Get-ChildItem

Get-Command -Name Get-ChildItem
Get-Command -CommandType cmdlet Get-*

# 查看对象中的方法
Get-ChildItem | Get-Member -MemberType Method

# 图形化的方式来提示命令用法
Show-Command Get-ChildItem
```

```powershell
$PSDefaultParameterValues 是 PowerShell 中的一个全局变量，用于存储默认的参数值。它是一个哈希表，允许你为某些命令或所有命令设置默认参数值，从而简化命令的使用。
```

```powershell
$Global:CurrentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent()
```

# PowerShell で csv を扱う方法まとめ
https://qiita.com/nimzo6689/items/4a6fcabc032f570de6f0


# PowerShell 7.0 版本 才支持
```powershell
# 当左边为空时返回右边的值
$null ?? 'DefaultValue'
# 当左边的值为空时将右边的值赋给左边
$val ??= 'DefaultValue'
# 当左边为空时整个表达式返回空
$null?.Name
```

# 安装Chocolatey
```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

```