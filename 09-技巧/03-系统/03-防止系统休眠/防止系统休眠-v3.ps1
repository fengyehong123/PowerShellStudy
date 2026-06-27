# SetThreadExecutionState 是 kernel32.dll 中的Windows API
# 作用是: 通知系统当前线程正在执行关键任务，系统不要休眠。
Add-Type @"
using System;
using System.Runtime.InteropServices;

public class PowerHelper {
    [DllImport("kernel32.dll")]
    public static extern uint SetThreadExecutionState(uint esFlags);
}
"@

# 让设置持续生效, 而不是一次性
$ES_CONTINUOUS       = [uint32]1 -shl 31  # 0x80000000
# 防止系统休眠
$ES_SYSTEM_REQUIRED  = [uint32]0x00000001
# 防止显示器关闭
$ES_DISPLAY_REQUIRED = [uint32]0x00000002

# 开启保持唤醒
function Enable-KeepAwake {
    [PowerHelper]::SetThreadExecutionState($ES_CONTINUOUS -bor $ES_SYSTEM_REQUIRED -bor $ES_DISPLAY_REQUIRED) | Out-Null
}

# 取消唤醒
function Disable-KeepAwake {
    # 只保留 CONTINUOUS, 清除其他标志, 恢复 Windows 正常电源管理
    [PowerHelper]::SetThreadExecutionState($ES_CONTINUOUS) | Out-Null
}

# 调用保持唤醒的函数
Enable-KeepAwake

try {
    while ($true) {
        Write-Host "$(Get-Date -Format HH:mm:ss) 电脑保持唤醒中...`n按 Ctrl + C 退出`n"
        Start-Sleep -Seconds 60
    }
}
finally {
    Disable-KeepAwake
    Write-Host "电脑保持唤醒已经取消...`n"
}