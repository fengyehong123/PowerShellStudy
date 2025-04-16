# 文件名称
$file_name = 'person_data.csv'
# 路径
$outputFile = "$Home\Desktop\$file_name"

# CSV 文件的总行数
$rows = 50000
# 并行线程数
$threadCount = 4
# 每个线程生成的记录数量
$chunkSize = [math]::Ceiling($rows / $threadCount)

# RunspacePool 是用来托管多个 Runspace 的资源池，可以避免频繁创建和销毁线程，提高性能。
$runspacePool = [RunspaceFactory]::CreateRunspacePool(1, 4)
$runspacePool.Open()

# 准备异步执行的脚本块
$scriptBlock = {

    param(
        [int]$startRow
        , [int]$endRow
        , [string]$tempFile
    )

    function New-CSVChunk {
        param(
            [int]$startRow,
            [int]$endRow,
            [string]$tempFile
        )

        # 获取随机数对象
        $random = [System.Random]::new()
        # 获取当前日期
        $currentDate = Get-Date

        <# 
            ⏹使用 StreamWriter 进入CSV写入，提升性能
                参数1：文件路径
                参数2：模式 $true 表示追加，$false 表示覆盖
                参数3：文件编码方式
        #>
        $writer = [System.IO.StreamWriter]::new($tempFile, $true, [System.Text.Encoding]::UTF8)
        try {
            for ($i = $startRow; $i -le $endRow; $i++) {

                # =========================对应数据库的各字段值=========================
                $id = $i
                $name = "Name_$i"
                $age = $random.Next(18, 60)
                $email = "user$i@example.com"
                $createdDate = $currentDate.AddDays(- $random.Next(0, 365)).ToString("yyyy/MM/dd HH:mm:ss")
                # =========================对应数据库的各字段值=========================

                # =========================一行csv=========================
                $line = "`"$id`",`"$name`",`"$age`",`"$email`",`"$createdDate`""
                # =========================一行csv=========================

                $writer.WriteLine($line)
            }
        } finally {
            $writer.Close()
        }
    }
    # 传参，调用函数
    New-CSVChunk -startRow $startRow -endRow $endRow -tempFile $tempFile
}

function Merge-CSV {
        
	param (
		[string]$outputFile
	)

    # 获取临时csv文件并排序
    $outputFileSorted = Get-ChildItem -Path "$outputFile.*.part" | Sort-Object Name

    Write-Host "读取整个临时csv文件到内存合并写入..." -ForegroundColor Green
    $outputFileSorted | ForEach-Object {
        # 一次性读取文件内容到内存中
        $content = Get-Content -Path $_.FullName -Raw
        # 一次性追加到目标文件
        [System.IO.File]::AppendAllText($outputFile, $content, [System.Text.Encoding]::UTF8)
        # 删除临时的CSV文件
        Remove-Item -Path $_.FullName
    }
}

try {
    # 用来存放异步任务对象的集合
    $runspaces = @()
    1..$threadCount | ForEach-Object {

        $startRow = ($_ - 1) * $chunkSize + 1
        $endRow = [math]::Min($_ * $chunkSize, $rows)
		
		# 临时csv文件的路径
        $tempFile = "$outputFile.$_.part"

        # 创建一个独立的 PowerShell 实例
        [System.Management.Automation.PowerShell]$ps = [powershell]::Create()
        # 将脚本块添加到 PowerShell 实例中，并传递参数
        $ps.AddScript($scriptBlock).AddArgument($startRow).AddArgument($endRow).AddArgument($tempFile) | Out-Null
        # 将 PowerShell 实例加入线程池中
        $ps.RunspacePool = $runspacePool

        # 将任务对象放到 runspaces 中
        $runspaces += [PSCustomObject]@{
            # 自定义的数据
            CustomData = $_
            # 当前 PowerShell 实例对象
            Pipe = $ps
            # 异步执行当前Powershell实例的状态
            Status = $ps.BeginInvoke()
        }
    }
	
	# 统计生成csv文件所消耗的时间
    $exec_time = Measure-Command {

        Write-Host "临时csv文件开始生成..."

        $runspaces | ForEach-Object {

            # 提前保存任务ID或数据
            $taskId = $_.CustomData
            Write-Host "-------->${taskId}<--------"

            # $_ 是遍历中的每个任务对象，而 $_ .Pipe 就是当初创建的 PowerShell 实例
            if ($_.Pipe.Streams.Error.Count -gt 0) {
                $_.Pipe.Streams.Error | ForEach-Object {
                    Write-Warning "任务$($taskId)出错: $($_.Exception.Message)"
                }
            }

            # 等到异步任务执行结束
            $_.Pipe.EndInvoke($_.Status)

            # 释放当前 PowerShell 实例的资源
            $_.Pipe.Dispose()
        }

        # 合并所有并发生成的csv临时文件,组装成最终的总csv文件
        Write-Host "临时csv文件生成完毕,开启合并..."
        Merge-CSV -outputFile $outputFile
    }

    Write-Host "csv文件生成完毕,所在路径：$outputFile" -ForegroundColor Red
    Write-Host "共消耗：$($exec_time.TotalSeconds)秒" -ForegroundColor Red
} catch {

    # 当异常发生时,清空桌面上的临时csv文件
    if (Test-Path -Path "$outputFile.*.part") {
        Remove-Item -Path "$outputFile.*.part" -Force
    }

    Write-Host "脚本运行时发生异常: $_" -ForegroundColor Red
    Write-Host "详细信息: $($_.Exception.Message)" -ForegroundColor Yellow
    Write-Host "堆栈跟踪: $($_.Exception.StackTrace)" -ForegroundColor Gray
}

# 关闭与销毁线程池资源
$runspacePool.Close()
$runspacePool.Dispose()
