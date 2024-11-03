# Excel文件路径
$excelPath = "$HOME\Desktop\test.xlsx"

# 判断文件是否存在
if (-not (Test-Path $excelPath)) {

    # 打印提示文字,并且指定文字的颜色为红色
    Write-Host "指定路径下的文件不存在!" -ForegroundColor Red

    # 判断脚本的执行环境是否为交互式控制台环境
    if ($host.Name -eq "ConsoleHost") {
        # 只有在控制台环境的时候,这行代码才能让终端窗口阻塞
        $host.UI.RawUI.ReadKey()
    }
    # 终止脚本的运行
    return
}

# 创建Excel对象
$excel = New-Object -ComObject Excel.Application
$book = $null

# 当脚本处理Excel时,不让其在屏幕上显示
$excel.Visible = $false
<# 
    将Excel应用程序对象的警告显示设置为 $false, 这样Excel将不会显示警告框。
    比如在关闭工作簿时是否保存的提示。
#>
$excel.DisplayAlerts = $false

try {
    # 创建工作表对象
    $book = $excel.WorkBooks.Open($excelPath)

    # 获取第1个sheet页对象
    $sheet = $book.Sheets(1)

    # 获取A1单元格,并向其中写入数据
    $range = $sheet.Range("A1")
    $range.Value = "测试内容"

    # 在控制台上打印写入A1单元格中的内容
    Write-Host $range.Value()

    # 保存工作簿
    $book.Save()

    # $result = Get-Process -Name "NonexistentProcess"

    # 引发异常的代码
    # $num = 1 / 0
} catch {
    Write-Host "程序发生异常,异常的原因是:$($_.Exception.Message)"
} finally {

    if ($null -ne $book) {
        # 关闭工作簿
        $book.Close($false)
    }
    # 关闭Excel对象
    $excel.Quit()

    <# 
        用来显式释放 Excel COM 对象的资源
        使用 Out-Null 可以将输出结果丢弃,避免将释放对象的消息输出到控制台。
    #>
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
}

# 判断脚本的执行环境是否为交互式控制台环境
if ($host.Name -eq "ConsoleHost") {
    $host.UI.RawUI.ReadKey()
}


