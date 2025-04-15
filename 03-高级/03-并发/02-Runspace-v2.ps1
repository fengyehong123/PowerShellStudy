$runspacePool = [RunspaceFactory]::CreateRunspacePool(1, [Environment]::ProcessorCount)
$runspacePool.Open()

$scriptblock = {
    param($data)
    Start-Sleep -Seconds (Get-Random -Minimum 1 -Maximum 3)
    "任务 $data 完成"
}

$dataArray = 1..5
$runspaces = @()

foreach ($data in $dataArray) {

    $ps = [powershell]::Create()
    $ps.AddScript($scriptblock).AddArgument($data) | Out-Null
    $ps.RunspacePool = $runspacePool

    $runspaces += [PSCustomObject]@{
        Data = $data
        Pipe = $ps
        Status = $ps.BeginInvoke()
    }
}

$results = @()
$runspaces | ForEach-Object {

    # 提前保存任务ID或数据
    $taskData = $_.Data
    Write-Host "$taskData"

    if ($_.Pipe.Streams.Error.Count -gt 0) {
        $_.Pipe.Streams.Error | ForEach-Object {
            Write-Warning "任务 $taskData 出错: $($_.Exception.Message)"
        }
    }

    $result = $_.Pipe.EndInvoke($_.Status)
    $results += $result

    $_.Pipe.Dispose()
}

$runspacePool.Close()
$runspacePool.Dispose()

$results | ForEach-Object { Write-Host $_ }
