@echo off
setlocal enabledelayedexpansion

:: ���ñ���,������powershell�ű��洢����ʱĿ¼��
:: ���ű��������������,�ɷ�ֹ�ļ���ͻ
set "psScript=%temp%\temp_ps_script_%random%.ps1"

:: ��ȡ�νű��С�:: PowerShellStart��֮���powershell����, ������ӵ���ʱ�洢�õ�powershell�ű���
for /f " delims=:" %%i in ('findstr /n "^:: PowerShellStart$" "%~f0"') do (
    more +%%i "%~f0" > "%psScript%"
)

:: ��bat������ű��е���powershell
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%psScript%"

:: ɾ���洢�ű��õ���ʱ�ļ�
if exist "%psScript%" del "%psScript%"

:: �˳�bat������ű�
exit /b

:: PowerShellStart
# + ______________________                     ______________________ +
# + ______________________ ����ΪPowerShell���� ______________________ +    
using namespace System.Windows.Forms

# ###################################
# һ. ��ʾ�ļ���չ��                 #
# ###################################
# �ļ�����ͼ���õ�ע���·��
$folderSettingPath = "Registry::\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
# ��ʾ�ļ���չ��(0: ��ʾ; 1: ����ʾ)
New-ItemProperty -LiteralPath "${folderSettingPath}" -Name "HideFileExt" -PropertyType "DWord" -Value "0" -Force | Out-Null
Write-Host "Step1: �ļ���չ����ʾ�ɹ�!`n" -ForegroundColor Green
# ########################################################################################################################

# ###################################
# ��. ��ǰϵͳ����                   #
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

# ������Ϣ
$WM_APPCOMMAND = 0x319
# �����ĳ���
$APPCOMMAND_VOLUME_MUTE = 0x80000

# ��ȡ��ǰ��windows�㲥����
$HWND_BROADCAST = [AudioControl]::GetForegroundWindow()

# ����ȫ�ֵľ�����Ϣ
[AudioControl]::SendMessageW($HWND_BROADCAST, $WM_APPCOMMAND, [IntPtr]::Zero, [IntPtr]$APPCOMMAND_VOLUME_MUTE) | Out-Null
Write-Host "Step2: �����ɹ�!`n" -ForegroundColor Green
# ########################################################################################################################

# ###################################
# ��. ��ǰ������Ϊ��ɫ            #
# ###################################
# ע����ļ�
$regPath = "HKCU:\Control Panel\Cursors"
# windows���ָ����Դ�ļ�
$cursorPath = "$env:SystemRoot\Cursors"

# ��ɫָ���ļ�����Դӳ���
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

# �޸�ע����й������ָ�����Դ�ļ�·��
foreach ($key in $scheme.Keys) {
    Set-ItemProperty -Path $regPath -Name $key -Value $scheme[$key]
}

# �޸�ע����е����ָ����ɫ
Set-ItemProperty -Path $regPath -Name "(Default)" -Value "Windows Black"
Set-ItemProperty -Path $regPath -Name "Scheme Source" -Value 2

# ���� SystemParametersInfo , ���޸�������Ч
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class NativeMethods {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SystemParametersInfo(int uAction, int uParam, IntPtr lpvParam, int fuWinIni);
}
"@
[NativeMethods]::SystemParametersInfo(0x57, 0, [IntPtr]::Zero, 0x02) | Out-Null
Write-Host "Step3: ������Ϊ��ɫ�ɹ�!`n" -ForegroundColor Green
# ########################################################################################################################

# ###################################
# ��. WinScp��ӷ�����������Ϣ       #
# ###################################
Add-Type -AssemblyName System.Windows.Forms

# BOM�ַ���
$BOMStr = "%EF%BB%BF"
# ��ҵ�ļ���
$desktopPath = "$Home\Desktop"
# ��Uri����֮��ĵ�ǰ�û�����·��
$uriDecodePath = [System.Uri]::EscapeDataString("$desktopPath".replace("C:", ""))
# ����������
$ServerAlias = "ubuntu24-Server"

# WinScp��װ·���µ�dll�ļ�
$dllPath = "${env:ProgramFiles(x86)}\WinSCP\WinSCPnet.dll"
# WinScp����ע���·��
$BaseRegPath = "HKCU:\SOFTWARE\Martin Prikryl\WinSCP 2\"

# WinScp�������������(���һ�γɹ���, ��ע���鿴����Ϣ)
[hashtable]$SessionHash = @{
    LocalDirectory  = "${BOMStr}C:$($uriDecodePath)"
    HostName        = "192.168.137.129"
    UserName        = "apluser"
    Password        = "A35C4150C11E948F8020485BC88241373D2C30292F392E6D656E726D6A64726D6F6B726D6E653D2C30292F392E6643206CBE"
    # �������ϵ���ҵ�ļ���
    RemoteDirectory = "/home/apluser/work/20250412"
    # RemoteDirectory = "/home/apluser/work/$(Get-Date -Format "yyyy/MM/dd")"
    # �ļ����Ƿ��Զ�ͨ��utf-8����: ��
    Utf             = "0x00000000"
}

