# 通过 Start-Process 开启一个新进程，在新进程中静默执行ps脚本
Start-Process powershell.exe '-NoProfile -ExecutionPolicy RemoteSigned -File 脚本名称.ps1' -WindowStyle Hidden