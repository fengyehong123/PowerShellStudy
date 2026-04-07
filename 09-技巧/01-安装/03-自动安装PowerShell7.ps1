# 用户确认的函数
function Confirm-Action($message) {
    do {
        $result = Read-Host "$message (Y/N)"
    } until ($result -match '^(?i)y(es)?$|^n(o)?$')

    return $result -match '^(?i)y(es)?$'
}

# 获取最新Powershell的版本信息
$releaseApi = "https://api.github.com/repos/PowerShell/PowerShell/releases/latest"
$release = Invoke-RestMethod -Uri $releaseApi

# 找到 x64 MSI 安装包
$asset = $release.assets | Where-Object { $_.name -like "*win-x64.msi" }
if (-not $asset) {
    Write-Host "未找到安装包。" -ForegroundColor Red
    Pause
    exit 1
}

# 获取最新的Powershell版本号
$latestVersion = $release.tag_name.TrimStart("v")

# 检查Powershell7是否已经安装
$installed = Get-Command pwsh -ErrorAction SilentlyContinue
if ($installed) {
    $currentVersion = (pwsh -v).Replace("PowerShell ", "")
    Write-Host "当前的Powershell版本: $currentVersion"
}

# 如果Powershell7已经安装, 并且是最新版本的话
if ($installed -and $currentVersion -eq $latestVersion) {
    Write-Host "已是最新版本，无需安装。"
    Pause
    exit
}

# 获取要下载的Powershell7的安装包的url
$downloadUrl = $asset.browser_download_url

# 打印提示信息
Write-Host "最新版本：$($release.tag_name)"
Write-Host "下载地址：$downloadUrl"

if (-not (Confirm-Action "是否下载并安装 PowerShell7?")) {
    Write-Host "已取消安装。"
    Pause
    exit
}

# 下载最新安装包到本地的临时文件夹下
$tempPath = "$env:TEMP\PowerShell7.msi"
Invoke-WebRequest -Uri $downloadUrl -OutFile $tempPath

# 静默安装Powershell7
Start-Process msiexec.exe -ArgumentList "/i `"$tempPath`" /qn /norestart" -Wait

# 提示安装完成, 并使用Powershell7的pwsh命令显示版本号
Write-Host "安装完成！"
pwsh -v

# 删除安装包
Remove-Item -Path "$tempPath" -Force
Pause