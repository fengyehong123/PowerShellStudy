# 文件名称
$file_name = 'person_data.csv'
# 路径
$outputFile = "$Home\Desktop\$file_name"

# CSV 文件的总行数
$rows = 50000
# CSV文件编码格式
$global:csvFileEncoding = $([System.Text.Encoding]::UTF8.BodyName)
<#
    是否一口气读取csv文件到内存写入
    内存大的电脑适合开启此Flag
#>
[bool]$global:isReadAllCsvToMemoryFlag = $true

# 并行线程数
$threadCount = 4
# 每个线程生成的记录数量
$chunkSize = [math]::Ceiling($rows / $threadCount)

# ====================================================================================================================

# 判断文件是否存在，存在的话就删除
if (Test-Path -Path $outputFile) {
    Remove-Item -Path $outputFile -Force
}

# 写入 CSV 表头
# "`"ID`",`"NAME`",`"AGE`",`"EMAIL`",`"CREATED_DATE`"" | Out-File -FilePath $outputFile -Encoding UTF8 -Append

# 定义生成临时CSV文件的脚本块
$scriptBlock = {
    
    param(
        [int]$startRow
        , [int]$endRow
        , [string]$tempFile
    )

    # 将编码类型的字符串转换为对应的 Encoding 对象
    [System.Text.Encoding]$encodObj = [System.Text.Encoding]::GetEncoding($global:csvFileEncoding)
    
    # 获取随机数对象
    $random = [System.Random]::new()
    # 获取当前日期
    $currentDate = Get-Date

    <# 
        ⏹使用 StreamWriter 进入CSV写入，提升性能
            参数1：文件路径
            参数2：模式
                $true 表示 如果文件已经存在，将数据追加到文件末尾。
                $false 表示 如果文件已经存在，将覆盖文件内容（即清空文件重新写入）。
            参数3：文件编码方式
    #>
    $writer = [System.IO.StreamWriter]::new($tempFile, $true, $encodObj)
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

# CSV文件合成
function Merge-CSV {
        
	param (
		[string]$outputFile
	)

    # 获取临时csv文件并排序
    $outputFileSorted = Get-ChildItem -Path "$outputFile.*.part" | Sort-Object Name

    # 是否将临时的csv数据一口气全读入内存写入
    if ($global:isReadAllCsvToMemoryFlag) {

        Write-Host "读取整个临时csv文件到内存合并写入..." -ForegroundColor Green

        [System.Text.Encoding]$encodObj = [System.Text.Encoding]::GetEncoding($global:csvFileEncoding)
        $outputFileSorted | ForEach-Object {
            # 一次性读取文件内容到内存中
            $content = Get-Content -Path $_.FullName -Raw
            # 一次性追加到目标文件
            [System.IO.File]::AppendAllText($outputFile, $content, $encodObj)
            # 删除临时的CSV文件
            Remove-Item -Path $_.FullName
        }
        return;
    }

    Write-Host "普通方式合并写入..."

    $fileCode = $global:csvFileEncoding.replace("-", "")
    $outputFileSorted | ForEach-Object {
        # 将临时CSV文件的内容添加到总CSV中
        Get-Content -Path $_.FullName | Add-Content -Path $outputFile -Encoding $fileCode
        # 删除临时的CSV文件
        Remove-Item -Path $_.FullName
    }
}
    
try {

	# 定义job数组
    $jobs = @()
	
	# 组装job
    1..$threadCount | ForEach-Object {
		
        $startRow = ($_ - 1) * $chunkSize + 1
        $endRow = [math]::Min($_ * $chunkSize, $rows)
		
		# 临时csv文件的路径
        $tempFile = "$outputFile.$_.part"

        <#
            通过 Start-Job 立即在执行ScriptBlock代码块中代码
            Job作业会独立于主线程，在后台运行
            Start-Job 的返回值是当前的 Job对象
            将若干个Job对象放到数组中，便于之后的代码管理Job的生命周期
        #>
        $jobs += Start-Job -ScriptBlock $scriptBlock -ArgumentList $startRow, $endRow, $tempFile
    }
	
	# 统计生成csv文件所消耗的时间
    $exec_time = Measure-Command {

        Write-Host "临时csv文件开始生成..."

        # 管理 Job 的生命周期
        $jobs | ForEach-Object {
            # 等待 Job 完成，暂停主线程，直到当前作业完成。
            Wait-Job -Job $_
            # 提取 Job 的输出结果。如果没有调用这个命令，作业输出将保留在作业对象中。
            Receive-Job -Job $_
            # 删除Job，释放资源
            Remove-Job -Job $_
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

Read-Host "按 Enter 键退出..."