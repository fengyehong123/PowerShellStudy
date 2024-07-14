# 获取桌面上的指定文件夹路径
$target_path = "$($Home)\Desktop\Java笔记\01-Java总结\03-Java_web\day01_http&tomcat"

# 获取指定文件夹下的所有文件
$file_list = Get-ChildItem -Path $target_path -Recurse -File

# ⏹默认情况下根据Name属性排序
$file_list | Sort-Object
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹可以指定属性来排序(默认是升序排序)
# 此处指定为降序排序
$file_list | Sort-Object Length -Descending
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹先根据大小降序,再根据名称升序
$file_list | Sort-Object (
    @{Expression="Length";Descending=$true} `
    , @{Expression="Name";Ascending=$true}
)