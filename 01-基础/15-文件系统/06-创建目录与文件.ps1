$folder_result_list = @((Test-Path('./folder1')),(Test-Path('./folder2')),(Test-Path('./folder3')))


if (-not ($folder_result_list -contains $false)) {
    Remove-Item -Path './folder1','./folder2','./folder3' -Recurse -Force
}

<#
    ⏹创建文件夹
#>
# 方式1
mkdir ./folder1
# 方式2
New-Item -ItemType Directory -Path './folder2'
# 创建多层文件夹
New-Item -ItemType Directory -Path './folder3/other'
