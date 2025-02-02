# 在当前目录下创建一个文本文件
$file = New-Item -ItemType File jmw.txt

# ⏹查看文件的只读属性
$file.IsReadOnly | Out-Host  # False

# 将文件改为只读
$file.IsReadOnly = $true

# 尝试删除当前文件夹下的刚创建的文件
try {
    Remove-Item -Path "./jmw.txt"
} catch {
    "程序发生异常,异常的原因是:$($_.Exception.Message)" | Out-Host
}

# ⏹删除只读属性的文件,需要添加 -Force 配置项强行删除
Remove-Item -Path "./jmw.txt" -Force
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 待创建文件夹
$path1 = "./test1/A/"
$path2 = "./test1/B/"

# 待创建问价
$file1 = "001.txt"
$file2 = "002.txt"

# 在当前路径下创建新的文件夹
New-Item -ItemType Directory -Path $path1 | Out-Null
New-Item -ItemType Directory -Path $path2 | Out-Null

# 在新创建的文件夹中创建文件
New-Item -ItemType File -Path "$($path1)$($file1)" | Out-Null
New-Item -ItemType File -Path "$($path2)$($file1)" | Out-Null
New-Item -ItemType File -Path "$($path1)$($file2)" | Out-Null
New-Item -ItemType File -Path "$($path2)$($file2)" | Out-Null

# ⏹添加 -WhatIf 参数,模式删除的过程,查看之后会执行的操作
Remove-Item -Path './test1/*/*.txt' -WhatIf | Out-Host
# ⏹删除每一个文件之前,让用户确认是否删除
Remove-Item -Path './test1/*/*.txt' -Confirm | Out-Host

<#
    ⏹当删除一个文件夹的时候,如果文件夹中还有文件,PowerShell会请求用户的批准
    只有删除空文件夹的时候,才不会请求用户批准
#>
Remove-Item -Path './test1/' | Out-Host
# 如果删除文件夹时添加了 -Recurse 参数,则删除的时候,不会有任何提示
Remove-Item -Path './test1/' -Recurse | Out-Host