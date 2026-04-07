$TeraTermConfigPath = "${env:APPDATA}\teraterm5\TERATERM.INI"

if (-not (Test-Path "$TeraTermConfigPath")) {
    Write-Host "找不到,请确认teraterm配置文件的路径"
    exit
}

# 读取配置文件, 替换为指定的内容
(Get-Content "$TeraTermConfigPath") `
-replace '^LogDefaultPath=.*$' , "LogDefaultPath=$Home\Desktop" `
-replace '^ViewlogEditor=.*$'  , "ViewlogEditor=${env:ProgramFiles(x86)}\Hidemaru\Hidemaru.exe" | `
Set-Content "$TeraTermConfigPath"