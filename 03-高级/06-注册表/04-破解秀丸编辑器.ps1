# https://members.tripod.com/for_beginers/hidemaru_install4.html

$userName = "X研究所"
New-ItemProperty -LiteralPath "Registry::\HKEY_CURRENT_USER\SOFTWARE\Hidemaruo\Hidemaru\Env" -Name "Name" -PropertyType "String" -Value "${userName}" -Force

# HIDEMARU=4000YEN
New-ItemProperty -LiteralPath "Registry::\HKEY_CURRENT_USER\SOFTWARE\Hidemaruo\Hidemaru\Env" -Name "Soukin" -PropertyType "DWord" -Value "0xfa0" -Force

# 获取注册表中的指定项目值
$money = (Get-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Hidemaruo\Hidemaru\Env").Soukin
Write-Host "$money"  # 4000