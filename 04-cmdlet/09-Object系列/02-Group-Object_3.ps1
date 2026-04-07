# ⏹按照奇偶数分组
1..20 | Group-Object -Property {$_ % 2} | ConvertTo-Json | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red


# 获取桌面上的指定文件夹路径
$target_path = "$($Home)\Desktop\Java笔记\01-Java总结"
<#
    ⏹按照扩展名对文件进行分组
    然后在根据Count属性降序排序
#>
$result = Get-ChildItem -Path $target_path -Recurse -File `
| Group-Object -Property extension `
| Sort-Object -Property Count -Descending
$result | Out-Host
<#
    Count Name    Group
    ----- ----    -----
        6 .txt    {day08.txt, HTTP协议详解.txt, 常用的头信息.txt, day09.txt...}
        5 .md     {Java基础1.md, Java基础2.md, Java基础3.md, Java_Web.md...}
        4 .xmind  {http&web服务器.xmind, Servlet.xmind, day10.xmind, request.xmind}
        4 .pdf    {day08--http&tomcat.pdf, day09--Servlet.pdf, day10--response.pdf, day11--request.pdf}
#>

$validHosts = @("ConsoleHost")
if ($validHosts -contains $host.Name) {
    $host.UI.RawUI.ReadKey()
}

