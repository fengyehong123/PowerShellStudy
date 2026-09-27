# 根据进程名称获取进程信息
Get-Process -Name i2pd -ErrorAction SilentlyContinue
Get-Process -Name '*i2*'

# 启动一个进程
$file_Path = "xxxxxx"
Start-Process -FilePath "powershell.exe" `
              -ArgumentList "-NoProfile -ExecutionPolicy RemoteSigned -File $($file_Path)" `
              -Verb RunAs

# 停止进程
Stop-Process -Name explorer -Force

