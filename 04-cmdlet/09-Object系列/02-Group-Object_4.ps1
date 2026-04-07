# 获取桌面上的指定文件夹路径
$target_path = "$($Home)\Desktop\Java笔记\01-Java总结"

# 获取指定文件夹下的所有文件
$file_list = Get-ChildItem -Path $target_path -Recurse -File

# ⏹根据文件大小来分组 
$file_list | Group-Object {$_.Length -gt 5kb}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹根据文件的首字母分组
$file_list | Group-Object {$_.name.SubString(0,1)}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹根据当前应用的发布者分组
Get-Process | Group-Object Company
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹根据当前的服务状态分组
Get-Service | Group-Object Status
