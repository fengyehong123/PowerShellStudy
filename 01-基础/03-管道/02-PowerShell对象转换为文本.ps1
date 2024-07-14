# 来源
# https://www.pstips.net/powershell-converting-objects-into-text.html

<#
    ⏹Out-Default可以将对象转换成可视的文本
        1. Powershell已经内置Out-Default命令追加在管道的命令串的末尾
           因此 Get-ChildItem 和 Get-ChildItem | Out-Default 作用相同
        2. Out-Default会首先调用Format-Table, 将更多的属性默认隐藏
           再调用Out-Host将结果输出在控制台上
#>
$mysql_study = "$Home\Desktop\Mysql教育"

# ⏹下面的三组命令执行结果是相同的
Get-ChildItem -Path $mysql_study
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

Get-ChildItem -Path $mysql_study | Out-Default
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

Get-ChildItem -Path $mysql_study | Format-Table | Out-Host
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 查看显示所有的属性(属性和属性的内容太多,控制台上显示不全)
Get-ChildItem -Path $mysql_study | Format-Table *
# ⏹可以通过执行文本换行参数 -Wrap 来将显示不全的内容换行
Get-ChildItem -Path $mysql_study | Format-Table * -Wrap
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# ⏹叫脚本块作为属性
Get-ChildItem -Path $mysql_study | Format-Table Name, {[Int]($_.Length / 1kb)}
# 修改列标题
Get-ChildItem -Path $mysql_study | Format-Table Name, @{Label = 'KB'; Expression = {[Int]($_.Length / 1kb)}}
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

<# 
    Powershell的绝大多数输出都是实时的流模式，所以下一条结果的宽度未知
    Powershell的结果会默认采用分散对齐，这样可以最大限度利用控制台的宽度，
    但是可以通过-auto参数对列的宽带进行优化，会将属性值的最大宽带作为每一列的宽度
#>
Get-ChildItem -Path $mysql_study | Format-Table -AutoSize

