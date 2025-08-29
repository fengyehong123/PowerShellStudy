<#
    脚本处理前:
        /logback/c1Ae01a/tomcat/current/logs/spl/.2024033109mpl_test1_app.log:03210429-47789
    脚本处理后:
        grep -a ^03210429-47789 /logback/c1Ae01a/tomcat/current/logs/spl/.2024033109mpl_test1_app.log
#>

# 获取当前文件夹下的所有文件列表，排除 PowerShell 脚本文件
$file_obj_list = Get-ChildItem -Exclude "*.ps1"
$addContentFlag = $false
$splitLine = "`n------------------------------------------------------------------`n"

foreach ($file_obj in $file_obj_list) {

    # 根据文件对象获取文件路径
    $file_full_path = $file_obj.FullName

    # 读取文件内容
    $file_content_list = Get-Content -Path $file_full_path
    $grepCmdList = @()

    foreach ($file_content in $file_content_list) {

        # 按冒号分割内容
        $arry = $file_content.Split(':')
        
        # 检查是否存在冒号分割的两部分
        if ($arry.Length -gt 1) {
            # 拼接grep命令
            $grepCmdList += "grep -a ^$($arry[1].Trim()) $($arry[0].Trim())"
            # 添加换行符
            $grepCmdList += "echo -e `"\n\n`""
        }
    }

    if ($addContentFlag) {
        # 添加分隔线到文件
        $splitLine | Out-File -FilePath $file_full_path -Append -Encoding UTF8
        # 将生成的 grep 命令追加到文件
        $grepCmdList | Out-File -FilePath $file_full_path -Append -Encoding UTF8
    }

    Write-Host "--------$file_full_path--------处理开始。。。" -ForegroundColor Red
    # 将生成的Linux的grep命令输出到控制台
    $grepCmdList | Out-Host
    Write-Host "--------$file_full_path--------处理结束。。。`n" -ForegroundColor Red

    # 清空数组
    $grepCmdList.Clear()
}

Read-Host "按 Enter 键退出..."
