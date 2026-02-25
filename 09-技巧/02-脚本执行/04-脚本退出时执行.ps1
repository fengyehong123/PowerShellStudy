# 注册一个 PowerShell 退出事件, 当使用【Ctrl + C】退出脚本的时候, 执行
Register-EngineEvent PowerShell.Exiting -Action {
    Write-Host "Ctrl + C 取消成功, 按下Enter键退出脚本..."
    Pause
    exit
}

while ($true) {
    Write-Host "当前的时间为: $(Get-Date -Format HH:mm:ss)`n按 Ctrl + C 退出`n"
    Start-Sleep -Seconds 3
}