param(
    [string]$originalScriptFolderPath
)

# 校验当前用户是否有管理员权限
function Test-IsAdmin {

    $id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object System.Security.Principal.WindowsPrincipal($id)

    if ($principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
        return $true
    }

    return $false
}

# 若没有管理员权限
if (-not (Test-IsAdmin)) {

    Write-Host "未检测到管理员权限，正在尝试重新启动为管理员模式..." -ForegroundColor Yellow
    # 暂停1秒钟
    Start-Sleep -Seconds 1

    try {
        
        Start-Process -FilePath "powershell.exe" `
                      -ArgumentList "-NoProfile -ExecutionPolicy RemoteSigned -File $($PSCommandPath) -originalScriptFolderPath $($PSScriptRoot)" `
                      -Verb RunAs
    } catch {
        Write-Host "脚本运行时发生异常:"
        Write-Host "$_" -ForegroundColor Red
        Write-Host "堆栈跟踪: $($_.Exception.StackTrace)" -ForegroundColor Gray
        Read-Host "按 Enter 键退出..."
    }
    exit
}

Write-Host "已成功以管理员权限运行PowerShell,开始追加注册表 ...`n" -ForegroundColor Green

# 当以管理员权限运行脚本的时候, 作业目录默认会移动到【C:\WINDOWS\system32】下
# 我们手动将作业目录其移动到脚本所在的文件夹路径
if ($null -ne $originalScriptFolderPath) {
    Set-Location $originalScriptFolderPath
}
# ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 添加注册表部分 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

# 要新增的注册表名称
$addRegistryItem = 'ZipWithPassword'
# 定义当前用户下的注册表路径（不需要管理员权限）
$baseKey = "HKCU:\Software\Classes\Directory\Background\shell\$addRegistryItem"
# vbs脚本的路径
$scriptFilePath = "E:\My_Project\PowerShellStudy\09-技巧\19-RunHidden.vbs"

# ⏹1. 通过注册表创建主菜单项
if (-not (Test-Path $baseKey)) {
    New-Item -Path $baseKey -Force | Out-Null
}
# 设置显示名称
Set-ItemProperty -Path $baseKey -Name "(default)" -Value "压缩并加密为ZIP"
# 设置显示名称对应的图标
Set-ItemProperty -Path $baseKey -Name "Icon" -Value "powershell.exe"

# ⏹2. 通过注册表创建 command 子项
$commandKey = "$baseKey\command"
if (-not (Test-Path $commandKey)) {
    New-Item -Path $commandKey -Force | Out-Null
}

# 设置执行命令
#   %V → 当前右键点击文件夹背景所在的路径, 该参数会由注册表传递
$commandValue = 'wscript.exe "' + $scriptFilePath + '" "%V"'
Set-ItemProperty -Path $commandKey -Name "(default)" -Value $commandValue

# 读取用户在控制台上的输入
Read-Host @"
注册表添加成功~
按下任意键结束程序=_=
"@
