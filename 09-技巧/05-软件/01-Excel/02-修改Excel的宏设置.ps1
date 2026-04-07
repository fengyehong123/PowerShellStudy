<#
    现在主流Excel的version
        2016
        2019
        2021
        Microsoft 365
    全部都是 16.0
#>
# 动态获取Excel的version
$excel = New-Object -ComObject Excel.Application
$version = $excel.Version
$excel.Quit()

# Excel的安全设置注册表位置
$path = "HKCU:\Software\Microsoft\Office\$version\Excel\Security"
if (!(Test-Path $path)) {
    New-Item -Path $path -Force | Out-Null
}

<#
    宏策略
        1 启用所有宏【不安全】
        2 禁用宏, 并提示
        3 禁用所有宏【默认】
        4 仅允许数字签名宏
#>
# 将宏策略设置为 → 禁用宏, 并提示
Set-ItemProperty -Path $path -Name "VBAWarnings" -Value 2
# 允许VBA项目访问
Set-ItemProperty -Path $path -Name "AccessVBOM" -Value 1

Write-Host "Excel宏策略已设置完成, 重启Excel即可生效..."
Pause