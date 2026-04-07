<#
    因为要删除的是系统级别的注册表(HKEY_CLASSES_ROOT)，而不是用户级别的注册表
    因此该脚本需要通过管理员的权限执行
#>

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
                      -ArgumentList "-NoProfile -ExecutionPolicy RemoteSigned -File $($PSCommandPath)" `
                      -Verb RunAs
    } catch {
        Write-Host "脚本运行时发生异常:"
        Write-Host "$_" -ForegroundColor Red
        Write-Host "堆栈跟踪: $($_.Exception.StackTrace)" -ForegroundColor Gray
        Read-Host "按 Enter 键退出..."
    }
    exit
}
Write-Host "已成功以管理员权限运行PowerShell,开始删除指定注册表项目...`n" -ForegroundColor Green
# ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 删除注册表部分 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

# 要删除的注册表名称
$deleteRegistryItem = 'ZipWithPassword'
# 删除指定注册表项
Remove-Item -Path "Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\${deleteRegistryItem}" -Recurse -Force

Read-Host @"
注册表指定项目删除成功~
按下任意键结束程序...
"@
