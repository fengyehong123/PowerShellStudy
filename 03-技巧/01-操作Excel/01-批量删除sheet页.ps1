# Excel文件路径
$BookPath = "C:\Users\贾铭威\Desktop\test.xlsx";

# 创建Excel和工作簿对象
$Excel = New-Object -com Excel.Application
$Book = $Excel.WorkBooks.Open($BookPath)

# 将匹配到的sheet1~9删除
$Book.WorkSheets | Where-Object { $_.Name -match "Sheet[0-9]*" } `
                 | ForEach-Object { $_.Delete() }
$Book.Save()

# 保存后退出
$Book.Close($False)
$Excel.Quit()