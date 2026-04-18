# 需要安装依赖的模块
# Install-Module -Name PSSQLite -Scope CurrentUser
Import-Module PSSQLite

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

# 要查询的SQL
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

# 查询浏览数据
$csvData = Invoke-SqliteQuery -DataSource $browerHistoryDBTmp -Query "$historyQuerySql"

# 拼接桌面文件夹的路径
$outFile = Join-Path "$([Environment]::GetFolderPath("Desktop"))" "BrowserHistory.csv"

# 导出csv数据到桌面文件夹, 文本格式为 utf8BOM 可以保证使用Excel打开该csv文件
$csvData | Export-Csv $outFile -NoTypeInformation -Encoding utf8 | Out-Null
Write-Host "浏览器历史记录已导出到: $outFile" -ForegroundColor Green

Pause