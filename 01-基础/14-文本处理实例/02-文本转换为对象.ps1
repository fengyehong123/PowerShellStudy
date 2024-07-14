# 来源
# https://www.pstips.net/processing-text-3.html

$rawTxt = '"data1":111,"data2":22,"data3":3,"data4":4444444'

$temp_result = $rawTxt -split ',' | ForEach-Object {

    $temp = $_ -split ':'

    $key = $temp[0] -replace '"', ''
    $value = $temp[1] 

    "$($key)=$($value)"
}
$temp_result | Out-Host
<#
    data1=111
    data2=22
    data3=3
    data4=4444444
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

$temp_result | ConvertFrom-StringData | Out-Host
<#
    Name     Value
    ----     -----
    data1    111
    data2    22
    data3    3
    data4    4444444
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

($temp_result | ConvertFrom-StringData).GetType().FullName | Out-Host
# System.Object[]