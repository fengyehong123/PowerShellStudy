# 参考资料
# https://blog.csdn.net/HoKis/article/details/143923391

$code = @'
[DllImport("user32.dll")] 
public static extern IntPtr SendMessageW(IntPtr hWnd, int Msg, IntPtr wParam, IntPtr lParam);
[DllImport("user32.dll")]
public static extern IntPtr GetForegroundWindow();
'@

# 引入Windows的API
Add-Type -Namespace Windows -MemberDefinition $code -Name 'Windows'
#获取前台窗口句柄
[System.IntPtr]$wi = [Windows.Windows]::GetForegroundWindow()

# 命令消息
$WM_APPCOMMAND = 0x319
# 静音
$APPCOMMAND_VOLUME_MUTE = 0x80000

# 静音
[Windows.Windows]::SendMessageW($wi, $WM_APPCOMMAND, $wi, $APPCOMMAND_VOLUME_MUTE)
