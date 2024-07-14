# 来源
# https://www.pstips.net/powershell-define-variable.html

<#
    ⏹在powershell中变量名均是以$开始
    剩余字符可以是数字、字母、下划线的任意字符
#>
$name = "贾飞天"
Write-Host $name # 贾飞天
# 💥Powershell中不区分大小写,也就是说 $name 和 $NaMe 是一个变量
Write-Host $NaMe # 贾飞天
Write-Host '===================================='

# ⏹支持给多个变量同时赋值
$aa = $bb = $cc = "内容"
Write-Host $aa $bb $cc  # 内容 内容 内容

# ⏹无需通过创建临时中间变量,变量值可以直接交换
$name_a = "张三"
$name_b = "李四"
$name_a, $name_b = $name_b, $name_a
Write-Host $name_a, $name_b  # 李四 张三

<#
    ⏹查看正在使用的变量
        Powershell将变量的相关信息的记录存放在名为 variable: 的虚拟驱动中
    可查看定义的所有变量
        简写的方式 → ls variable:

#>
Get-ChildItem variable:
Write-Host '------------------------------------------------'

# ⏹查找以name开头的变量
Get-ChildItem variable:name*
Write-Host '------------------------------------------------'

<#
    ⏹判断一个变量是否存在
        因为变量存在变量驱动器中,因此可以像验证文件系统那样
        使用 Test-Path 来验证
#>
Write-Host (Test-Path variable:name_uuu)  # False

<# 
    ⏹删除变量
        Remove-Item
    变量会在powershell退出或关闭时,自动清除
    一般没必要删除,但是你非得删除,也可以象删除文件那样删除它
#>
if (Test-Path variable:name) {
    Write-Host '开始删除变量'
    Remove-Item variable:name
    Write-Host (Test-Path variable:name)
}

<# 
    ⏹变量的写保护
        使用 New-Variable 的 option选项创建变量时,给变量加上只读属性
#>
New-Variable fengyehong -Value "枫叶红" -Force -Option ReadOnly
Write-Host "变量的名称为:$($fengyehong)"  # 变量的名称为:枫叶红
# 尝试修改变量的值 ⇒ 无法覆盖变量 fengyehong，因为该变量为只读变量或常量。
$fengyehong = '贾飞天'

# 但是可以通过删除变量,在重新创建变量来更新变量的内容
Remove-Item Variable:fengyehong -Force
Write-Host (Test-Path variable:fengyehong)

$fengyehong = '贾飞天'
Write-Host $fengyehong  # 贾飞天

<# 
    ⏹创建常量,一旦生成,无法修改
#>
New-Variable address -Value '地球' -Option Constant
Write-Host $address  # 地球

<#
    ⏹添加并查看变量的描述
#>
New-Variable car -Value '丰田' -Description '我的第一辆车!'
Write-Host "car变量的值为: $($car)"
Write-Host '------------------------------------------------'

# 通过 Format-List 查看变量描述
Get-ChildItem Variable:car | Format-List *  # 查看该变量的所有信息
# 仅查看该变量的描述
Get-ChildItem Variable:car | Format-List Description
Write-Host '------------------------------------------------'

<#
    Select-Object：用于选择并显示对象的属性
    -ExpandProperty参数：用于展开属性值,而不是只显示属性的名称
#>
Get-ChildItem Variable:car | Select-Object -ExpandProperty Description
Write-Host '------------------------------------------------'

# 如果是控制台环境,暂停脚本执行,等待用户输入
$validHosts = @("ConsoleHost", "Visual Studio Code Host")
if ($validHosts -contains $host.Name) {
    $host.UI.RawUI.ReadKey()
}