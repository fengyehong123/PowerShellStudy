param(
  [string]$originalScriptFolderPath
)

# 检测是否为管理员权限
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
Write-Host "已成功以管理员权限运行 PowerShell ..." -ForegroundColor Green
# =============================================================================================

# 定时任务名称
$taskName = "MyMonitor"

# 检查定时任务是否存在
if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
  # 停止定时任务
  Stop-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
  Write-Host "Step1: 停止既存的定时任务"
  # 删除定时任务
  Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
  Write-Host "Step2: 删除既存的定时任务"
}

# 程序路径
$taskProgram = "E:\test\xxx\MyMonitorService.exe"
$taskProgramDescription = "监控杀死指定进程"

# 新建一个定时任务Action
$action = New-ScheduledTaskAction -Execute "$taskProgram"

# 新建一个定时任务触发器, 定时任务会在用户登录的时候触发
$trigger = New-ScheduledTaskTrigger -AtLogOn -User "$env:USERNAME"

<#
  定时任务的相关设置
    只允许有一个实例
    当程序崩溃时的重试次数
    重试的间隔
#>
$settings = New-ScheduledTaskSettingsSet `
  -MultipleInstances IgnoreNew `
  -RestartCount 999 `
  -RestartInterval (New-TimeSpan -Minutes 1)

# 注册定时任务
Register-ScheduledTask `
  -TaskName "$taskName" `
  -Action $action `
  -Trigger $trigger `
  -RunLevel Highest `
  -Description "$taskProgramDescription" `
  -Settings $settings | Out-Null
Write-Host "Step: 新建定时任务成功"

# 查看任务计划程序
# taskschd.msc

Pause