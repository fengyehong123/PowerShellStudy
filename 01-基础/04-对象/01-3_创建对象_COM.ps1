<#
    ⏹COM对象的概念
    在 PowerShell 中，COM（Component Object Model）对象提供了一种与各种 Windows 应用程序和服务进行交互的方式。
    COM 是一种二进制接口标准，用于允许对象在不同的进程和编程语言之间进行通信。
    通过使用 COM 对象，PowerShell 脚本可以控制应用程序如 Excel、Word，以及访问系统功能如文件系统、注册表等。
#>

# ⏹每一个COM对象都有一个ProgID,只要知道了该ProgID,就可以创建COM对象
$excel = New-Object -ComObject Excel.Application
<#
    Get-Member -MemberType 的常见参数
        Property：属性
        Method：方法
        Event：事件
        AliasProperty：别名属性
        ScriptProperty：脚本属性
        NoteProperty：注释属性
        PropertySet：属性集
        All：所有成员类型
#>

# ⏹通过 Get-Member 得到该对象的所有属性和方法
# 由于数量太多,此处我们只获取前5个属性
$excel | Get-Member -MemberType Property | Select-Object -First 5 | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 由于数量太多,此处我们只获取前5个方法
$excel | Get-Member -MemberType Method | Select-Object -First 5 | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹COM对象是非托管资源,在使用完毕后应该显式地释放它们,以避免内存泄漏
#>
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($excel) | Out-Null

<#
    ⏹常用的COM对象
        WScript.Shell(VBscript中)
        WScript.Network(VBscript中)
        Scripting.FileSystemObject
        Excel.Application
#>

$file_path = "$([Environment]::GetFolderPath("Desktop"))\Hello_World.txt"
# 创建处理文件的COM对象
$fso = New-Object -ComObject Scripting.FileSystemObject
# 创建文件并向其中写入内容
$file = $fso.CreateTextFile($file_path, $true)
$file.WriteLine(@"
你好
这个世界
"@)

# 关闭并释放内存
$file.Close()
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($fso) | Out-Null
Write-Host '===============================================================' -ForegroundColor Red

# ⏹创建 WScript.Shell 对象
$shell = New-Object -ComObject WScript.Shell

# 执行系统命令
$command = "cmd.exe /c dir"
$exec = $shell.Exec($command)
$exec.StdOut.ReadAll() | Out-Host

# 弹出消息框,5秒之后消失
$shell.Popup("WScript.Shell执行完毕!", 5, "提示", 0)