# 来源
# https://www.pstips.net/powershell-do-while-loop.html

<#
    ⏹逐行读取文本文件内容
#>

$fullPath = "$($Home)\Desktop\密码.txt"
if (-not (Test-Path -Path $fullPath)) {
    '指定的文本文件不存在' | Out-Host
    return
}

# 打开文本文件,将内容全部读进内存
$file = [IO.File]::OpenText($fullPath)
# 通过While循环逐行读取文本文件内容
while (-not $file.EndOfStream) {
    $file.ReadLine() | Out-Host
}

# 关闭文件对象
$file.Close()
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red
