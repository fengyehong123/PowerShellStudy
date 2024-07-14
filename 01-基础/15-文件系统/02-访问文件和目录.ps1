<#
    ⏹过滤出当前用户桌面上的所有txt文件的全路径
#> 
Get-ChildItem -Path "$HOME\Desktop" -File -Recurse '*.txt' `
| Select-Object -Property 'FullName' | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹-Include
        支持简单模式的匹配
        注意：支持的是简单模式,而不是正则表达式
#>
Get-ChildItem -Path "$HOME\Desktop" -File -Recurse -Include '[a-f]*.txt' `
| Select-Object -Property 'FullName' | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# -Include 还支持数组
Get-ChildItem -Path "$HOME\Desktop" -File -Recurse -Include *.md,*.ttl `
| Select-Object -Property 'FullName' | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹-Exclude的作用和-Include相反,用来排除
        用法和-Include相同
#>
Get-ChildItem -Path "$HOME\Desktop" -File -Recurse -Exclude '[a-d]*.txt' `
| Select-Object -First 5 -Property 'FullName' | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹先过滤出所有的pdf文件
    然后再进一步过滤
        先使用正则表达式 匹配出 以空格或者D开头的文件名
        并且该该文件的大小 > 7MB
#>
Get-ChildItem -Path "$HOME\Desktop" -File -Recurse -Include *.pdf `
| Where-Object {
    $_.Name -match '^\s*D.*' -and $_.Length -gt 7MB
} | Select-Object -Property FullName | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<#
    ⏹获取2周以内创建过的文件
    或者
    自2023/05/12之后创建过的文件
#>
Get-ChildItem -Path "$HOME\Desktop" -File -Recurse *.txt `
| Where-Object {
    $_.CreationTime -gt (Get-Date).AddDays(-14) `
    -or `
    $_.CreationTime -gt [datetime]::Parse("May 12, 2023")
} | Select-Object -Property FullName | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red


