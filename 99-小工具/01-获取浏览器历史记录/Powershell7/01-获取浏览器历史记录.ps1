# 添加依赖库
Add-Type -Path "${PSScriptRoot}\SQLitePCLRaw.core.dll"
Add-Type -Path "${PSScriptRoot}\SQLitePCLRaw.batteries_v2.dll"
Add-Type -Path "${PSScriptRoot}\SQLitePCLRaw.provider.e_sqlite3.dll"
Add-Type -Path "${PSScriptRoot}\Microsoft.Data.Sqlite.dll"

# 初期化
[SQLitePCL.Batteries_V2]::Init()

# Chrome 数据库路径
$db = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\History"

# 临时文件（避免锁）
$tmp = "$env:TEMP\chrome_history.db"
Copy-Item $db $tmp -Force

# 打开数据库
$conn = [Microsoft.Data.Sqlite.SqliteConnection]::new("Data Source=$tmp")
$conn.Open()

# 执行数据库查询
$cmd = $conn.CreateCommand()
$cmd.CommandText = "SELECT url, title, last_visit_time FROM urls"
$reader = $cmd.ExecuteReader()

# 时间转换函数
function Convert-ChromeTime($time) {
    $epoch = Get-Date "1601-01-01"
    return $epoch.AddMilliseconds($time / 1000)
}

# 输出结果
while ($reader.Read()) {
    $time  = Convert-ChromeTime $reader["last_visit_time"]
    $title = $reader["title"]
    $url   = $reader["url"]

    Write-Host "[$time] $title"
    Write-Host $url
    Write-Host "----------------------"
}

# 关闭连接
$conn.Close()

Pause