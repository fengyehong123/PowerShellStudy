# 参考资料:
# https://www.bathome.net/viewthread.php?tid=70348&extra=page%3D1&ordertype=2

# 刷新桌面的Windows底层API
Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;

namespace RefreshTool
{
    public static class Win32
    {
        public const int WM_KEYDOWN = 0x100;
        public const int VK_F5 = 0x74;

        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

        [DllImport("user32.dll",CharSet = CharSet.Auto)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool PostMessage(IntPtr hWnd, int Msg, IntPtr wParam, IntPtr lParam);

        [DllImport("user32.dll",CharSet = CharSet.Auto)]
        public static extern IntPtr GetDesktopWindow();
    }
}
'@

function Start-Refresh {

    # 刷新文件夹
    $shell = New-Object -ComObject Shell.Application
    foreach ($window in $shell.Windows()) {
        try { $window.Refresh() } catch {}
    }

    # 发送通知, 刷新桌面
    $progman = [RefreshTool.Win32]::FindWindow("Progman", "Program Manager")
    # 模拟按下键盘的F5进行刷新
    [RefreshTool.Win32]::PostMessage($progman, [RefreshTool.Win32]::WM_KEYDOWN, [RefreshTool.Win32]::VK_F5, 0) | Out-Null
}

Start-Refresh