# ��������Կ 
$HostPublicKeyInfo = "vW4uUy6GP4C8BTInJGMSK6r5viWx2vw9nTM2uAq/Mgg"
# ������ָ��
$HostFingerPrint = "0x6c7d5c4d4b41f36a22740b59c0dd229619bf00ca46fc61500b2a2f81e1526a25,0x6a783b31fa04d999019467e7b36aec27c19bb05d8e7bb839dac488fe825e72f7"

function Get-SshFingerprint {

    param(
        [string]$ipAddress,
        [string]$userName,
        [string]$dll
    )

    if (-not (Test-Path $dll)) { 
        [MessageBox]::Show("�Ҳ���:${dll},��ȷ��WinScp�İ�װ·��", "ERROR", [MessageBoxButtons]::OK, [MessageBoxIcon]::Error)
        exit
    }

    # ���dll�ļ�����ǰ�ű����л�����
    Add-Type -Path $dll

    # ����WinScp����
    $sessionOptions = New-Object WinSCP.SessionOptions -Property @{
        Protocol = [WinSCP.Protocol]::Sftp
        HostName = $ipAddress
        UserName = $userName
    }

    [string]$fingerprint = ""
    $session = New-Object WinSCP.Session
    try {
        # �ڶ�������Ϊ "SHA-256" / "MD5" / "SHA-1" ��ȡ�� WinSCP �汾��
        $fingerprint = $session.ScanFingerprint($sessionOptions, "SHA-256")
    } finally {
        $session.Dispose()
    }

    # ��ȡ����������Կָ��
    return $fingerprint.Split(' ')[2]
}

function Add-FingerPrint {

    param (
        [string]$PublicKey,
        [string]$FingerPrint
    )

    # host������host·��
    $HostName = "ssh-ed25519@22:$($SessionHash['HostName'])"
    $SshHostFolderPath = "$BaseRegPath\SshHostKeys"

    # ��ȡ��Կ��Ҫ��Ϣ
    $Server_PublicKey = Get-SshFingerprint -ipAddress $SessionHash['HostName'] -userName $SessionHash['UserName'] -dll $dllPath
    if ($PublicKey -ne $Server_PublicKey) {
        [MessageBox]::Show("������ָ�Ʒ����仯!", "WARN", [MessageBoxButtons]::OK, [MessageBoxIcon]::Warning)
        Write-Host "�µĹ�Կָ��Ϊ: ${Server_PublicKey}"
        return
    }

    # ��ָ���ļ�����, ֹͣ����
    $HostKeyExistFlag = (Test-Path $SshHostFolderPath) -and ((Get-Item $SshHostFolderPath).GetValueNames() -contains $HostName)
    if ($HostKeyExistFlag) {
        return
    }

    # ���ָ����Ϣ��ע���
    New-ItemProperty -Path $SshHostFolderPath -Name $HostName -Value $FingerPrint | Out-Null
}

function Add-ServerInfo {

    # Session·��
    $SessionsRegPath = "$BaseRegPath\Sessions\$ServerAlias"

    # ����ǰ�������������ļ��д���
    if (Test-Path $SessionsRegPath) {
        return
    }

    # �½������������ļ���
    New-Item -Path $SessionsRegPath -Force | Out-Null

    # ��ӷ�������Ϣ��ע���
    foreach ($key in $SessionHash.Keys) {
        # �����Utf��key�Ļ�, ʹ��16���Ƶ�����
        $type = if ($key -eq 'Utf') { 'DWord' } else { 'String' }
        New-ItemProperty -Path $SessionsRegPath -Name $key -PropertyType $type -Value $SessionHash[$key] | Out-Null
    }
}

# ��ӷ�����ָ�Ƶ�ע���
Add-FingerPrint -PublicKey $HostPublicKeyInfo -FingerPrint $HostFingerPrint
# ��ӷ�������Ϣ��ע���
Add-ServerInfo
Write-Host "Step4: WinScp���óɹ�!`n" -ForegroundColor Green
# ########################################################################################################################

# ˢ�������Windows�ײ�API
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
# ��. ˢ������ʹ򿪵��ļ���          #
# ###################################
function Start-Refresh {

    # ˢ���ļ���
    $shell = New-Object -ComObject Shell.Application
    foreach ($window in $shell.Windows()) {
        try { $window.Refresh() } catch {}
    }

    # ����֪ͨ, ˢ������
    $progman = [RefreshTool.Win32]::FindWindow("Progman", "Program Manager")
    [RefreshTool.Win32]::PostMessage($progman, [RefreshTool.Win32]::WM_KEYDOWN, [RefreshTool.Win32]::VK_F5, 0) | Out-Null
}

Start-Refresh
Write-Host "Step5: ˢ�³ɹ�!`n" -ForegroundColor Green

Write-Host "��ʼ���������" -ForegroundColor Red

Pause