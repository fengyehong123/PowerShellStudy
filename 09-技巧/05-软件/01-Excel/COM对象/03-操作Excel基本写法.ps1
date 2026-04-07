param (
    [parameter(mandatory=$true)] $fileName
    , $visible = $false
)

# 根据文件名获取绝对路径
$fullPath = (Get-ChildItem -Path $fileName).FullName
Write-Host $fullPath

# powershell中的 or 的用法
if ($host.Name -eq "ConsoleHost" -or $host.Name -eq "Visual Studio Code Host") {
    # 打印脚本执行的绝对路径,使用红色字体打印
    Write-Host $PSScriptRoot -ForegroundColor Red
}

# 创建Excel对象
$excel = New-Object -ComObject Excel.Application
$book = $null

$excel.Visible = $visible
$excel.DisplayAlerts = $false

try {
    # 打开工作簿对象
    $book = $excel.Workbooks.Open($fullPath)

    # 根据sheet页的位置获取sheet对象
    $currentSheet = $book.Sheets(1)
    <# 
        1. $()语法用于在字符串中插入变量的值
        2. 在powershell中 "" 和 '' 作用不同
            '' 用于单纯的包裹字符串
            "" 和JS中的``作用相同
        3. 打印当前sheet页的名称
    #>
    Write-Host "sheet页的名称为:$($currentSheet.Name)"

    # 修改当前sheet页的名称(修改元的sheet页要存在,否则会报错)
    $book.Sheets("测试sheet").Name = "修改_测试Sheet"
    # 打印修改之后的sheet页的名称
    Write-Host "修改之后的Sheet页名称为:$($book.Sheets(1).Name)"

    # 获取sheet页的总数量
    Write-Host $book.Sheets.Count

    # 创建一个sheet页
    $newSheet = $book.WorkSheets.Add()
    $newSheet.Name = "新创建的sheet页"
}
catch {
    Write-Host "程序发生异常,异常的原因是:$($_.Exception.Message)"
}
finally {
    # 判断一个对象是否为null,ps推荐的写法
    if ($null -ne $book) {
        <#
            保存
                .Save()
            另存为
                .SaveAs($savePath)
        #>
        $book.Save()
        # 关闭工作簿
        $book.Close($false)
    }
    $excel.Quit()
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
}

# 创建一个数组,内含交互式环境的名称
$validHosts = @("ConsoleHost", "Visual Studio Code Host")
# if 配合数组用来简化分支
if ($validHosts -contains $host.Name) {
    $host.UI.RawUI.ReadKey()
}