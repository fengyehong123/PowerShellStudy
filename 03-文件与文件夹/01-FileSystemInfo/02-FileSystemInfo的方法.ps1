# 定义一个文件夹路径字符串
$TargetFolderPath = "D:\log"
# 定义一个文件路径字符串
$TargetFilerPath = "D:\log\CBC_SystemLog.log"

<#
    通过 Get-Item 获取一下, 将其转化为 FileSystemInfo 对象
    转化为 FileSystemInfo 对象之后，就可以使用文件或者文件夹的属性方法
#>
[IO.FileSystemInfo]$ItemFolder = Get-Item -LiteralPath "$TargetFolderPath"
[IO.FileSystemInfo]$ItemFile = Get-Item -LiteralPath "$TargetFilerPath"
Write-Host '--------------------------------------------------------------------' -ForegroundColor Red

# 🔴返回路径字符串 相当于 .FullName 属性
$ItemFolder.ToString() | Out-Host  # D:\log
$ItemFile.ToString() | Out-Host    # D:\log\CBC_SystemLog.log

# 🔴删除文件或者文件夹
# $ItemFolder.Delete()
# $ItemFile.Delete()

# 🔴获取指定文件夹下的所有文件,并将这些文件复制到桌面
[IO.DirectoryInfo]$ItemFolder1 = Get-Item -LiteralPath "$TargetFolderPath"
$ItemFolder1.GetFiles() | ForEach-Object {
    
    [IO.FileInfo]$file = $_

    # 🔴文件复制
    $file.CopyTo("$Home\Desktop\$($file.Name)") | Out-Null

    # 🔴文件移动
    $file.MoveTo("$Home\Desktop\$($file.Name)") | Out-Null
}