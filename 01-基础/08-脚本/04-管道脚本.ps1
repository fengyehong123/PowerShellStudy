# 来源
# https://www.pstips.net/powershell-create-pipeline-scripts.html

<#
    在Powershell脚本的处理中，绝大多数情况下遇到的都是集合
    一旦上一条命令产生一个中间结果，下一条命令就对这个中间结果及时处理，及时释放资源。
    这样可以节省内存，也减少了用户的等待时间。在处理大量数据时，尤其值得推荐。
    高速流模式的管道定义包括三部分:
        begin
        process
        end
    上面的描述中提到了中间结果，中间结果保存在$_自动化变量中。
#>
param(
    [string]$path
)

begin {
    Write-Host "管道脚本环境初始化开始....."
    if (-not (Test-Path -Path $path)) {
        "用户输入的 $($path) 不存在,请输入正确的路径!"
        return
    }

    $file_list = Get-ChildItem -Path $path -Recurse -File
    Write-Host "管道脚本环境初始化结束....."
}
process {

    # 创建一个空file对象
    $file = $null

    $file_list | ForEach-Object {

        if ($_.Extension -eq '') {
            return
        }

        $file = $_

        switch ($_.Extension.ToLower()) {
            <#
                此处无法直接在 switch 中使用 $_
                switch 中的 $_ 相当于 $_.Extension.ToLower() 执行后的结果
                而 $_.Extension.ToLower() 中的 $_ 实际上指代的是 ForEach-Object 中的元素
            #>
            ".ps1" {
                Write-Host "脚本文件：$($file.Name)" -ForegroundColor Yellow
            }
            ".txt" {
                Write-Host "文本文件：$($file.Name)"  -ForegroundColor Green
            }
            ".gz"  {
                Write-Host "压缩文件：$($file.Name)" -ForegroundColor Cyan
            }
            Default {
                Write-Host "其他文件: $($file.Name)" -ForegroundColor Red
            }
        }
    }
}
end {
    Write-Host "程序处理完成..."
}