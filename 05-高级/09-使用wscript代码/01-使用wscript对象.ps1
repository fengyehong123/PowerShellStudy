# ⏹创建 WScript.Shell 对象
$shell = New-Object -ComObject WScript.Shell

# 执行系统命令
$command = "cmd.exe /c dir"
$exec = $shell.Exec($command)
$exec.StdOut.ReadAll() | Out-Host

# 弹出消息框,5秒之后消失
$shell.Popup("WScript.Shell执行完毕!", 5, "提示", 0)

# 获取当前登录的用户名
$loginUser = "$env:USERNAME"
$shell.Popup("当前登录的用户名是:${loginUser}", 0, "提示", 64)
