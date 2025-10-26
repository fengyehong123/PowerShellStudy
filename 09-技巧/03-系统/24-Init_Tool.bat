@echo off
setlocal enabledelayedexpansion

:: 设置变量,用来将powershell脚本存储到临时目录中
:: 给脚本名中设置随机数,可防止文件冲突
set "psScript=%temp%\temp_ps_script_%random%.ps1"

:: 读取次脚本中【:: PowerShellStart】之后的powershell代码, 将其添加到临时存储用的powershell脚本中
for /f " delims=:" %%i in ('findstr /n "^:: PowerShellStart$" "%~f0"') do (
    more +%%i "%~f0" > "%psScript%"
)

:: 在bat批处理脚本中调用powershell
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%psScript%"

:: 删除存储脚本用的临时文件
if exist "%psScript%" del "%psScript%"

:: 退出bat批处理脚本
exit /b

:: PowerShellStart
# + ______________________                     ______________________ +
# + ______________________ 以下为PowerShell代码 ______________________ +    
using namespace System.Windows.Forms

# ###################################
# 一. 显示文件扩展名                 #
# ###################################
# 文件夹视图设置的注册表路径
$folderSettingPath = "Registry::\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
# 显示文件扩展名(0: 显示; 1: 非显示)
New-ItemProperty -LiteralPath "${folderSettingPath}" -Name "HideFileExt" -PropertyType "DWord" -Value "0" -Force | Out-Null
Write-Host "Step1: 文件扩展名显示成功!`n" -ForegroundColor Green
# ########################################################################################################################

# ###################################
# 二. 当前系统静音                   #
# ###################################
$code = @"
using System;
using System.Runtime.InteropServices;

public static class AudioControl
{
    [DllImport("user32.dll")]
    public static extern IntPtr SendMessageW(IntPtr hWnd, int Msg, IntPtr wParam, IntPtr lParam);

    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();
}
"@
Add-Type -TypeDefinition $code

# 命令消息
$WM_APPCOMMAND = 0x319
# 静音的常量
$APPCOMMAND_VOLUME_MUTE = 0x80000

# 获取当前的windows广播对象
$HWND_BROADCAST = [AudioControl]::GetForegroundWindow()

# 发送全局的静音消息
[AudioControl]::SendMessageW($HWND_BROADCAST, $WM_APPCOMMAND, [IntPtr]::Zero, [IntPtr]$APPCOMMAND_VOLUME_MUTE) | Out-Null
Write-Host "Step2: 静音成功!`n" -ForegroundColor Green
# ########################################################################################################################

# ###################################
# 三. 当前鼠标光标改为黑色            #
# ###################################
# 注册表文件
$regPath = "HKCU:\Control Panel\Cursors"
# windows鼠标指针资源文件
$cursorPath = "$env:SystemRoot\Cursors"

# 黑色指针文件的资源映射表
$scheme = @{
    AppStarting = "$cursorPath\wait_r.cur"
    Arrow       = "$cursorPath\arrow_r.cur"
    Crosshair   = "$cursorPath\cross_r.cur"
    Help        = "$cursorPath\help_r.cur"
    IBeam       = "$cursorPath\beam_r.cur"
    No          = "$cursorPath\no_r.cur"
    NWPen       = "$cursorPath\pen_r.cur"
    SizeAll     = "$cursorPath\move_r.cur"
    SizeNESW    = "$cursorPath\size1_r.cur"
    SizeNS      = "$cursorPath\size4_r.cur"
    SizeNWSE    = "$cursorPath\size2_r.cur"
    SizeWE      = "$cursorPath\size3_r.cur"
    UpArrow     = "$cursorPath\up_r.cur"
    Wait        = "$cursorPath\busy_r.cur"
}

# 修改注册表中关于鼠标指针的资源文件路径
foreach ($key in $scheme.Keys) {
    Set-ItemProperty -Path $regPath -Name $key -Value $scheme[$key]
}

# 修改注册表中的鼠标指针颜色
Set-ItemProperty -Path $regPath -Name "(Default)" -Value "Windows Black"
Set-ItemProperty -Path $regPath -Name "Scheme Source" -Value 2

# 调用 SystemParametersInfo , 让修改立即生效
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class NativeMethods {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SystemParametersInfo(int uAction, int uParam, IntPtr lpvParam, int fuWinIni);
}
"@
[NativeMethods]::SystemParametersInfo(0x57, 0, [IntPtr]::Zero, 0x02) | Out-Null
Write-Host "Step3: 鼠标光标变为黑色成功!`n" -ForegroundColor Green
# ########################################################################################################################

# ###################################
# 四. WinScp添加服务器配置信息       #
# ###################################
Add-Type -AssemblyName System.Windows.Forms

# BOM字符串
$BOMStr = "%EF%BB%BF"
# 作业文件夹
$desktopPath = "$Home\Desktop"
# 被Uri编码之后的当前用户桌面路径
$uriDecodePath = [System.Uri]::EscapeDataString("$desktopPath".replace("C:", ""))
# 服务器别名
$ServerAlias = "ubuntu24-Server"

# WinScp安装路径下的dll文件
$dllPath = "${env:ProgramFiles(x86)}\WinSCP\WinSCPnet.dll"
# WinScp基本注册表路径
$BaseRegPath = "HKCU:\SOFTWARE\Martin Prikryl\WinSCP 2\"

