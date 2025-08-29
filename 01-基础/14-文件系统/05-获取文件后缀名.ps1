# 桌面上的文件路径(该路径实际上不存在)
$file_path1 = "$($HOME)\Desktop\测试文件.txt"

# ⏹使用 System.IO.Path 来获取(路径可以不实际存在)
[IO.Path]::GetExtension($file_path1) | Out-Host  # .txt

# 桌面上的文件路径(实际存在的该文件)
$file_path2 = "$($HOME)\Desktop\微信双开.bat"

# ⏹使用Get-Item来获取(路径必须实际上存在,否则会报错)
(Get-Item -Path $file_path2).Extension | Out-Host  # .bat

# ⏹使用字符串原生方法
$file_path1.Split('.')[-1] | Out-Host  # txt