# 来源
# https://www.pstips.net/powershell-addressing-array-elements.html

$arr1 = "元素1", "元素2", "元素3", "元素4"
<# 
    ⏹通过下标访问
#>
Write-Host "第一个元素为：$($arr1[0])"
Write-Host "最后一个元素为：$($arr1[-1])"
Write-Host "最后一个元素为：$($arr1[($arr1.Count - 1)])"
Write-Host '---------------------------------------------'

# ⏹同时获取多个元素
$result = $arr1[0, 2, 3]
Write-Host ($result -join "`n")
<#
    元素1
    元素3
    元素4
#>
Write-Host '---------------------------------------------'

# ⏹数组逆向输出
Write-Host ($arr1[($arr1.Count)..0])  # 元素4 元素3 元素2 元素1