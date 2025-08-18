param(
    # 目标文件夹
    [string]$TargetFolderPath = "C:\Users\贾铭威\Desktop\伪装\123", 
    # 是否循环压缩
    [string]$forEachCompressFlag = "",
    # 压缩包的默认密码
    [string]$Passwd = "nrikddi"
)

# WinRAR 安装路径
$CompressionSoft = "C:\软件\压缩软件\WinRAR.exe"

if (-not (Test-Path $CompressionSoft)) {
    Write-Host "错误：未找到指定的压缩软件, 请检查安装路径！" -ForegroundColor Red
    Pause
    exit 1
}

function Invoke-Compression {

    param (
        [System.IO.FileSystemInfo]$ItemFileSystem,
        [string]$Passwd
    )

    # 判断种类
    if ($ItemFileSystem.PSIsContainer) {
        Write-Host "文件夹"
    } else {
        Write-Host "文件"
    }

    # 要做成的压缩文件的名称
    $ZipName = "$($ItemFileSystem.BaseName).zip"

    # 压缩文件存在就跳过此次循环
    if (Test-Path $(Join-Path -Path $ItemFileSystem.FullName -ChildPath $ZipName)) {
        return
    }

    # 构建压缩软件所用到的参数
    $CommandArgs = @(
        "a",                          # 添加到压缩包
        "-afzip",                     # 指定为 zip 格式
        "-ep1",                       # 不包含根目录
        "-p${Passwd}",                # 压缩密码
        "`"${ZipName}`"",             # 输出的 zip 文件（带引号）
        "`"$($ItemFileSystem.FullName)`""   # 被压缩的文件或目录（带引号）
    )

    # 执行压缩命令
    & $CompressionSoft @CommandArgs
}

# 如果需要循环压缩的话
if ($forEachCompressFlag -and "forEachCompressFlag" -eq $forEachCompressFlag) {
    Get-ChildItem -LiteralPath $TargetFolderPath | ForEach-Object {
        Invoke-Compression -ItemFileSystem $_ -Passwd $Passwd
    }
    exit 0;
}

# 如果只压缩单个文件或者文件夹的话
# $TargetFolderPath 只是一个字符串, 通过【Get-Item】获取一下, 转化为[System.IO.FileSystemInfo]类型
[System.IO.FileSystemInfo]$ItemFileSystem = Get-Item -LiteralPath "$TargetFolderPath"
Invoke-Compression -ItemFileSystem $ItemFileSystem -Passwd "${Passwd}"


