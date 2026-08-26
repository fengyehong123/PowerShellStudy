# 解除之前进行查看
Get-Item "$($PSScriptRoot)\00-测试文件.ps1" -Stream *
Write-Output "---------------------------------------------------"

# 直接使用 Unblock-File 函数就可以解除来自网络的标记
Unblock-File "$($PSScriptRoot)\00-测试文件.ps1" | Out-Null

# 解除之后再次进行查看
Get-Item "$($PSScriptRoot)\00-测试文件.ps1" -Stream *

Pause