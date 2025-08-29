# 父文件夹
$Paretn_Path = 'F:\99-Windows_Terminal\'
# 壁纸文件夹
$Wallpaper_BK_Path = "$($Paretn_Path)\02-Wallpaper_BK\"
# Windows_Terminal所需壁纸文件路径
$Wallpaper_Path = "$($Paretn_Path)\01-Wallpaper\img.jpg"

# 递归获取所有的壁纸的绝对路径
$Wallpaper_list = Get-ChildItem -Path $Wallpaper_BK_Path -Recurse -File `
| ForEach-Object { $_.FullName }

# 从所有的壁纸中随机获取一张壁纸下标
$Random_Wallpaper_Index = Get-Random -Minimum 1 -Maximum ($Wallpaper_list | Measure-Object).Count
# 获取要移动的壁纸对象
$Random_Wallpaper_Full_Path = $Wallpaper_list[$Random_Wallpaper_Index]

# 复制壁纸路径到指定指定文件夹中，如果有同名文件直接强制覆盖
Copy-Item -Path $Random_Wallpaper_Full_Path -Destination $Wallpaper_Path -Force