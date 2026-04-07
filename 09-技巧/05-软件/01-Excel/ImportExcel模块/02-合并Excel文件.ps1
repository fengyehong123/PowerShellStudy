# 定义存储 Excel 文件的路径
$excelFolderPath = "$HOME\Desktop\Excel文件"
$outputFilePath = "$HOME\Desktop\MergedOutput.xlsx"

# 获取文件夹中的所有 Excel 文件
$excelFiles = Get-ChildItem -Path $excelFolderPath -Filter *.xlsx

# 初始化一个空的数组，用于存储所有数据
$mergedData = @()

# 遍历每个 Excel 文件
foreach ($file in $excelFiles) {

    Write-Host "正在处理文件: $($file.FullName)"
    
    # 获取文件中的所有表格名称
    $sheetNames = Get-ExcelSheetInfo -Path $file.FullName | Select-Object -ExpandProperty Name

    # 遍历每个表格
    foreach ($sheetName in $sheetNames) {

        Write-Host "正在读取表格: $sheetName"
        
        # 读取表格中的数据
        $sheetData = Import-Excel -Path $file.FullName -WorksheetName $sheetName
        
        # 给数据添加来源信息（文件名和表格名）
        $sheetData | ForEach-Object {
            $_ | Add-Member -MemberType NoteProperty -Name SourceFile -Value $file.Name
            $_ | Add-Member -MemberType NoteProperty -Name SourceSheet -Value $sheetName
        }

        # 合并数据到总数据数组
        $mergedData += $sheetData
    }
}

# 确定是否有合并后的数据
if ($mergedData.Count -eq 0) {
    Write-Host "未找到任何数据可供合并"
    Read-Host "按 Enter 键退出..."
    exit
}

# 将合并的数据导出到新的 Excel 文件
$mergedData | Export-Excel -Path $outputFilePath `
                           -AutoSize -Title "Merged Data" `
                           -WorksheetName "MergedSheet"

Write-Host "数据已成功合并到: $outputFilePath"
Read-Host "按 Enter 键退出..."


