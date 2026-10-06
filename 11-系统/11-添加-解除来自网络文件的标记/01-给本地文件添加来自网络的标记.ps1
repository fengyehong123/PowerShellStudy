<#
    Windows NTFS 文件有一个叫 Zone.Identifier 的 Alternate Data Stream(ADS)
    ZoneId=3 表示这个文件来自 Internet 区域
    当这个标记添加成功之后, 执行脚本或者打开文件的时候
    会出现一个弹窗提示, 询问是否要打开或者执行文件
#>

# 添加来自网络的标记
Set-Content -Path "$($PSScriptRoot)\00-测试文件.ps1" -Stream Zone.Identifier -Value "[ZoneTransfer]`nZoneId=3"

# 查看标记
Get-Item "$($PSScriptRoot)\00-测试文件.ps1" -Stream *

# 
# 就会出现一个弹窗提示, 是否要打开文件

Pause