# WinScp待添加主机参数(添加一次成功后, 从注册表查看该信息)
[hashtable]$SessionHash = @{
    LocalDirectory  = "${BOMStr}C:$($uriDecodePath)"
    HostName        = "192.168.137.129"
    UserName        = "apluser"
    Password        = "A35C4150C11E948F8020485BC88241373D2C30292F392E6D656E726D6A64726D6F6B726D6E653D2C30292F392E6643206CBE"
    # 服务器上的作业文件夹
    RemoteDirectory = "/home/apluser/work/20250412"
    # RemoteDirectory = "/home/apluser/work/$(Get-Date -Format "yyyy/MM/dd")"
    # 文件名是否自动通过utf-8编码: 否
    Utf             = "0x00000000"
}

# 服务器公钥 
$HostPublicKeyInfo = "vW4uUy6GP4C8BTInJGMSK6r5viWx2vw9nTM2uAq/Mgg"
# 服务器指纹
$HostFingerPrint = "0x6c7d5c4d4b41f36a22740b59c0dd229619bf00ca46fc61500b2a2f81e1526a25,0x6a783b31fa04d999019467e7b36aec27c19bb05d8e7bb839dac488fe825e72f7"

function Get-SshFingerprint {

    param(
        [string]$ipAddress,
        [string]$userName,
        [string]$dll
    )

    if (-not (Test-Path $dll)) { 
        [MessageBox]::Show("找不到:${dll},请确认WinScp的安装路径", "ERROR", [MessageBoxButtons]::OK, [MessageBoxIcon]::Error)
        exit
    }

    # 添加dll文件到当前脚本运行环境中
    Add-Type -Path $dll

    # 创建WinScp对象
    $sessionOptions = New-Object WinSCP.SessionOptions -Property @{
        Protocol = [WinSCP.Protocol]::Sftp
        HostName = $ipAddress
        UserName = $userName
    }

    [string]$fingerprint = ""
    $session = New-Object WinSCP.Session
    try {
        # 第二参数可为 "SHA-256" / "MD5" / "SHA-1" （取决 WinSCP 版本）
        $fingerprint = $session.ScanFingerprint($sessionOptions, "SHA-256")
    } finally {
        $session.Dispose()
    }

    # 获取出服务器公钥指纹
    return $fingerprint.Split(' ')[2]
}

function Add-FingerPrint {

    param (
        [string]$PublicKey,
        [string]$FingerPrint
    )

    # host名称与host路径
    $HostName = "ssh-ed25519@22:$($SessionHash['HostName'])"
    $SshHostFolderPath = "$BaseRegPath\SshHostKeys"

    # 获取公钥简要信息
    $Server_PublicKey = Get-SshFingerprint -ipAddress $SessionHash['HostName'] -userName $SessionHash['UserName'] -dll $dllPath
    if ($PublicKey -ne $Server_PublicKey) {
        [MessageBox]::Show("服务器指纹发生变化!", "WARN", [MessageBoxButtons]::OK, [MessageBoxIcon]::Warning)
        Write-Host "新的公钥指纹为: ${Server_PublicKey}"
        return
    }

    # 若指纹文件存在, 停止创建
    $HostKeyExistFlag = (Test-Path $SshHostFolderPath) -and ((Get-Item $SshHostFolderPath).GetValueNames() -contains $HostName)
    if ($HostKeyExistFlag) {
        return
    }

    # 添加指纹信息到注册表
    New-ItemProperty -Path $SshHostFolderPath -Name $HostName -Value $FingerPrint | Out-Null
}

function Add-ServerInfo {

    # Session路径
    $SessionsRegPath = "$BaseRegPath\Sessions\$ServerAlias"

    # 若当前服务器的配置文件夹存在
    if (Test-Path $SessionsRegPath) {
        return
    }

    # 新建服务器配置文件夹
    New-Item -Path $SessionsRegPath -Force | Out-Null

    # 添加服务器信息到注册表
    foreach ($key in $SessionHash.Keys) {
        # 如果是Utf的key的话, 使用16进制的数据
        $type = if ($key -eq 'Utf') { 'DWord' } else { 'String' }
        New-ItemProperty -Path $SessionsRegPath -Name $key -PropertyType $type -Value $SessionHash[$key] | Out-Null
    }
}

# 添加服务器指纹到注册表
Add-FingerPrint -PublicKey $HostPublicKeyInfo -FingerPrint $HostFingerPrint
# 添加服务器信息到注册表
Add-ServerInfo
Write-Host "Step4: WinScp配置成功!`n" -ForegroundColor Green
# ########################################################################################################################

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

# ###################################
# 五. 刷新桌面和打开的文件夹          #
# ###################################
function Start-Refresh {

    # 刷新文件夹
    $shell = New-Object -ComObject Shell.Application
    foreach ($window in $shell.Windows()) {
        try { $window.Refresh() } catch {}
    }

    # 发送通知, 刷新桌面
    $progman = [RefreshTool.Win32]::FindWindow("Progman", "Program Manager")
    [RefreshTool.Win32]::PostMessage($progman, [RefreshTool.Win32]::WM_KEYDOWN, [RefreshTool.Win32]::VK_F5, 0) | Out-Null
}

Start-Refresh
Write-Host "Step5: 刷新成功!`n" -ForegroundColor Green

Write-Host "初始化配置完成" -ForegroundColor Red

Pause