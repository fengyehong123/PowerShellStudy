# 检测是否已安装 ImportExcel 模块
$moduleName = "ImportExcel"

# 检查模块是否已安装
if (Get-Module -ListAvailable -Name $moduleName) {
    Write-Host "模块 '$moduleName' 已安装，无需重复安装。"
} else {

    Write-Host "模块 '$moduleName' 未安装。正在执行如下命令安装安装..."
    <#
        安装指定模块到当前用户的命令
        -Force -AllowClobber
            强制安装，忽略Powershell的提示
    #>
    $installModuleCmd = "Install-Module -Name $moduleName -Scope CurrentUser -Force -AllowClobber"
    Write-Host $installModuleCmd -ForegroundColor Red

    try {
        # 创建脚本块并执行
        [ScriptBlock]::Create($installModuleCmd).Invoke()
        Write-Host "模块 '$moduleName' 安装成功！"
    } catch {
        Write-Host "安装模块时发生错误：$_"
    }
}

Read-Host "按 Enter 键退出..."
