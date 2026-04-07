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
# 注册表文件的路径
$regeditFilePath = "${PSScriptRoot}\01-AddZipMenu.reg"

# 必须用 管理员权限运行 PowerShell，否则可能报错 Access is denied
if (!(Test-Path $regeditFilePath)) {
    Write-Error "注册表文件不存在"
    return
}

try {
    # 导入注册表文件的核心代码
    reg import "$regeditFilePath"
    if ($LASTEXITCODE -eq 0) {
        Write-Host "注册表注册成功。"
    } else {
        Write-Host "注册表导入失败，错误码：$LASTEXITCODE"
    }
} catch {
    Write-Host "程序发生异常,异常的原因是:$($_.Exception.Message)"
}

Pause
