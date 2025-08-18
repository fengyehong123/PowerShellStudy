[hashtable]$paramTable = @{
    Id = 110120
    Name = "小明"
    Age  = 20
}

#  ✅ 方法 1：foreach 遍历键值对 → 最接近 Java entrySet()
foreach ($entry in $paramTable.GetEnumerator()) {
    Write-Host "Key = $($entry.Key), Value = $($entry.Value)"
}
Write-Host '------------------------------------------------------------' -ForegroundColor Red

# ✅ 方法 2：遍历键 → 相当于 map.keySet()
foreach ($key in $paramTable.Keys) {
    Write-Host "Key = $key, Value = $($paramTable[$key])"
}
Write-Host '------------------------------------------------------------' -ForegroundColor Red

# ✅ 方法 3：遍历值 → 相当于 map.values()
foreach ($value in $paramTable.Values) {
    Write-Host "Value = $value"
}
Write-Host '------------------------------------------------------------' -ForegroundColor Red

# ✅ 方法 4：管道式遍历 → 更 PowerShell 风格
$paramTable.GetEnumerator() | ForEach-Object {
    "Key = $($_.Key), Value = $($_.Value)"
}

