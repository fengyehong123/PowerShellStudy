# 杀死文件管理器进程
taskkill /F /IM explorer.exe

# 修改注册表, 恢复为win10风格的右键菜单
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve

# 恢复为win11风格
# reg.exe delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f

# 重新启动文件管理器
Start-Process explorer.exe
