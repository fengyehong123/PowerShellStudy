# 来源
# https://www.pstips.net/powershell-foreach-loop.html

<#
    支持 continue, break

#>
$arr = 1..10
foreach ($num in $arr) {

    if ($num -lt 5) {
        continue
    }

    if ($num -eq 10) {
        break
    }

    $num | Out-Host
}
<#
    5
    6
    7
    8
    9
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

$sum = 0
for ($i = 1; $i -lt 100; $i++) {
    $sum += $i
}

$sum | Out-Host