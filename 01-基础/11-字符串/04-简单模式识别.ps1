# 来源
# https://www.pstips.net/simple-pattern-recognition.html

# 简单的模式识别
<#
    *
        任意个任意字符(包含零个字符)
    ?
        一个任意字符
    [xyx]
        一个包含在指定枚举集合中的字符
    [x-z]
        一个包含在指定区间集合中的字符
#>

$path = 'G:\WebStudy'

# ⏹使用简单模式进行匹配的时候,最好加上 -Include 配置项
Get-ChildItem -Path $path -Recurse -File -Include *.txt | Select-Object -First 5 | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

Get-ChildItem -Path $path -Recurse -File -Include *.?d | Select-Object -First 5 | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

Get-ChildItem -Path $path -Recurse -File -Include [atj]*.js | Select-Object -First 5 | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

Get-ChildItem -Path $path -Recurse -File -Include [a-f]*.js | Select-Object -First 5 | Out-Host