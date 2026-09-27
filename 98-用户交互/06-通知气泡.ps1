# 加载 WinRT 的运行时库，让 PowerShell 能识别和使用 Windows 的现代 API（比如通知、磁贴、日历等）
Add-Type -AssemblyName System.Runtime.WindowsRuntime
# 把 WinRT 类引入到当前 PowerShell 会话中
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null

# 创建通知模板
$template = [ToastNotificationManager]::GetTemplateContent(
    [ToastTemplateType]::ToastText02
)

# 创建通知文本
$textNodes = $template.GetElementsByTagName('text')
$textNodes.Item(0).AppendChild($template.CreateTextNode('通知测试')) | Out-Null
$textNodes.Item(1).AppendChild($template.CreateTextNode('这是一条测试通知。')) | Out-Null

# 推送通知
$notifier = [ToastNotificationManager]::CreateToastNotifier('PowerShell')
$notifier.Show([ToastNotification]::new($template))

