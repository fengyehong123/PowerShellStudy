# 使用 RunspaceFactory 创建一个 Runspace 池
$runspacePool = [RunspaceFactory]::CreateRunspacePool(1, [Environment]::ProcessorCount)
$runspacePool.Open()

# 创建存储 Runspace 的集合
$runspaces = @()
# 要向 Runspace集合中存放的脚本块
$scriptblock = {
    param($data)
    Start-Sleep -Seconds (Get-Random -Minimum 1 -Maximum 3)
    "任务 $data 完成"
}

# 模拟处理5个任务
$dataArray = 1..5
foreach ($data in $dataArray) {

    <#
        [powershell]::Create() 创建的是一个 新的 PowerShell 实例对象，
        它允许你以编程方式构建、配置和运行 PowerShell 脚本或命令，
        特别适合用于并发（Runspaces）、异步执行等高级场景。
    #>
    $ps = [powershell]::Create()

    # 将任务脚本块添加到 当前的 PowerShell 实例对象中
    $ps.AddScript($scriptblock).AddArgument($data) | Out-Null

    # 为当前的 PowerShell 实例对象, 设置 Runspace 池
    $ps.RunspacePool = $runspacePool

    # 开始异步执行
    $runspaces += [PSCustomObject]@{
        Pipe = $ps
        Status = $ps.BeginInvoke()
    }
}

# 存放所有执行结果的集合
$results = @()

# 等待所有 runspace 完成并打印结果
$runspaces | ForEach-Object {

    # 等待当前的 Runspace 执行完毕
    $_.Pipe.EndInvoke($_.Status)

    # 检查输出流的数量，如果 > 0 的话
    if ($_.Pipe.Output.Count -gt 0) {
        # 获取执行结果
        $results += $_.Pipe.Output.ReadAll()
    }

    # 释放资源
    $_.Pipe.Dispose()
}

# 关闭 Runspace 池
$runspacePool.Close()
$runspacePool.Dispose()

# 输出结果
$results | ForEach-Object {
    Write-Host "$_"
}