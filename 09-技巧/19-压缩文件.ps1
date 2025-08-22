param(
    # 目标文件夹
    [string]$TargetFolderPath = ".", 
    # 是否循环压缩
    [string]$forEachCompressFlag,
    # 压缩包的默认密码
    [string]$Passwd = "123456"
)

# ★★★★★★压缩软件的安装路径和种类★★★★★★
# + -----------------------------------------------------
$CompressionSoft = "C:\软件\压缩软件\WinRAR.exe"
$CompressionSoftCategory = "WinRAR"
# $CompressionSoft = "E:\soft\7-Zip\7z.exe"
# $CompressionSoftCategory = "7z"
# + -----------------------------------------------------

if (-not (Test-Path $CompressionSoft)) {
    Write-Host "错误：未找到指定的压缩软件, 请检查安装路径！" -ForegroundColor Red
    Pause
    exit 1
}

function New-CompressionSoftArgs {

    param (
        [string]$Passwd,
        [string]$ZipName,
        [string]$FullPath
    )

    return [hashtable]@{
        "WinRAR" = @(
            "a",                                # 添加到压缩包
            "-afzip",                           # 指定为 zip 格式
            "-ep1",                             # 不包含根目录
            "-p${Passwd}",                      # 压缩密码
            "`"${ZipName}`"",                   # 输出的 zip 文件（带引号）
            "`"$($ItemFileSystem.FullName)`""   # 被压缩的文件或目录（带引号）
        );
        "7z" = @(
            "a",                                # 添加到压缩包
            "`"$ZipName`"",                     # 输出的 zip 文件（带引号）
            "`"$($ItemFileSystem.FullName)`"",  # 被压缩的文件或目录（带引号）
            "-tzip",                            # 指定为 zip 格式
            "-p${Passwd}",                      # 压缩密码
            "-r"                                # 递归压缩子目录
        )
    }

}

function Invoke-Compression {

    param (
        # .Net的数据类型, 必须要写全数据类型
        [IO.FileSystemInfo]$ItemFileSystem,
        [string]$Passwd,
        [string]$CompressionSoftCategory
    )

    # 要做成的压缩文件的名称
    $ZipName = "$($ItemFileSystem.BaseName).zip"

    # 压缩文件存在就跳过此次循环
    if (Test-Path $(Join-Path -Path $ItemFileSystem.FullName -ChildPath $ZipName)) {
        return
    }

    # 根据压缩软甲的种类指定压缩参数
    [hashtable]$SoftArgsHashTable = @{
        Passwd = $Passwd
        ZipName = $ZipName
        FullPath = $ItemFileSystem.FullName
    }
    [hashtable]$CommandArgsHashtable = New-CompressionSoftArgs @SoftArgsHashTable

    # 根据压缩软件的类型获取其对应的参数
    [string[]]$CommandArgs = $CommandArgsHashtable[$CompressionSoftCategory]
    # 执行压缩命令
    & $CompressionSoft @CommandArgs
}

# 如果需要循环压缩的话
if ($forEachCompressFlag -and "forEachCompressFlag" -eq $forEachCompressFlag) {
    Get-ChildItem -LiteralPath $TargetFolderPath | ForEach-Object {
        Invoke-Compression -ItemFileSystem $_ `
                           -Passwd $Passwd `
                           -CompressionSoftCategory $CompressionSoftCategory
    }
    exit 0;
}

# 如果只压缩单个文件或者文件夹的话
# $TargetFolderPath 只是一个字符串, 通过【Get-Item】获取一下, 转化为[System.IO.FileSystemInfo]类型
[System.IO.FileSystemInfo]$ItemFileSystem = Get-Item -LiteralPath "$TargetFolderPath"
Invoke-Compression -ItemFileSystem $ItemFileSystem `
                   -Passwd "${Passwd}" `
                   -CompressionSoftCategory $CompressionSoftCategory


