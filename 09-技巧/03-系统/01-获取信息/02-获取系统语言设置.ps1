# ⏹获取当前系统的区域设置信息
$language_system = (Get-WinSystemLocale).Name
Write-Output "当前系统语言: $language_system"  # 当前系统语言: zh-CN

# ⏹获取当前用户的区域和语言设置
$language_user = [System.Globalization.CultureInfo]::CurrentCulture.Name
Write-Output "当前用户语言: $language_user"  # 当前用户语言: zh-CN