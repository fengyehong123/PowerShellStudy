Add-Type -AssemblyName System.Windows.Forms

# 创建Wscript对象
$shell = New-Object -com "Wscript.Shell"
while($true){
    # 输入一个点, 模拟用户正在输入
    $shell.sendkeys(".")
    # 模拟按下不存在的F15键
    [System.Windows.Forms.SendKeys]::SendWait("{F15}")
    # 睡眠1分钟
    Start-Sleep -Seconds 60
}