<#
    Add-WindowsCapability
        PowerShell 里用来安装 Windows 可选功能（按需功能 / Features on Demand）的命令。

    常见用途：安装
        OpenSSH
        .NET Framework 组件
        语言包
        RSAT（远程服务器管理工具）
#>
#Requires -RunAsAdministrator

# 列出还没有安装的组件
Get-WindowsCapability -Online | Where-Object State -eq "NotPresent"

# 检查并安装 OpenSSH Client
$client = Get-WindowsCapability -Online | Where-Object Name -like "OpenSSH.Client*"
if ($client.State -ne "Installed") {
    Add-WindowsCapability -Online -Name $client.Name
}

# 检查并安装 OpenSSH Server
$server = Get-WindowsCapability -Online | Where-Object Name -like "OpenSSH.Server*"
if ($server.State -ne "Installed") {
    Add-WindowsCapability -Online -Name $server.Name
}

# 判断ssh服务是否存在
if (-not (Get-Service sshd -ErrorAction SilentlyContinue)) {
    Write-Host "sshd 服务不存在，安装可能失败"
    exit
}

# 启动 sshd 服务
Start-Service sshd
# 设置开机自启
Set-Service -Name sshd -StartupType Automatic

Write-Host "OpenSSH安装并配置完成..."