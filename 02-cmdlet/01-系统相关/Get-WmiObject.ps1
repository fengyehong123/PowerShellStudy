# 查看操作系统的详细信息，包括版本号。
Get-WmiObject -Class Win32_OperatingSystem | Select-Object -Property *

Pause