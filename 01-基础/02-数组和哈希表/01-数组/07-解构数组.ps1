# 定义一个数组
$paramArray1 = @(
    'grep',
    '-F',
    '[ERROR]',
    '/path/xxx/file.txt'
)

# 解构数组(解构之后, 会以空格的方式拆分)
Write-Host @paramArray1  # grep -F [ERROR] /path/xxx/file.txt

<#
    ⏹在Powershell中真正运行exe的时候，Powershell会自动把 @paramArray2 里的元素当作独立参数传给 7z.exe
    $CompressionSoft = "E:\soft\7-Zip\7z.exe"
    $paramArray2 = @(
        "a",                                # 添加到压缩包
        "`"$ZipName`"",                     # 输出的 zip 文件（带引号）
        "`"$($ItemFileSystem.FullName)`"",  # 被压缩的文件或目录（带引号）
        "-tzip",                            # 指定为 zip 格式
        "-p${Passwd}",                      # 压缩密码
        "-r"                                # 递归压缩子目录
    )
    & $CompressionSoft @paramArray2
#>
