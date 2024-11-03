<#
    ⏹安装处理Excel文件的模块
    该模块由社区开发，不需要安装Excel就能读取和创建Excel文件
    Install-Module -Name ImportExcel -Scope CurrentUser
#>

# 读取 Excel 文件内容
$data = Import-Excel -Path "$HOME\Desktop\存款借款_明细表.xlsx"
Write-Host $data