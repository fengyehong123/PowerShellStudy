# 弹出框组件
using namespace System.Windows.Forms
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
# ____________________________________________________________________

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

Write-Host "WinScp配置完成"

Pause