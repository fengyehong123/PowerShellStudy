# RunspacePool 是用来托管多个 Runspace 的资源池，可以避免频繁创建和销毁线程，提高性能。
$runspacePool = [RunspaceFactory]::CreateRunspacePool(1, [Environment]::ProcessorCount)
$runspacePool.Open()

# 准备异步执行的脚本块
$scriptBlock = {
    # 外部传入的参数
    param($taskId)

    # 获取随机1到3的随机数字
    $RandomCount = Get-Random -Minimum 1 -Maximum 3
    # 模拟脚本块中的耗时任务
    Start-Sleep -Seconds $RandomCount

    # 模拟异步的耗时任务所得到的结果
    return [PSCustomObject]@{
        taskId = $taskId
        costTime = $RandomCount
    }
}

# 任务的数量
$taskIdArray = 1..5
# 用来存放异步任务对象的集合
$runspaces = @()

foreach ($taskId in $taskIdArray) {

    # 创建一个独立的 PowerShell 实例
    [System.Management.Automation.PowerShell]$ps = [powershell]::Create()
    # 将脚本块添加到 PowerShell 实例中，并传递参数
    $ps.AddScript($scriptBlock).AddArgument($taskId) | Out-Null
    # 将 PowerShell 实例加入线程池中
    $ps.RunspacePool = $runspacePool

    # 将任务对象放到 runspaces 中
    $runspaces += [PSCustomObject]@{
        # 自定义的数据
        CustomData = $taskId
        # 当前 PowerShell 实例对象
        Pipe = $ps
        # 异步执行当前Powershell实例的状态
        Status = $ps.BeginInvoke()
    }
}

$results = @()
$runspaces | ForEach-Object {

    # 提前保存任务ID或数据
    $taskId = $_.CustomData
    Write-Host "-------->${taskId}<--------"

    # $_ 是遍历中的每个任务对象，而 $_.Pipe 就是当初创建的 PowerShell 实例
    if ($_.Pipe.Streams.Error.Count -gt 0) {
        $_.Pipe.Streams.Error | ForEach-Object {
            Write-Warning "任务$($taskId)出错: $($_.Exception.Message)"
        }
    }

    # 异步任务执行结束，并获取返回值
    $result = $_.Pipe.EndInvoke($_.Status)
    $results += $result

    # 释放当前 PowerShell 实例的资源
    $_.Pipe.Dispose()
}

# 关闭与销毁线程池资源
$runspacePool.Close()
$runspacePool.Dispose()

$results | ForEach-Object { 
    Write-Host "当前异步任务的ID为$($_.taskId) , 异步任务的耗时时间为$($_.costTime)"
}
