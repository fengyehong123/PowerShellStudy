# 将C#的代码导入到Powershell代码中
Add-Type -Path "$($PSScriptRoot)\20-Wallpaper.cs"

<#
    解释：
        20 → SPI_SETDESKWALLPAPER
        0x01 → 更新用户配置
        0x02 → 通知系统立即生效
#>
$path = "壁纸所在的路径"
if (-not (Test-Path $path)) {
    Write-Host "路径不存在..." -ForegroundColor Red
    Pause
    exit 1;
}

# 判断壁纸是否存在
[Wallpaper]::SystemParametersInfo(20, 0, $path, 0x01 -bor 0x02)
