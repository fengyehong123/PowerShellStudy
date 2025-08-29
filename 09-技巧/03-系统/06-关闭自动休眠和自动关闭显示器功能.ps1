<# 关闭 Windows 在插电状态下的自动休眠和自动关闭显示器功能。#>

# /change monitor-timeout → 修改显示器关闭的超时时间。
# -ac → 表示 交流电模式（笔记本插着电源时的设置）。
# 0 → 表示 永不关闭显示器。
powercfg.exe /change monitor-timeout -ac 0

# /change standby-timeout → 修改系统待机（睡眠）的超时时间。
# -ac → 同样表示 交流电模式。
# 0 → 表示 永不进入待机。
powercfg.exe /change standby-timeout -ac 0