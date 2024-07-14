# 来源
# https://www.pstips.net/processing-text-2.html

<#
    有一段文本如下
    要求统计成绩相同的学生
#>
$content = @"
李一 93
王二 83
王三 93
李四 60
王五 75
马六 61
孙七 75
刘八 75
"@


$content -split "`r`n" | ForEach-Object {
    # 按照空格去切分,然后封装为Map
    [PSCustomObject]@{
        Name = $_.Split(' ')[0]
        Value = $_.Split(' ')[1]
    }
} | Group-Object -Property 'Value' | Out-Host
<#
    Count Name   Group
    ----- ----   -----
        2 93     {@{Name=李一; Value=93}, @{Name=王三; Value=93}}
        1 83     {@{Name=王二; Value=83}}
        1 60     {@{Name=李四; Value=60}}
        3 75     {@{Name=王五; Value=75}, @{Name=孙七; Value=75}, @{Name=刘八; Value=75}}
        1 61     {@{Name=马六; Value=61}}
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 按照换行符进行切分
$content -split "`r`n" | ForEach-Object {
    # 按照空格去切分,然后封装为Map
    [PSCustomObject]@{
        Name = $_.Split(' ')[0]
        Value = $_.Split(' ')[1]
    }
} | Group-Object -Property 'Value' | Where-Object {
    # 根据Value属性来进行分组,并过滤出 Count > 1 的数据
    $_.Count -gt 1
} | ForEach-Object {
    # 获取每一组,并进行遍历
    $_.Group | ForEach-Object {
        "$($_.Name) $($_.Value)"
    }
}

