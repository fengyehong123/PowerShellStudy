# ===============================
# 一键安装 / 卸载：右键截图（无窗口版）
# ===============================

$choice = Read-Host "输入 a 安装，输入 d 卸载"

# 脚本文件路径
$psScriptPath  = "$env:USERPROFILE\Screenshot.ps1"
$vbsScriptPath = "$env:USERPROFILE\Screenshot.vbs"

# ===============================
# PowerShell 截图脚本文本
# ===============================
$psScript = @'
# 加载系统库
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# 创建截图文件名称
$desktop = [Environment]::GetFolderPath("Desktop")
$time = Get-Date -Format "yyyy-MM-dd_HH-mm-ss-fff"
$file = Join-Path $desktop "$time.png"

# 创建截图对象
$screen = [System.Windows.Forms.SystemInformation]::VirtualScreen
$bitmap = New-Object System.Drawing.Bitmap $screen.Width, $screen.Height
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)

# 截图保存
$graphics.CopyFromScreen($screen.Left, $screen.Top, 0, 0, $bitmap.Size)
$bitmap.Save($file)

# 对象销毁
$graphics.Dispose()
$bitmap.Dispose()
'@

# ===============================
# VBS（静默调用）脚本文本
# ===============================
$vbsScript = @"
Set ws = CreateObject("WScript.Shell")
' 为了防止部分电脑没有配置环境变量, 自动寻找powershell.exe文件所在的路径
ps = ws.ExpandEnvironmentStrings("%SystemRoot%") & "\System32\WindowsPowerShell\v1.0\powershell.exe"
' 使用WScript调用静默powershell脚本
ws.Run ps & " -WindowStyle Hidden -ExecutionPolicy Bypass -File ""$psScriptPath""", 0
"@

# 环境变量路径
$regPath = "Registry::HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\Screenshot"
$commandPath = "$regPath\command"

if ($choice -ieq "a") {


    # 创建PowerShell截图脚本文件
    Set-Content -Path $psScriptPath -Value $psScript -Encoding UTF8
    # 创建vbs调用文件
    Set-Content -Path $vbsScriptPath -Value $vbsScript -Encoding Unicode

    # 右键菜单名称和图标写入
    New-Item -Path $regPath -Force | Out-Null
    Set-ItemProperty -Path $regPath -Name "MUIVerb" -Value "截屏到桌面"
    Set-ItemProperty -Path $regPath -Name "Icon" -Value "$env:windir\System32\Shell32.dll,240"

    # 右键菜单脚本写入
    New-Item -Path $commandPath -Force | Out-Null
    Set-ItemProperty -Path $commandPath -Name "(Default)" -Value "wscript.exe `"$vbsScriptPath`""
    Write-Host "安装完成！右键桌面即可截图（无窗口）" -ForegroundColor Green

} elseif ($choice -ieq "d") {

    # ===============================
    # 卸载
    # ===============================
    Remove-Item -Path $regPath -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path $psScriptPath -Force -ErrorAction SilentlyContinue
    Remove-Item -Path $vbsScriptPath -Force -ErrorAction SilentlyContinue
    Write-Host "已卸载完成" -ForegroundColor Yellow

} else {
    Write-Host "输入错误"
}

Pause