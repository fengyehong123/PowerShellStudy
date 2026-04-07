# 要安装的插件名称
$addInFileName = "01-MyTool.xlam"
# 插件所在的路径
$sourceAddin = Join-Path $PSScriptRoot $addInFileName

# 创建Excel的COM对象
$excel = New-Object -ComObject Excel.Application
# 非表示
$excel.Visible = $false

# 方式1: 获取Excel的插件目录
# $addInFolderPath = "$env:APPDATA\Microsoft\AddIns\"

# 方式2: 获取Excel的插件目录
$addInFolderPath = $excel.UserLibraryPath
$targetAddinFilePath = Join-Path $addInFolderPath $addInFileName

# 如果Excel插件目录中没有指定的插件的话
if (-not (Test-Path "$targetAddinFilePath")) {
    # 复制当前脚本目录下的插件到Excel插件目录中
    Copy-Item $sourceAddin $targetAddinFilePath -Force
}

try {

    # 创建一个空工作簿
    $excel.Workbooks.Add() | Out-Null
    
    # 遍历所有的插件对象, 注册前, 查看自定义的插件对象是否存在
    $addin = $excel.AddIns | Where-Object {
        $_.Name -eq $addInFileName
    } | Select-Object -First 1

    # 已安装判断
    if ($addin.Installed) {
        throw [System.Exception]::new("插件已安装，无需重复安装...")
    }

    # 添加插件到Excel中
    $addin = $excel.AddIns.Add($targetAddinFilePath, $true)
    if (-not $addin) {
        throw [System.Exception]::new("插件注册失败...")
    }

    # 启用插件
    $addin.Installed = $true
    Write-Host "插件安装成功..."

} catch {
    Write-Host $_
} finally {
    # 退出打开的Excel
    $excel.Quit()
    # 释放Excel的COM对象
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
}

Pause