# 参考资料
# https://www.texcell.co.jp/PowerShell/dataBase/psSqlite.html

# 加载.dll库
Add-Type -Path "${PSScriptRoot}\sqlite3Win.dll"

# 选择浏览器
# $browser = "Edge"
# $browser = "Chrome"
$browser = "Baifen"

# 获取浏览器的数据库路径
if ($browser -eq "Chrome") {
    $browerHistoryDB = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\History"
}
elseif ($browser -eq "Edge") {
    $browerHistoryDB = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\History"
}
elseif ($browser -eq "Baifen") {
    $browerHistoryDB = "C:\soft\minigoogle\User Data\Default\History"
}
else {
    Write-Host "不支持的浏览器"
    Pause
    exit
}

# 判断浏览器的数据库路径是否存在
if (!(Test-Path $browerHistoryDB)) {
    Write-Host "找不到浏览器历史数据库：$browerHistoryDB"
    Pause
    exit
}

# 避免被浏览器锁定, 复制数据库
$browerHistoryDBTmp = "$env:TEMP\History_copy.db"
Copy-Item $browerHistoryDB $browerHistoryDBTmp -Force

# 创建对象
$sqlite3d = New-Object sqlite3Win.Sqlite3

# 打开数据库
$ir = $sqlite3d.open($browerHistoryDBTmp)
if ($ir -ne 0){
    Write-Host "浏览器历史数据库打开失败..."
    Pause
    exit
}

# 查询浏览器的历史记录
$historyQuerySql = @"
SELECT 
    url,
    title,
    visit_count,
    last_visit_time
FROM 
    urls
ORDER BY 
    last_visit_time DESC
"@

# SQL执行函数
function execSQL {

    param (
        [string]$sql
    )

    $ir = $sqlite3d.exec($sql)
    if ($ir -ne 0){
        $sms = $sqlite3d.errmes() + "`r`n[" + $sql + "]"
        Write-Host $sms
    }
    return $ir
}

# 进行sql查询
execSQL -sql $historyQuerySql | Out-Null

# 获取查询到的总条数
$historyCount = $sqlite3d.recordCount

# 存放csv数据
$csvData = @()

# 遍历格式化每条数据
for($i = 0; $i -lt $historyCount; $i++){

    $url   = $sqlite3d.columnData($i, 0)
    $title = $sqlite3d.columnData($i, 1)
    $visit = $sqlite3d.columnData($i, 2)
    # Chrome/Edge 时间转换
    $timeRaw = [long]$sqlite3d.columnData($i, 3)
    $visitTime = [DateTime]::FromFileTimeUtc($timeRaw * 10)

    # 构造csv数据对象
    $obj = [PSCustomObject]@{
        VisitTime  = $visitTime
        Title      = $title
        URL        = $url
        VisitCount = $visit
    }

    $csvData += $obj
}

# 拼接桌面文件夹的路径
$outFile = Join-Path "$([Environment]::GetFolderPath("Desktop"))" "BrowserHistory.csv"

# 导出csv数据到桌面文件夹
$csvData | Export-Csv $outFile -NoTypeInformation -Encoding utf8 | Out-Null
Write-Host "浏览器历史记录已导出到: $outFile" -ForegroundColor Green

# 关闭数据库
$sqlite3d.close() | Out-Null

Pause