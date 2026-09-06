<#
    ✅cscript.exe 是 Windows 系统自带的 Windows Script Host (WSH) 的一个命令行版本解释器。
    简单来说，它的作用就是：
        在命令行里执行脚本文件（比如 .vbs、.js 脚本）。
    
    Windows 提供了两种 WSH 的宿主程序：
        1. wscript.exe
            图形界面版本（默认）。
            执行脚本时会弹出对话框，比如 MsgBox 会显示弹窗。
            更适合交互式脚本。
        2. cscript.exe
            命令行版本。
            脚本的输入输出会直接显示在 命令提示符 (cmd) 或 PowerShell 窗口中。
            更适合批处理、自动化、后台脚本执行。
    
    ✅注意事项:
        1. 这里所谓的【.js脚本 】是 微软实现的 JavaScript 引擎，和浏览器里的 JavaScript 是同一个语言家族，
           只是语法上有些细节不同（比如旧版本不支持 let、const、=> 这种 ES6 特性）。
        2. 微软实现的 JavaScript 引擎，并不是浏览器里的现代 JavaScript（没有 DOM、没有 window、没有 document）。
            它运行在 Windows Script Host (WSH) 里，只能使用 WSH 提供的对象，比如：
                WScript.Echo()  → 打印
                WScript.Sleep() → 睡眠
                WScript.CreateObject("Scripting.FileSystemObject") → 文件操作
                WScript.CreateObject("WScript.Shell")              → 运行程序、操作注册表
        3. 最近的 Windows Script Host Version 是 2015年的 5.812，此后一直没有更新过
#>

$WSH_JScript_Path = "$($PSScriptRoot)\02-WSH_JScript.js"
$Auto_JScript_Path = "$($PSScriptRoot)\02-auto.js"

<#
    //nologo
        去掉 cscript 的版权信息
    参数1 参数2
        传参数的时候直接写, 不需要加引号
        PowerShell 会自动拆分为多个参数。
#>
& cscript.exe //nologo $WSH_JScript_Path 参数1 参数2

# 执行微软js的脚本
cscript.exe //nologo $Auto_JScript_Path