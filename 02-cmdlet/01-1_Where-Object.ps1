<#
    ⏹根据指定的条件筛选出符合条件的对象。
    语法:
        command | Where-Object { condition }
#>

# ⏹筛选出大于10的数字
Write-Host (1..20 | Where-Object { $_ -gt 10 })  # 11 12 13 14 15 16 17 18 19 20
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹筛选数组对象
$peopleList = @(
    <#
        @{} 用于创建对象
    #>
    @{
        name = '贾飞天';
        age = 18
    }
    @{
        name = '张三'
        age = 20
    }
    @{
        name = '李四'
        age = 25
    }
)
# 过滤出 Name 为贾飞天的对象
Write-Output ($peopleList | Where-Object { $_.Name -eq '贾飞天' })
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ? 是 Where-Object 的简写
    获取出 Name 为张三的对象的age
#>
Write-Output ($peopleList | ? {$_.Name -eq '张三'}).age
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹筛选出指定日期后的文件
        Get-ChildItem
            -Path: 指定要获取的路径
            -Recurse: 递归
            -File: 指定获取文件,而不是文件夹
#>
Write-Output (
    Get-ChildItem -Path "E:\01-プロジェクト" -Recurse -File `
    | Where-Object { $_.LastWriteTime -gt (Get-Date "2020-01-30") } `
    | Select-Object -ExpandProperty FullName
)
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹筛选出文件大小大于1MB的文件
    并将文件的绝对路径输出到桌面
#>
Get-ChildItem -Path "E:\01-プロジェクト" -Recurse `
| Where-Object { $_.Length -gt 1MB } `
| Select-Object -ExpandProperty FullName `
| Set-Content -Path "$Home\Desktop\LargeFiles.txt"



