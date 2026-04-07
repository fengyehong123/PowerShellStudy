$csvdata = @"
"1","https://www.pstips.net/diff-with-currentculture-and-currentuiculture.html"
"2","https://www.pstips.net/tag/powershell-v3"
"3","https://www.pstips.net/powershell-download-files.html"
"4","http://www.notelee.com/cs0012-the-type-system-object-is-defined-in-an-assembly-that-is-not-referenced.html"
"5","http://www.notelee.com/scom-create-wmi-perf-rule.html"
"6","http://www.lonsoon.com/2013/04/94.html"
"7","http://www.lonsoon.com/2013/05/101.html"
"@

<#
    先将字符串csv转换为csv对象之后,添加标题,便于获取指定列的数据
    然后将URL列的数据获取出来转换为 uri 类型的数据
    然后获取出所有的 Host 之后,进一步去重
#>
$csvdata | ConvertFrom-Csv -Header @("ID", "URL") | ForEach-Object {
   ([uri]$_.URL).Host
} | Get-Unique | Out-Host