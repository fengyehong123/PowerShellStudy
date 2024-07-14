# 桌面文件夹路径
$desktop_path = [System.Environment]::GetFolderPath("Desktop")

<#
    ⏹在桌面上创建一个空文件
       -Force 
        当文件存在时,强行覆盖
#> 
New-Item -Path $desktop_path -ItemType File -Name '测试文件1.txt' -Force

<#
    ⏹将获取到的文件列表,通过 Out-File 命令
    在桌面上创建文件,同时指定编码格式
#>
Get-ChildItem -Path $desktop_path | Out-File -FilePath "$($desktop_path)\测试文件2.txt" -Encoding utf8 -Force 
# Out-File 命令 会将控制台上显示的内容原封不动的输出到文件中,内容如下所示
<#
        目录: C:\Users\xxx\Desktop


    Mode                 LastWriteTime         Length Name                                                                                                                                                                                                                       
    ----                 -------------         ------ ----                                                                                                                                                                                                                       
    d-----         2024/6/28     22:07                06月勤務表_交通費                                                                                                                                                                                                                 
    d-----         2024/4/10     20:38                cbc                                                                                                                                                                                                                        
    d-----          2021/8/1     16:16                command                                                                                                                                                                                                                    
    d-----          2023/9/3     22:57                Git_Test       
#>

# ⏹通过 Set-Content 命令,在桌面上创建文件
Get-ChildItem -Path $desktop_path | Set-Content -Path "$($desktop_path)\测试文件3.txt" -Encoding UTF8 -Force
<#
    Set-Content命令不会将对象转换为文本输入,而是会从对象中抽出一个标准属性(例如Name)
    然后输出到文件中
#>
<#
    06月勤務表_交通費
    cbc
    command
    Git_Test
    House
    IDEA配置截图
    JavaTest
    java文章
    Java笔记
    Java项目
    Markdown
    mysql5.5数据库表
    Mysql教育
    Powershell_Study
    powershell脚本文件
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 创建文件,并添加内容
Set-Content -Path "$($desktop_path)\测试文件4.txt" -Encoding UTF8 -Value 'Hello World' -Force
# 向既存的文件中添加内容
Add-Content -Path "$($desktop_path)\测试文件4.txt" -Encoding UTF8 -Value '你好,世界!' -Force
# 获取文件中的内容
Get-Content -Path "$($desktop_path)\测试文件4.txt" | Out-Host
<#
    Hello World
    你好,世界!
#>