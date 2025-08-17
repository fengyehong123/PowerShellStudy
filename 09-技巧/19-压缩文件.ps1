param(
    # 目标文件夹
    [string]$TargetFolderPath = ".", 
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

# 遍历目标文件夹
Get-ChildItem -LiteralPath $TargetFolderPath | ForEach-Object {

    $Item = $_
    # $Item.BaseName → 获取不带后缀的文件名
    $ZipName = "$($Item.BaseName).zip"

    # 压缩文件存在就跳过此次循环
    if (Test-Path $ZipName) {
        return
    }

    # 构建压缩软件所用到的参数
    $CommandArgs = @(
        "a",                     # 添加到压缩包
        "-afzip",                # 指定为 zip 格式
        "-ep1",                  # 不包含根目录
        "-p${Passwd}",           # 压缩密码
        "`"${ZipName}`"",        # 输出的 zip 文件（带引号）
        "`"$($Item.FullName)`""  # 被压缩的文件或目录（带引号）
    )

    # 执行压缩命令
    & $CompressionSoft @CommandArgs
}


