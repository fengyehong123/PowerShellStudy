# 存储在本地机器上的应用程序数据
$env:LOCALAPPDATA  # C:\Users\Admin\AppData\Local

# 用户目录
$env:USERPROFILE  # C:\Users\Admin

# 应用程序公有数据目录
Get-ChildItem "$env:CommonProgramFiles"  # C:\Program Files\Common Files

# 具体应用程序安装的目录
Get-ChildItem "${env:ProgramFiles}"  # C:\Program Files
Get-ChildItem "${env:ProgramFiles(x86)}"  # C:\Program Files (x86)

# 存储应用程序数据的公共文件夹
$env:ProgramData  # C:\ProgramData

# 所有本地用户的公有目录
$env:PUBLIC  # C:\Users\Public

# 当前用户的应用数据文件夹的路径
$env:APPDATA  # C:\Users\Admin\AppData\Roaming

# 当前用户的临时目录
$env:TMP  # C:\Users\Admin\AppData\Local\Temp
$env:TEMP  # C:\Users\Admin\AppData\Local\Temp

# Windows系统安装的目录
$env:windir  # C:\WINDOWS
Write-Host '------------------------------------------------' -ForegroundColor Red

# 用户自己配置的环境变量
$java_home = "$env:JAVA_HOME"
Write-Host "$java_home"
Write-Host '------------------------------------------------' -ForegroundColor Red

# 获取Path中的配置的环境变量
[string]$pathInfo = "$env:Path"
[string[]]$pathArray = $pathInfo.Split(';', [System.StringSplitOptions]::RemoveEmptyEntries)
$pathArray | ForEach-Object {
    $_ | Out-Host
}