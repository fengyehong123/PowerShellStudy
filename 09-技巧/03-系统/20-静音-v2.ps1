# C#代码, 在其中引入Windows的API
$code = @"
using System;
using System.Runtime.InteropServices;

public static class AudioControl
{
    [DllImport("user32.dll")]
    public static extern IntPtr SendMessageW(IntPtr hWnd, int Msg, IntPtr wParam, IntPtr lParam);

    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();
}
"@

# 在当前脚本中引入C#代码
Add-Type -TypeDefinition $code

# 命令消息
$WM_APPCOMMAND = 0x319
# 静音的常量
$APPCOMMAND_VOLUME_MUTE = 0x80000

# 获取当前的windows广播对象
$HWND_BROADCAST = [AudioControl]::GetForegroundWindow()

# 发送全局的静音消息
[AudioControl]::SendMessageW($HWND_BROADCAST, $WM_APPCOMMAND, [IntPtr]::Zero, [IntPtr]$APPCOMMAND_VOLUME_MUTE) | Out-Null

