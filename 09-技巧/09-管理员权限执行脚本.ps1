<#
    校验当前用户是否有管理员权限
#>
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
    try {
        
        # Windows管理凭证,用户输入管理员的账号密码
        # $AdminUserCredential = Get-Credential

        <#
            Start-Process
                用于启动一个进程（程序或脚本）
            -ArgumentList
                允许你传递一组参数到被启动的进程
            -NoProfile
                不加载用户的 PowerShell 配置文件（profile.ps1）
                可以确保以一个干净的环境运行，避免加载个性化配置
            -ExecutionPolicy RemoteSigned
                允许本地脚本运行，但远程脚本需要数字签名。
            $PSCommandPath
                特殊变量，用于表示当前脚本所在的绝对路径
            -Verb RunAs
                -Verb 参数指定启动进程时的动作或方式。
                RunAs 是一个特殊的动词，表示以管理员权限运行程序。
        #>
        Start-Process -FilePath "powershell.exe" `
                      -ArgumentList "-NoProfile -ExecutionPolicy RemoteSigned -File $($PSCommandPath)" `
                      -Verb RunAs
                      # -Credential $AdminUserCredential
    } catch {
        Write-Host "脚本运行时发生异常:"
        Write-Host "$_" -ForegroundColor Red
        Write-Host "堆栈跟踪: $($_.Exception.StackTrace)" -ForegroundColor Gray
        Read-Host "按 Enter 键退出..."
    }
    exit
}

Write-Host "已成功以管理员权限运行 PowerShell ..." -ForegroundColor Green

Read-Host "按 Enter 键退出..."