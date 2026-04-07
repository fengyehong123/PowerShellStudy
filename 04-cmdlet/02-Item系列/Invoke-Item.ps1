# 使用该文件关联的默认打开方式打开文件
$rarFileName = "$Home\Desktop\awk_examples.rar"

# 由于.rar文件关联了WinRAR, 因此该压缩文件会被WinRAR打开
Invoke-Item "$rarFileName"