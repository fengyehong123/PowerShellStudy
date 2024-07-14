# 写入文本到文件
[System.IO.File]::WriteAllText("C:\NewFolder\test.txt", "Hello, PowerShell!")

$fullPath = ""
# 打开文本文件,将内容全部读进内存
$file = [IO.File]::OpenText($fullPath)

# 通过While循环逐行读取文本文件内容
while (-not $file.EndOfStream) {
    $file.ReadLine() | Out-Host
}

# 关闭文件对象
$file.Close()