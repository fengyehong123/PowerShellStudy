# 注册表文件的路径
$regeditFilePath = "${PSScriptRoot}\01-AddZipMenu.reg"

# 必须用 管理员权限运行 PowerShell，否则可能报错 Access is denied
if (!(Test-Path $regeditFilePath)) {
    Write-Error "注册表文件不存在"
    return
}

try {
    # -Verb RunAs
    #   以管理员的方式进行注册表添加
    Start-Process regedit.exe -ArgumentList "/s ${regeditFilePath}" -Verb RunAs
    Write-Host '注册表添加成功...'
} catch {
    Write-Host "程序发生异常, 异常的原因是: $($_.Exception.Message)"
}

Pause
