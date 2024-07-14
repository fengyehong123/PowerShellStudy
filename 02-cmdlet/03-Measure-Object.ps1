<#
    ⏹Measure-Object用于计算和统计对象的某些属性或值。
    它可以用于统计文件大小、字符串长度、计算对象的数量、平均值、总和、最小值和最大值等。
#>

# 获取指定文件绝对路径
$target_path = "$($Home)\Desktop\Java笔记\01-Java总结"
$file_list = Get-ChildItem -Path $target_path -Recurse -File

# 获取出文件夹下面的所有文件的全路径
$file_list | Select-Object -ExpandProperty FullName | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹获取数量
#> 
$file_list | Measure-Object | Select-Object -Property Count | Out-Host  # 19
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹统计多个字符串长度的 总计,平均值,最小值,最大值
#> 
"PowerShell", "is", "awesome" | Measure-Object `
-Property Length `
-Sum -Average -Minimum -Maximum
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹获取所有文件的总大小
#> 
$file_list | Measure-Object -Property Length -Sum | Out-Host
<#
    Count    : 19
    Average  :
    Sum      : 31259448
    Maximum  :
    Minimum  :
    Property : Length
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red
# 将结果转换为MB
$size_byte = $file_list | Measure-Object -Property Length -Sum | Select-Object -ExpandProperty Sum
Write-Host "总大小为: $($size_byte / 1MB)MB"  # 总大小为: 29.8113327026367MB

<#
    ⏹获取文本的行数,单词数
    文本一共有4行
    由于是按照英文来统计单词数(根据空格来统计)
        所以 Words 的值是 6
    -Line
        用来统计行数
#> 
@"
你好
世 界
powershell
我正在学习这个,单词呢 哈哈
"@ | Measure-Object -Line -Word `
| Select-Object -Property Lines, Words `
| Out-Host
<#
    Lines Words
    ----- -----
        4     6
#>


