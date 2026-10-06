# -----------------------------------------------
# 1️⃣ 获取 Microsoft Store 应用安装的 UWP 软件
# -----------------------------------------------
# [PSCustomObject]$UWPSoftware = Get-AppxPackage |
#     Where-Object { $_.InstallLocation } |
#     Select-Object `
#         @{Name='DisplayName';Expression={$_.Name}},
#         InstallLocation,
#         @{Name='DisplayVersion';Expression={$_.Version}},
#         Publisher,
#         InstallDate

# -----------------------------
# 2️⃣ 获取通过注册表安装的传统软件
# -----------------------------
[PSCustomObject]$TraditionalSoftware = Get-ItemProperty `
    HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* , `
    HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* , `
    HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |

    # 只保留有名称和安装路径的软件
    Where-Object { $_.DisplayName -and $_.InstallLocation } |
    
    # 选择输出字段
    Select-Object `
        DisplayName, `
        InstallLocation, `
        DisplayVersion, `
        Publisher, `
        InstallDate |
    
    # 按名称排序
    Sort-Object DisplayName |
    
    # 按软件名称分组去重
    Group-Object DisplayName |
    ForEach-Object { $_.Group[0] };

# -----------------------------------------------------
# 3️⃣ 合并 注册表安装的传统软件 + UWP 软件信息
# -----------------------------------------------------
# [PSCustomObject]$AllSoftware = $UWPSoftware + $TraditionalSoftware
# $AllSoftware | Out-Host

$TraditionalSoftware | Out-Host

# 暂停脚本执行
Pause
