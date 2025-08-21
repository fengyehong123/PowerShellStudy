# 获取所有的静态方法
[System.IO.Path] `
| Get-Member -Static -MemberType Method `
| Select-Object -Property Name `
| Out-Host
<#
    Name
    ----
    ChangeExtension
    Combine
    Equals
    GetDirectoryName
    GetExtension
    GetFileName
    GetFileNameWithoutExtension
    GetFullPath
    GetInvalidFileNameChars
    GetInvalidPathChars
    GetPathRoot
    GetRandomFileName
    GetTempFileName
    GetTempPath
    HasExtension
    IsPathRooted
    ReferenceEquals
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

$file_path = 'D:\aaa\新建文本文档.txt'

# ⏹更改文件的扩展名
[IO.Path]::ChangeExtension($file_path, 'ps1') | Out-Host
# D:\aaa\新建文本文档.ps1

# ⏹路径拼接,相当于 Join-Path
[IO.Path]::Combine('D:\', '测试.txt') | Out-Host
# D:\测试.txt

# ⏹返回上级目录对象,相当于 Split-Path -parent
[IO.Path]::GetDirectoryName($file_path) | Out-Host
# D:\aaa

# ⏹返回文件扩展名
[IO.Path]::GetExtension($file_path) | Out-Host
# .txt

# ⏹返回文件名,相当于 Split-Path -leaf
[IO.Path]::GetFileName($file_path) | Out-Host
# 新建文本文档.txt

# ⏹返回不带扩展名的文件名
[IO.Path]::GetFileNameWithoutExtension($file_path) | Out-Host
# 新建文本文档

# ⏹返回绝对路径
[IO.Path]::GetFullPath('.\笔记.md') | Out-Host
# C:\Users\XXX\Desktop\Powershell_Study\笔记.md

# ⏹返回所有不允许出现在文件名中的字符,返回所有不允许出现在路径中的字符
[IO.Path]::GetInvalidFileNameChars() | Out-Host
[IO.Path]::GetInvalidPathChars() | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹返回根目录,相当于 Split-Path -qualifier
[IO.Path]::GetPathRoot($file_path) | Out-Host
# D:\

# ⏹返回一个随机的文件名
[IO.Path]::GetRandomFileName() | Out-Host
# ixcoqzko.3e2

# ⏹在临时目录中返回一个临时文件名
[IO.Path]::GetTempFileName() | Out-Host
# C:\Users\XXX\AppData\Local\Temp\tmp2B22.tmp

# ⏹返回临时文件目录
[IO.Path]::GetTempPath() | Out-Host
# C:\Users\XXX\AppData\Local\Temp\

# ⏹如果路径中包含了扩展名, 则返回True
[IO.Path]::HasExtension($file_path) | Out-Host
# True

# ⏹判断是否为绝对路径,相当于 Split-Path -isAbsolute
[IO.Path]::IsPathRooted('.\笔记.md') | Out-Host
# False