# 来源
# https://www.pstips.net/powershell-environment-variables.html

# 查看系统中的所有环境变量
Get-ChildItem "Env:"
Write-Host '--------------------------------------------------------------------' -ForegroundColor Red

# ⏹系统中的环境变量
$env:Path

# ⏹模块的安装路径
$env:PSModulePath
Write-Host '=================================='

# ⏹列出系统中所有环境变量
Get-ChildItem env:
Write-Host '----------------------------------'

# ⏹创建新的环境变量,并使用通配符列举出来
$env:jmw_name = '贾飞天'
$env:jmw_address = '地球'
Get-ChildItem env:jmw*
Write-Host '----------------------------------'

<#
    ⏹删除和更新环境变量
        $env: 中的环境变量只是机器环境变量的一个副本,对其修改并不会影响真正的机器环境
#>
# 删除环境变量
Remove-Item env:jmw_name
# 更新环境变量
$env:jmw_address = '月球'
Get-ChildItem env:jmw*

<#
    ⏹将环境变量反映到机器环境上(💥确认好再追加!💥)
    使用 .NET 的方法 [Environment]::SetEnvironmentVariable("变量名", "值", "环境变量类型")
        环境变量类型一共有两种
            Machine: 系统级别的环境变量
            User: 用户级的环境变量
#>
# 获取系统中既存的环境变量
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
$newPath = 'C:\soft'
# 通过 ; 进行分隔两个变量
$newValue = "$currentPath;$newPath"
# 将既存中环境变量中追加内容
[environment]::SetEnvironmentvariable("Path", $newValue, "User")
Write-Host '----------------------------------'

<# 
    ⏹获取当前用户的桌面路径
        PowerShell中,可以通过 [Environment]::GetFolderPath 方法来获取特定系统文件夹的路径
        [Environment+SpecialFolder] 是 PowerShell 中用于访问特定系统文件夹的枚举类型
            Desktop：桌面文件夹
            MyDocuments：我的文档文件夹
            MyComputer：我的电脑
            MyMusic：我的音乐文件夹
            MyPictures：我的图片文件夹
            System：系统文件夹
            ProgramFiles：程序文件夹
            ProgramFilesX86：64 位系统下的 32 位程序文件夹
            Windows：Windows 文件夹
#> 
$desktopPath1 = [Environment]::GetFolderPath([Environment+SpecialFolder]::Desktop)
Write-Output $desktopPath1 | Out-Host

# ⏹用这种方式也可以获取桌面文件夹的路径
[Environment]::GetFolderPath('Desktop') | Out-Host

# ⏹用$Home的方式更简单些
$desktopPath2 = "$Home\Desktop"
if ($desktopPath1 -eq $desktopPath2) {
    Write-Host '路径相同!'
}