# 创建Wscript对象
$shell = New-Object -com "Wscript.Shell"
while($true){
    # 输入一个点, 模拟用户正在输入
    $shell.sendkeys(".")
    # 睡眠1分钟
    Start-Sleep -Seconds 60
}