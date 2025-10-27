Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;

public class Keyboard {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, UIntPtr dwExtraInfo);
}
'@

<#
    0xAD 是 静音键(Mute key)的虚拟键码(VK_VOLUME_MUTE)。
        1. 这种方式和操作系统语言、编码、输入法完全无关。
        2. 适用于所有 Windows（中文、日文、英文都行）。
#>
[Keyboard]::keybd_event(0xAD, 0, 0, [UIntPtr]::Zero) # 按下静音键
[Keyboard]::keybd_event(0xAD, 0, 2, [UIntPtr]::Zero) # 松开静音键