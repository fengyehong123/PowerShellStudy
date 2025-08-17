' sprict code: ANSI
' 注意: 脚本的编码格式应该是ANSI, 否则执行失败
' + --------------------------------------------------------
' 直接调用Powershell代码的话, 会出现窗口一闪而过的情况
' 通过vbs脚本的方式调用Powershell代码, 同时通过vbs指定隐藏窗口的话
' 可以避免窗口一闪而过
' + --------------------------------------------------------

' 创建脚本对象
Set objShell = CreateObject("Wscript.Shell")

' 拼接命令
command = "powershell.exe -NoProfile -ExecutionPolicy Bypass " & _
          "-File ""E:\My_Project\PowerShellStudy\09-技巧\19-压缩文件.ps1"" " & _
          "-TargetFolderPath """ & WScript.Arguments(0) & """"

' 执行命令（隐藏窗口、异步执行）
objShell.Run command, 0, False