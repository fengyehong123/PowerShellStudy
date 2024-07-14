<#
    ⏹递归获取指定指定路径下的pdf文件
    并且按照名称降序排序
    展示
        全路径,大小,最后修改时间
    转换为html文件之后,输出为 ls.html文件

#>
Get-ChildItem -Path 'E:\编程电子书\JS' -Recurse -File -Filter *.pdf `
| Sort-Object -Descending Name `
| Select-Object FullName, Length, LastWriteTime `
| ConvertTo-Html `
| Out-File ls.html