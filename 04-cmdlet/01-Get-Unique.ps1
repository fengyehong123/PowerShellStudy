<#
    ⏹Get-Unique可以从已排序的对象列表中删除重复对象。
    Get-Unique会逐个遍历对象，每次遍历时都会与前一个对象进行比较，
    如果和前一个对象相等就会抛弃当前对象，否则就保留。
    如果对象列表中没有排序，Get-Unique不能完全发挥作用，只能保证相邻对象不重复。
    ⭕因此多需要配合 Sort-Object 来使用
#>

$arr1 = @(1, 2, 1, 2, 2)
# ⏹因为并没有排序,所以只有相邻的2被去重
$arr1 | Get-Unique | Out-Host
<#
    1
    2
    1
    2
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red
# ⏹先排序之后再去重
$arr1 | Sort-Object | Get-Unique | Out-Host
<#
    1
    2
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 获取指定文件绝对路径
$target_path = "$($Home)\Desktop\Java笔记\01-Java总结"
$file_list = Get-ChildItem -Path $target_path -Recurse -File

<#
    ⏹获取出所有文件对象的所有后缀
    根据后缀进行排序时指定-Unique参数用来去重
#>
$file_list | Select-Object -Property Extension `
| Sort-Object -Property Extension -Unique | Out-Host
<#
    Extension
    ---------
    .md
    .pdf
    .txt
    .xmind
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹获取出所有文件对象的所有后缀并使用-Unique参数来去重
    根据后缀进行排序
#>
$file_list | Select-Object -Property Extension -Unique `
| Sort-Object Extension | Out-Host
<#
    Extension
    ---------
    .md
    .pdf
    .txt
    .xmind
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹先通过 ForEach-Object 来获取所有文件对象的后缀
    然后在排序并去重
#>
$file_list | ForEach-Object {$_.extension} | Sort-Object `
| Get-Unique | Out-Host
<#
    .md
    .pdf
    .txt
    .xmind
#>

