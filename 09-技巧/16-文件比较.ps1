# 作业文件夹
$work_folder_path = "$($HOME)/Desktop/Compare_Folder/"

# 等待比较的两个文件
$CCKPS01_A = "0327_CCKPS01.dat"
$CCKPS01_B = "0411_CCKPS01.dat"

# 文件编码和输出的文件名
$file_code = "shift_jis"
$outputFile = "compare_result.txt"

# -----------------------------------------------------------
# ✨比较对象的文件夹名称，之后要读取内容写入HashSet供比较
$Compare_Base_FileName = $CCKPS01_B
# -----------------------------------------------------------

# 脚本执行之前先删除本地的输出文件
$outputPath = Join-Path -Path $work_folder_path -ChildPath $outputFile
if (Test-Path $outputPath) {
    Remove-Item $outputPath
}

# 获取文件的件数和内容
$Base_File_Content = Get-Content $(Join-Path -Path $work_folder_path -ChildPath $Compare_Base_FileName)
$Base_File_Line_Count = $Base_File_Content.Count
$HandleLineCount = 0

# 创建HashSet对象
$Compare_HashSet = [System.Collections.Generic.HashSet[string]]::new()
# 将读取到的文件内容添加到HashSet对象中，供之后比较用
$Base_File_Content | ForEach-Object {

    # 使用 Out-Null 是为了避免控制台上的额外输出
    $Compare_HashSet.Add($_) | Out-Null
    $HandleLineCount++

    # 进度条计算
    $percentComplete = ($HandleLineCount / $Base_File_Line_Count) * 100
    Write-Progress -Activity "正在做成比较用的HashSet" -Status "总行数: $($Base_File_Line_Count);$($HandleLineCount)行已经添加完毕。" -PercentComplete $percentComplete
}
# 进度条完成
Write-Progress -Activity "比较用HashSet做成完毕" -PercentComplete 100

# 创建 StreamWriter 对象
$writer = [System.IO.StreamWriter]::new($outputPath, [System.Text.Encoding]::GetEncoding($file_code))
try {

    # 获取文件的件数和内容
    $lines = Get-Content $(Join-Path -Path $work_folder_path -ChildPath $CCKPS01_A)
    $totalLines = $lines.Count
    $processLines = 0

    foreach ($line in $lines) {

        # 如果当前行并不在HashSet对象中，就将其写入输出文件中
        if (-not $Compare_HashSet.Contains($line)) {
            $writer.WriteLine($line) | Out-Null
        }

        # 计算进度条
        $processLines++
        $percentComplete = ($processLines / $totalLines) * 100
        Write-Progress -Activity "文件正在比较中" -Status "总行数: $($totalLines);$($processLines)行已经比较完毕。" -PercentComplete $percentComplete
    }
    Write-Progress -Activity "文件比较完毕" -PercentComplete 100
} catch {
    Write-Host "程序发生异常,异常的原因是:$($_.Exception.Message)"
} finally {
    # 关闭 StreamWriter 对象, 保存文件
    $writer.Close()
}

# ----------------------------------------------------------------------------------------------------------
# 判断输出的文件
if ((Get-Content $outputPath).Length -gt 0) {
    Write-Host "$($CCKPS01_A)文件中的部分内容在$($Compare_Base_FileName)文件中不存在..." -ForegroundColor Red
    Write-Host "详情请查看$($outputPath)文件。" -ForegroundColor Red
} else {
    Write-Host "$($CCKPS01_A)文件中的内容在$($Compare_Base_FileName)文件中存在..."
    Remove-Item $outputPath
}