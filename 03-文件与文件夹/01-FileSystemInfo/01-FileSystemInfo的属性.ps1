# 定义一个文件夹路径字符串
$TargetFolderPath= "D:\log"
# 定义一个文件路径字符串
$TargetFilerPath= "D:\log\CBC_SystemLog.log"

<#
    通过 Get-Item 获取一下, 将其转化为 FileSystemInfo 对象
    转化为 FileSystemInfo 对象之后，就可以使用文件或者文件夹的属性方法
#>
[IO.FileSystemInfo]$ItemFolder = Get-Item -LiteralPath "$TargetFolderPath"
# 如果明确的知道是【文件夹】的话，可以直接指定 【DirectoryInfo】 类型
[IO.DirectoryInfo]$ItemFolder_test = Get-Item -LiteralPath "$TargetFolderPath"
$ItemFolder_test | Out-Host

[IO.FileSystemInfo]$ItemFile = Get-Item -LiteralPath "$TargetFilerPath"
# 如果明确的知道是【文件】的话，可以直接指定 【FileInfo】 类型
[IO.FileInfo]$ItemFile_test = Get-Item -LiteralPath "$TargetFilerPath"
$ItemFile_test | Out-Host
Write-Host '--------------------------------------------------------------------' -ForegroundColor Red

# 判断是否是文件夹
$ItemFolder.PSIsContainer | Out-Host  # True
$ItemFile.PSIsContainer | Out-Host  # False

# 完整路径
$ItemFolder.FullName | Out-Host  # D:\log
$ItemFile.FullName | Out-Host  # D:\log\CBC_SystemLog.log

# 获取 文件/文件夹 名称, 不包含路径
$ItemFolder.Name | Out-Host  # log
$ItemFile.Name | Out-Host  # CBC_SystemLog.log

# 获取拓展名
$ItemFolder.Extension | Out-Host # 文件夹没有拓展名 
$ItemFile.Extension | Out-Host   # .log

# 判断是否存在
$ItemFolder.Exists | Out-Host # True
$ItemFile.Exists | Out-Host   # True
