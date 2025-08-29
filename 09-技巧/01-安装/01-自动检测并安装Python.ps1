# 通过命令行参数,获取脚本所在的目录
$originalScriptFolder = $args[0]

# 校验当前用户是否有管理员权限
function Test-IsAdmin {

    $id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object System.Security.Principal.WindowsPrincipal($id)

    if ($principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
        return $true
    }

    return $false
}

# 下载文件并处理错误
function Get-PythonInstallPackage {

    param (
        [string]$url,
        [string]$destination
    )

    try {
        Write-Output "正在下载Python安装包..."
        # Start-BitsTransfer 是 PowerShell 用于下载或上传文件的命令，它基于 BITS（后台智能传输服务，Background Intelligent Transfer Service），适用于断点续传和后台下载。
        Start-BitsTransfer -Source $url -Destination $destination -ErrorAction Stop
    } catch {
        Write-Host "下载失败：$($_.Exception.Message)" -ForegroundColor Red
    }
}

# 获取 Python 安装路径
function Get-PythonInstallPath {
    return (Get-Command python -ErrorAction SilentlyContinue).Source
}

# 执行Python代码
function Test-PythonCode {

    try {
        # -u 选项可以强制 Python 立即刷新输出，避免延迟。
        python -u "01-pip依赖库检测自动安装.py"
        python -u "01-爬虫测试.py"
    } catch {
        Write-Host "Python代码执行失败 :$($_.Exception.Message)" -ForegroundColor Red
    }
}

# 获取Python的安装路径
$Python_Installer_Path = Get-PythonInstallPath

# 判断Python的安装路径是否存在
if ($Python_Installer_Path) {

    # 获取当前的Python版本
    $PythonVersion = python --version
    if ($PythonVersion) {
        Write-Host "Python 已安装, 安装路径为: $Python_Installer_Path"
        Write-Host "当前Python版本为: $PythonVersion" -ForegroundColor Red

        # 执行Python代码
        Test-PythonCode

        Read-Host "按 Enter 键退出..."
        exit 0
    }
}

Write-Output "未检测到 Python, 开始下载安装【Python3.13.2】..."

# 若没有管理员权限
if (-not (Test-IsAdmin)) {

    Write-Host "未检测到管理员权限，正在尝试重新启动为管理员模式..." -ForegroundColor Yellow
    try {

        # 用管理员身份执行当前代码, 传入当前脚本所在的绝对路径和绝对路径的父目录
        Start-Process -FilePath "powershell.exe" `
                      -ArgumentList "-NoProfile -ExecutionPolicy RemoteSigned -File $($PSCommandPath) $($PSScriptRoot)" `
                      -Verb RunAs
    } catch {
        Write-Host "脚本运行时发生异常:"
        Write-Host "$_" -ForegroundColor Red
        Write-Host "堆栈跟踪: $($_.Exception.StackTrace)" -ForegroundColor Gray
        Read-Host "按 Enter 键退出..."
    }
    exit
}

Write-Host "已成功以管理员权限运行 PowerShell ..." -ForegroundColor Green
# ------------------------------------------------------------------------------------------------------------------

# 定义 Python 下载 URL 和安装路径
$PythonURL = "https://www.python.org/ftp/python/3.13.2/python-3.13.2-amd64.exe"
$InstallerPath = "$env:TEMP\python_installer.exe"

# Invoke-WebRequest -Uri $PythonURL -OutFile $InstallerPath
Get-PythonInstallPackage -url $PythonURL -destination $InstallerPath

Write-Output "下载成功..."
Get-ChildItem -Path $InstallerPath

if (!(Test-Path $InstallerPath)) {
    Write-Output "下载失败，请检查网络连接。"
    Read-Host "按 Enter 键退出..."
    exit 1
}

Write-Output "Python安装包下载完成, 开始安装..."

<#
    静默安装 Python 并自动配置环境变量：
        /quiet 静默安装（无需手动点击）。
        InstallAllUsers=1 让所有用户可用。
        PrependPath=1 自动添加到系统 Path 环境变量。
#>
Start-Process -FilePath $InstallerPath -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait -NoNewWindow

# 删除安装文件
if (Test-Path $InstallerPath) {
    Remove-Item $InstallerPath -Force
}

# 刷新环境变量
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine")

# 再次检查 Python 是否安装成功
$PythonPath = Get-PythonInstallPath
if ($PythonPath) {

    Write-Host "Python 安装成功, 安装路径为: $PythonPath `n"
    Write-Host "尝试使用Python命令【python --version】来获取当前Python版本" -ForegroundColor Green

    # 执行原生Python命令，获取Python的版本号
    $PythonVersion = python --version
    Write-Host "当前的Python版本为$PythonVersion" -ForegroundColor Red
} else {
    Write-Host "Python 安装失败，请手动检查。"
    exit 1
}

<#
    以管理员权限运行PowShell的时候, 默认的工作目录在【C:\Windows\System32】
    我们需要获取原先shell所在的文件夹路径，然后移动到该路径
#>
# 移动到指定的文件夹目录下
Set-Location -Path "$originalScriptFolder"

# 执行Python代码
Test-PythonCode

Read-Host "按 Enter 键退出..."