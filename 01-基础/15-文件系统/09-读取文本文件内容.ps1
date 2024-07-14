# 日志路径
$Log_Path = "D:\log\CBC_SystemLog.log"

# 读取文件的内容,然后跳过前9行,从第10行开始读,读取6行
# 相当于读取 10 ~ 15 行的内容
Get-Content -Path $Log_Path | Select-Object -Skip 9 -First 6 | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 获取所有内容后,查询包含 evaluator 内容的行, \b \b 表示单词边界
Get-Content -Path $Log_Path | Select-String "\bevaluator\b" | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

$csvdata = @"
"ID","姓名"
"1","张三"
"2","李四"
"3","王五"
"4","赵六"
"5","王七"
"6","刘八"
"7","丰九"
"@
$csvdata | ConvertFrom-Csv -Delimiter "," | ForEach-Object { $_.姓名 } | Out-Host
<#
    张三
    李四
    王五
    赵六
    王七
    刘八
    丰九
#>