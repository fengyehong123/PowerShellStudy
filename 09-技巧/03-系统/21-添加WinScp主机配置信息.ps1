# BOM字符串
$BOMStr = "%EF%BB%BF"
# 作业文件夹
$desktopPath = "$Home\Desktop"
# 被Uri编码之后的当前用户桌面路径
$uriDecodePath = [System.Uri]::EscapeDataString("$desktopPath".replace("C:", ""))
# 服务器别名
$ServerAlias = "ubuntu24-Server"

# WinScp待添加主机参数(添加一次成功后, 从注册表查看该信息)
[hashtable]$SessionHash = @{
    LocalDirectory  = "${BOMStr}C:$($uriDecodePath)"
    HostName        = "192.168.137.129"
    UserName        = "apluser"
    Password        = "A35C4150C11E948F8020485BC88241373D2C30292F392E6D656E726D6A64726D6F6B726D6E653D2C30292F392E6643206CBE"
    RemoteDirectory = "/home/apluser/work/20250412"
    # 文件名是否自动通过utf-8编码: 否
    Utf             = "0x00000000"
}

# WinScp基本注册表路径
$BaseRegPath = "HKCU:\SOFTWARE\Martin Prikryl\WinSCP 2\"
# Session路径
$SessionsRegPath = "$BaseRegPath\Sessions\$ServerAlias"

# 若当前服务器的配置文件夹不存在
if (-not (Test-Path $SessionsRegPath)) {

    # 新建服务器配置文件夹
    New-Item -Path $SessionsRegPath -Force | Out-Null

    # 添加服务器信息到注册表
    foreach ($key in $SessionHash.Keys) {
        # 如果是Utf的key的话, 使用16进制的数据
        $type = if ($key -eq 'Utf') { 'DWord' } else { 'String' }
        New-ItemProperty -Path $SessionsRegPath -Name $key -PropertyType $type -Value $SessionHash[$key] | Out-Null
    }
}

# host名称与host路径
$HostName = "ssh-ed25519@22:$($SessionHash['HostName'])"
$SshHostFolderPath = "$BaseRegPath\SshHostKeys"

# 若指纹文件不存在, 则新建
$HostKeyExistFlag = (Test-Path $SshHostFolderPath) -and ((Get-Item $SshHostFolderPath).GetValueNames() -contains $HostName)
if (-not $HostKeyExistFlag) {
    # 服务器指纹
    $HostFingerPrint = "0x6c7d5c4d4b41f36a22740b59c0dd229619bf00ca46fc61500b2a2f81e1526a25,0x6a783b31fa04d999019467e7b36aec27c19bb05d8e7bb839dac488fe825e72f7"
    New-ItemProperty -Path $SshHostFolderPath -Name $HostName -Value $HostFingerPrint | Out-Null
}